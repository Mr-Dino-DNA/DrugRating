#!/usr/bin/env python3
"""
Training Data Export Script

Exports database contents to training-ready formats:
1. Drug fingerprints matrix (for similarity-based training)
2. Drug-side effect label matrix (target labels)
3. Drug-target binding matrix (features)
4. Active probabilities (pre-computed features)

Output formats:
- NumPy .npz files for fast loading
- CSV files for inspection/debugging

Usage:
    python export_training_data.py [--output-dir ./training_data]
"""

import os
import sys
import psycopg2
import numpy as np
import pandas as pd
from pathlib import Path
from dotenv import load_dotenv
from tqdm import tqdm
from scipy import sparse
import argparse
import pickle
import logging

logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger(__name__)


def get_db_connection():
    """Create database connection from environment variables."""
    load_dotenv()
    
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        port=os.getenv('DB_PORT', '5432'),
        database=os.getenv('DB_NAME', 'side_effect_estimator'),
        user=os.getenv('DB_USER', 'postgres'),
        password=os.getenv('DB_PASSWORD')
    )
    return conn


def export_drug_fingerprints(conn, output_dir: Path):
    """
    Export drug fingerprints as a dense matrix.
    
    Output:
        fingerprints.npz: Contains 'fingerprints' (N_drugs x 2048) and 'drug_ids' array
    """
    logger.info("\n[1/5] Exporting drug fingerprints...")
    
    with conn.cursor() as cur:
        cur.execute("""
            SELECT drug_id, drug_name, smiles, fingerprint_morgan2048::text
            FROM drugs 
            WHERE fingerprint_morgan2048 IS NOT NULL
            ORDER BY drug_id
        """)
        rows = cur.fetchall()
    
    drug_ids = []
    drug_names = []
    smiles_list = []
    fingerprints = []
    
    for drug_id, drug_name, smiles, fp_binary in tqdm(rows, desc="Processing fingerprints"):
        if fp_binary and len(fp_binary) == 2048:
            drug_ids.append(drug_id)
            drug_names.append(drug_name)
            smiles_list.append(smiles)
            # Convert binary string to numpy array
            fp_array = np.array([int(b) for b in fp_binary], dtype=np.uint8)
            fingerprints.append(fp_array)
    
    fingerprints = np.array(fingerprints)
    
    # Save as npz
    np.savez_compressed(
        output_dir / 'fingerprints.npz',
        fingerprints=fingerprints,
        drug_ids=np.array(drug_ids),
        drug_names=np.array(drug_names),
        smiles=np.array(smiles_list)
    )
    
    logger.info(f"  Exported {len(drug_ids):,} drug fingerprints ({fingerprints.shape})")
    return drug_ids


def export_drug_side_effects(conn, drug_ids: list, output_dir: Path):
    """
    Export drug-side effect associations as a label matrix.
    
    Output:
        side_effect_labels.npz: Contains 'labels' (N_drugs x N_side_effects) sparse matrix
    """
    logger.info("\n[2/5] Exporting drug-side effect labels...")
    
    # Get side effects
    with conn.cursor() as cur:
        cur.execute("SELECT side_effect_id, side_effect_name FROM side_effects ORDER BY side_effect_id")
        side_effects = cur.fetchall()
    
    se_id_to_idx = {se_id: idx for idx, (se_id, se_name) in enumerate(side_effects)}
    drug_id_to_idx = {did: idx for idx, did in enumerate(drug_ids)}
    
    # Get drug-side effect associations
    with conn.cursor() as cur:
        cur.execute("""
            SELECT drug_id, side_effect_id, source
            FROM drug_side_effects
        """)
        associations = cur.fetchall()
    
    # Build sparse matrix
    rows = []
    cols = []
    sources = []
    
    for drug_id, se_id, source in associations:
        if drug_id in drug_id_to_idx and se_id in se_id_to_idx:
            rows.append(drug_id_to_idx[drug_id])
            cols.append(se_id_to_idx[se_id])
            sources.append(source)
    
    # Create sparse label matrix
    labels = sparse.csr_matrix(
        (np.ones(len(rows)), (rows, cols)),
        shape=(len(drug_ids), len(side_effects)),
        dtype=np.uint8
    )
    
    # Save
    sparse.save_npz(output_dir / 'side_effect_labels.npz', labels)
    
    # Also save side effect names for reference
    se_names = [se[1] for se in side_effects]
    se_ids = [se[0] for se in side_effects]
    np.savez_compressed(
        output_dir / 'side_effect_info.npz',
        side_effect_ids=np.array(se_ids),
        side_effect_names=np.array(se_names)
    )
    
    logger.info(f"  Exported {len(rows):,} drug-SE associations")
    logger.info(f"  Label matrix shape: {labels.shape}, density: {labels.nnz / np.prod(labels.shape):.4f}")
    
    return se_id_to_idx


