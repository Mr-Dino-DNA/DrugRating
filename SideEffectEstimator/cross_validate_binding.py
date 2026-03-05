#!/usr/bin/env python3
"""
ChEMBL/BindingDB Cross-Validation Script

Compares binding affinity data between ChEMBL and BindingDB to:
1. Identify high-confidence bindings (confirmed by both sources)
2. Flag potential discrepancies for review
3. Generate quality metrics for drug-target data

Usage:
    python cross_validate_binding.py [--min-overlap 10] [--output results.csv]
"""

import sqlite3
import pandas as pd
import numpy as np
from pathlib import Path
from tqdm import tqdm
import argparse
from collections import defaultdict
import logging

logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger(__name__)


def load_chembl_data(chembl_db_path: str) -> pd.DataFrame:
    """Load binding affinity data from ChEMBL SQLite database."""
    logger.info("Loading ChEMBL binding data...")
    
    conn = sqlite3.connect(chembl_db_path)
    
    query = """
    SELECT 
        cs.canonical_smiles,
        cs.standard_inchi_key,
        td.pref_name as target_name,
        td.chembl_id as target_chembl_id,
        cseq.accession as uniprot_id,
        a.standard_type,
        a.standard_value,
        a.standard_units,
        a.pchembl_value
    FROM activities a
    JOIN assays ass ON a.assay_id = ass.assay_id
    JOIN target_dictionary td ON ass.tid = td.tid
    JOIN compound_structures cs ON a.molregno = cs.molregno
    LEFT JOIN target_components tc ON td.tid = tc.tid
    LEFT JOIN component_sequences cseq ON tc.component_id = cseq.component_id
    WHERE a.standard_type IN ('Ki', 'Kd', 'IC50', 'EC50')
      AND a.standard_value IS NOT NULL
      AND a.standard_units = 'nM'
      AND cs.canonical_smiles IS NOT NULL
    """
    
    df = pd.read_sql_query(query, conn)
    conn.close()
    
    logger.info(f"  Loaded {len(df):,} ChEMBL binding records")
    return df


def load_bindingdb_data(bindingdb_path: str, sample_size: int = None) -> pd.DataFrame:
    """Load binding affinity data from BindingDB TSV file."""
    logger.info("Loading BindingDB binding data...")
    
    # BindingDB columns of interest
    cols_to_use = [
        'Ligand SMILES', 'Ligand InChI Key', 'Target Name',
        'Ki (nM)', 'IC50 (nM)', 'Kd (nM)', 'EC50 (nM)',
        'UniProt (SwissProt) Primary ID of Target Chain'
    ]
    
    # Read in chunks for memory efficiency
    chunks = []
    chunk_iter = pd.read_csv(
        bindingdb_path, 
        sep='\t', 
        usecols=lambda x: x in cols_to_use,
        chunksize=100000,
        low_memory=False,
        on_bad_lines='skip'
    )
    
    for i, chunk in enumerate(tqdm(chunk_iter, desc="Loading BindingDB chunks")):
        chunks.append(chunk)
        if sample_size and (i + 1) * 100000 >= sample_size:
            break
    
    df = pd.concat(chunks, ignore_index=True)
    
    # Rename columns for consistency
    df = df.rename(columns={
        'Ligand SMILES': 'smiles',
        'Ligand InChI Key': 'inchikey',
        'Target Name': 'target_name',
        'UniProt (SwissProt) Primary ID of Target Chain': 'uniprot_id'
    })
    
    # Melt binding types into single column
    binding_types = [('Ki (nM)', 'Ki'), ('IC50 (nM)', 'IC50'), ('Kd (nM)', 'Kd'), ('EC50 (nM)', 'EC50')]
    
    records = []
    for _, row in df.iterrows():
        for col, btype in binding_types:
            if col in row and pd.notna(row.get(col)) and row.get(col) not in ['', ' ']:
                try:
                    value = float(str(row[col]).replace('>', '').replace('<', '').strip())
                    records.append({
                        'smiles': row.get('smiles'),
                        'inchikey': row.get('inchikey'),
                        'target_name': row.get('target_name'),
                        'uniprot_id': row.get('uniprot_id'),
                        'standard_type': btype,
                        'standard_value': value,
                        'source': 'BindingDB'
                    })
                except (ValueError, TypeError):
                    continue
    
    result = pd.DataFrame(records)
    logger.info(f"  Loaded {len(result):,} BindingDB binding records")
    return result