def export_drug_targets(conn, drug_ids: list, output_dir: Path):
    """
    Export drug-target interactions as a feature matrix.
    
    Output:
        drug_target_features.npz: Contains 'features' (N_drugs x N_targets) sparse matrix
    """
    logger.info("\n[3/5] Exporting drug-target features...")
    
    # Get targets
    with conn.cursor() as cur:
        cur.execute("SELECT target_id, target_name, gene_symbol FROM targets ORDER BY target_id")
        targets = cur.fetchall()
    
    target_id_to_idx = {tid: idx for idx, (tid, _, _) in enumerate(targets)}
    drug_id_to_idx = {did: idx for idx, did in enumerate(drug_ids)}
    
    # Get drug-target interactions with binding affinity
    with conn.cursor() as cur:
        cur.execute("""
            SELECT drug_id, target_id, binding_affinity_value, binding_affinity_type, source
            FROM drug_targets
            WHERE binding_affinity_value IS NOT NULL
        """)
        interactions = cur.fetchall()
    
    # Build feature matrix (use pKi/pIC50 values for better scaling)
    rows = []
    cols = []
    values = []
    
    for drug_id, target_id, affinity, affinity_type, source in interactions:
        if drug_id in drug_id_to_idx and target_id in target_id_to_idx:
            rows.append(drug_id_to_idx[drug_id])
            cols.append(target_id_to_idx[target_id])
            # Convert to pValue (negative log10) for nM values
            if affinity > 0:
                pvalue = -np.log10(affinity * 1e-9)  # Convert nM to M then take -log10
                values.append(min(pvalue, 12))  # Cap at 12 (1 pM)
            else:
                values.append(0)
    
    # Create sparse feature matrix
    features = sparse.csr_matrix(
        (values, (rows, cols)),
        shape=(len(drug_ids), len(targets)),
        dtype=np.float32
    )
    
    # Save
    sparse.save_npz(output_dir / 'drug_target_features.npz', features)
    
    # Save target info
    target_ids = [t[0] for t in targets]
    target_names = [t[1] for t in targets]
    gene_symbols = [t[2] for t in targets]
    np.savez_compressed(
        output_dir / 'target_info.npz',
        target_ids=np.array(target_ids),
        target_names=np.array(target_names, dtype=object),
        gene_symbols=np.array(gene_symbols, dtype=object)
    )
    
    logger.info(f"  Exported {len(values):,} drug-target interactions")
    logger.info(f"  Feature matrix shape: {features.shape}")
    
    return target_id_to_idx


def export_target_side_effects(conn, output_dir: Path):
    """
    Export target-side effect links for mechanistic predictions.
    
    Output:
        target_side_effects.npz: Links from targets to side effects with confidence scores
    """
    logger.info("\n[4/5] Exporting target-side effect links...")
    
    with conn.cursor() as cur:
        cur.execute("""
            SELECT target_id, side_effect_id, evidence_count, confidence_score
            FROM target_side_effects
            ORDER BY target_id, side_effect_id
        """)
        links = cur.fetchall()
    
    if links:
        df = pd.DataFrame(links, columns=['target_id', 'side_effect_id', 'evidence_count', 'confidence_score'])
        df.to_csv(output_dir / 'target_side_effects.csv', index=False)
        logger.info(f"  Exported {len(links):,} target-SE links")
    else:
        logger.info("  No target-SE links found (run ETL first)")


def export_active_probabilities(conn, output_dir: Path):
    """
    Export active probability predictions.
    
    Output:
        active_probabilities.npz: Pre-computed target binding probabilities
    """
    logger.info("\n[5/5] Exporting active probabilities...")
    
    with conn.cursor() as cur:
        cur.execute("""
            SELECT target_id, gene_names, active_probability, non_active_probability
            FROM active_probabilities
            WHERE active_probability IS NOT NULL
            ORDER BY target_id
        """)
        probs = cur.fetchall()
    
    if probs:
        df = pd.DataFrame(probs, columns=['target_id', 'gene_names', 'active_probability', 'non_active_probability'])
        df.to_csv(output_dir / 'active_probabilities.csv', index=False)
        
        # Also save as npz for fast loading
        np.savez_compressed(
            output_dir / 'active_probabilities.npz',
            target_ids=np.array(df['target_id']),
            gene_names=np.array(df['gene_names'], dtype=object),
            active_prob=np.array(df['active_probability']),
            non_active_prob=np.array(df['non_active_probability'])
        )
        logger.info(f"  Exported {len(probs):,} active probability predictions")
    else:
        logger.info("  No active probabilities found (load them first)")


def create_metadata(output_dir: Path, stats: dict):
    """Create metadata file documenting the export."""
    import json
    from datetime import datetime
    
    metadata = {
        'export_date': datetime.now().isoformat(),
        'statistics': stats,
        'files': {
            'fingerprints.npz': 'Drug Morgan fingerprints (N_drugs x 2048)',
            'side_effect_labels.npz': 'Drug-SE label matrix (sparse, N_drugs x N_SE)',
            'side_effect_info.npz': 'Side effect IDs and names',
            'drug_target_features.npz': 'Drug-target binding features (sparse, N_drugs x N_targets)',
            'target_info.npz': 'Target IDs, names, and gene symbols',
            'target_side_effects.csv': 'Target-SE links with confidence scores',
            'active_probabilities.csv': 'Pre-computed target binding probabilities'
        },
        'usage': """
# Load fingerprints
data = np.load('fingerprints.npz')
fingerprints = data['fingerprints']  # (N_drugs, 2048)
drug_ids = data['drug_ids']

# Load labels (sparse)
from scipy import sparse
labels = sparse.load_npz('side_effect_labels.npz')

# Load features (sparse)
features = sparse.load_npz('drug_target_features.npz')
"""
    }
    
    with open(output_dir / 'metadata.json', 'w') as f:
        json.dump(metadata, f, indent=2)


def main():
    parser = argparse.ArgumentParser(description='Export database to training-ready format')
    parser.add_argument('--output-dir', default='./training_data', help='Output directory')
    args = parser.parse_args()
    
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    logger.info("=" * 60)
    logger.info("Training Data Export")
    logger.info("=" * 60)
    
    conn = get_db_connection()
    
    try:
        # Export all data
        drug_ids = export_drug_fingerprints(conn, output_dir)
        se_id_to_idx = export_drug_side_effects(conn, drug_ids, output_dir)
        target_id_to_idx = export_drug_targets(conn, drug_ids, output_dir)
        export_target_side_effects(conn, output_dir)
        export_active_probabilities(conn, output_dir)
        
        # Create metadata
        stats = {
            'n_drugs': len(drug_ids),
            'n_side_effects': len(se_id_to_idx),
            'n_targets': len(target_id_to_idx)
        }
        create_metadata(output_dir, stats)
        
        logger.info("\n" + "=" * 60)
        logger.info("Export Complete!")
        logger.info("=" * 60)
        logger.info(f"\nOutput directory: {output_dir.absolute()}")
        logger.info(f"\nStatistics:")
        logger.info(f"  Drugs:        {stats['n_drugs']:,}")
        logger.info(f"  Side Effects: {stats['n_side_effects']:,}")
        logger.info(f"  Targets:      {stats['n_targets']:,}")
        
    finally:
        conn.close()


if __name__ == '__main__':
    main()