def cross_validate(chembl_df: pd.DataFrame, bindingdb_df: pd.DataFrame) -> dict:
    """
    Cross-validate binding affinities between ChEMBL and BindingDB.
    
    Matches on InChI Key + UniProt ID + binding type.
    """
    logger.info("\nCross-validating binding affinities...")
    
    # Prepare ChEMBL data
    chembl_df = chembl_df.copy()
    chembl_df['inchikey'] = chembl_df['standard_inchi_key'].str[:14]  # First 14 chars (connectivity layer)
    chembl_df['source'] = 'ChEMBL'
    
    # Prepare BindingDB data  
    bindingdb_df = bindingdb_df.copy()
    bindingdb_df['inchikey'] = bindingdb_df['inchikey'].str[:14]
    
    # Create match keys
    chembl_df['match_key'] = chembl_df['inchikey'] + '|' + chembl_df['uniprot_id'].fillna('') + '|' + chembl_df['standard_type']
    bindingdb_df['match_key'] = bindingdb_df['inchikey'] + '|' + bindingdb_df['uniprot_id'].fillna('') + '|' + bindingdb_df['standard_type']
    
    # Find overlapping entries
    chembl_keys = set(chembl_df['match_key'].dropna())
    bindingdb_keys = set(bindingdb_df['match_key'].dropna())
    
    overlap_keys = chembl_keys & bindingdb_keys
    
    logger.info(f"  ChEMBL unique drug-target pairs: {len(chembl_keys):,}")
    logger.info(f"  BindingDB unique drug-target pairs: {len(bindingdb_keys):,}")
    logger.info(f"  Overlapping pairs: {len(overlap_keys):,}")
    
    # Compare values for overlapping entries
    results = {
        'total_overlap': len(overlap_keys),
        'agreements': [],
        'discrepancies': [],
        'high_confidence': []
    }
    
    chembl_grouped = chembl_df.groupby('match_key')['standard_value'].agg(['mean', 'std', 'count']).reset_index()
    chembl_grouped.columns = ['match_key', 'chembl_mean', 'chembl_std', 'chembl_count']
    
    bindingdb_grouped = bindingdb_df.groupby('match_key')['standard_value'].agg(['mean', 'std', 'count']).reset_index()
    bindingdb_grouped.columns = ['match_key', 'bindingdb_mean', 'bindingdb_std', 'bindingdb_count']
    
    # Merge
    merged = pd.merge(chembl_grouped, bindingdb_grouped, on='match_key', how='inner')
    
    for _, row in merged.iterrows():
        chembl_val = row['chembl_mean']
        bindingdb_val = row['bindingdb_mean']
        
        # Calculate log ratio (since binding affinities span orders of magnitude)
        if chembl_val > 0 and bindingdb_val > 0:
            log_ratio = abs(np.log10(chembl_val) - np.log10(bindingdb_val))
            
            entry = {
                'match_key': row['match_key'],
                'chembl_value': chembl_val,
                'bindingdb_value': bindingdb_val,
                'log_ratio': log_ratio,
                'combined_count': row['chembl_count'] + row['bindingdb_count']
            }
            
            # Within 1 order of magnitude = agreement
            if log_ratio <= 1.0:
                results['agreements'].append(entry)
                
                # High confidence if multiple measurements in both
                if row['chembl_count'] >= 2 and row['bindingdb_count'] >= 2:
                    results['high_confidence'].append(entry)
            else:
                results['discrepancies'].append(entry)
    
    return results


def generate_report(results: dict, output_path: str = None):
    """Generate cross-validation report."""
    
    logger.info("\n" + "=" * 60)
    logger.info("CROSS-VALIDATION REPORT")
    logger.info("=" * 60)
    
    total = results['total_overlap']
    agreements = len(results['agreements'])
    discrepancies = len(results['discrepancies'])
    high_conf = len(results['high_confidence'])
    
    logger.info(f"\nOverlapping drug-target pairs: {total:,}")
    logger.info(f"Agreements (within 1 order of magnitude): {agreements:,} ({100*agreements/max(1,total):.1f}%)")
    logger.info(f"Discrepancies: {discrepancies:,} ({100*discrepancies/max(1,total):.1f}%)")
    logger.info(f"High-confidence (multiple measurements): {high_conf:,}")
    
    if output_path:
        # Save all results
        all_data = results['agreements'] + results['discrepancies']
        df = pd.DataFrame(all_data)
        df['status'] = df['log_ratio'].apply(lambda x: 'agreement' if x <= 1.0 else 'discrepancy')
        df.to_csv(output_path, index=False)
        logger.info(f"\nResults saved to: {output_path}")
        
        # Save high-confidence pairs separately
        if results['high_confidence']:
            hc_df = pd.DataFrame(results['high_confidence'])
            hc_path = output_path.replace('.csv', '_high_confidence.csv')
            hc_df.to_csv(hc_path, index=False)
            logger.info(f"High-confidence pairs saved to: {hc_path}")
    
    return results


def main():
    parser = argparse.ArgumentParser(description='Cross-validate ChEMBL and BindingDB binding affinities')
    parser.add_argument('--chembl', default='/home/michael/SideEffectEstimator/chembl_36/chembl_36_sqlite/chembl_36.db',
                        help='Path to ChEMBL SQLite database')
    parser.add_argument('--bindingdb', default='/home/michael/SideEffectEstimator/BindingDB_All.tsv',
                        help='Path to BindingDB TSV file')
    parser.add_argument('--output', default='cross_validation_results.csv',
                        help='Output CSV path')
    parser.add_argument('--sample', type=int, default=500000,
                        help='Sample size for BindingDB (for faster testing)')
    
    args = parser.parse_args()
    
    # Load data
    chembl_df = load_chembl_data(args.chembl)
    bindingdb_df = load_bindingdb_data(args.bindingdb, sample_size=args.sample)
    
    # Cross-validate
    results = cross_validate(chembl_df, bindingdb_df)
    
    # Generate report
    generate_report(results, args.output)
    
    logger.info("\n✓ Cross-validation complete!")


if __name__ == '__main__':
    main()
