#!/usr/bin/env python3
"""
Enhanced ETL script for Side Effect Estimator.
Orchestrates parsing and loading from all data sources including ChEMBL, BindingDB, and PubChem.
"""

import os
import sys
import argparse
import psycopg2
from dotenv import load_dotenv
from pathlib import Path

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent))

from parsers.drugbank_parser import DrugBankParser
from parsers.sider_parser import SIDERParser
from parsers.pubchem_parser import PubChemParser
from parsers.chembl_parser import ChEMBLParser
from parsers.local_chembl_parser import LocalChEMBLParser
from parsers.bindingdb_parser import BindingDBParser
from loaders.database_loader import DatabaseLoader


def get_db_connection():
    """Create database connection from environment variables."""
    try:
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            port=os.getenv('DB_PORT', '5432'),
            database=os.getenv('DB_NAME', 'side_effect_estimator'),
            user=os.getenv('DB_USER', 'postgres'),
            password=os.getenv('DB_PASSWORD')
        )
        return conn
    except psycopg2.Error as e:
        print(f"Error connecting to database: {e}")
        sys.exit(1)


def run_base_etl(loader, skip_base=False):
    """Run base ETL (DrugBank + SIDER)."""
    if skip_base:
        print("Skipping base ETL (assuming data already loaded)")
        return {}, {}
    
    print("\n" + "="*70)
    print("PHASE 1: Base Data Sources (DrugBank + SIDER)")
    print("="*70)
    
    # Parse DrugBank
    drugbank_xml = os.getenv('DRUGBANK_XML_PATH')
    if not drugbank_xml or not os.path.exists(drugbank_xml):
        print(f"Error: DrugBank XML not found at {drugbank_xml}")
        sys.exit(1)
    
    print("\n[1/4] Parsing DrugBank XML...")
    drugbank_parser = DrugBankParser(drugbank_xml)
    drugbank_data = drugbank_parser.parse()
    
    # Parse SIDER
    sider_all_se = os.getenv('SIDER_MEDDRA_ALL_SE_PATH')
    sider_freq = os.getenv('SIDER_MEDDRA_FREQ_PATH')
    
    if not sider_all_se or not os.path.exists(sider_all_se):
        print(f"Error: SIDER file not found at {sider_all_se}")
        sys.exit(1)
    
    print("\n[2/4] Parsing SIDER data...")
    sider_parser = SIDERParser(sider_all_se, sider_freq)
    sider_data = sider_parser.parse()
    
    # Load base data
    print("\n[3/4] Loading base data into database...")
    loader.load_drugs(drugbank_data['drugs'])
    loader.load_targets(drugbank_data['targets'])
    loader.load_drug_targets(drugbank_data['drug_targets'])
    loader.load_dosages(drugbank_data['dosages'])
    loader.load_side_effects(sider_data['side_effects'])
    
    # Create PubChem to DrugBank mapping
    print("\n[4/4] Creating PubChem to DrugBank mapping...")
    pubchem_to_drugbank = {}
    for drug in drugbank_data['drugs']:
        if drug.get('pubchem_cid'):
            pubchem_to_drugbank[drug['pubchem_cid']] = drug['drug_id']
    print(f"✓ Mapped {len(pubchem_to_drugbank)} PubChem CIDs to DrugBank IDs")
    
    loader.load_drug_side_effects(sider_data['drug_side_effects'], pubchem_to_drugbank)
    
    return drugbank_data, pubchem_to_drugbank


def run_pubchem_enrichment(loader, enable=True):
    """Enrich drugs with PubChem data."""
    if not enable:
        print("\nSkipping PubChem enrichment (disabled)")
        return
    
    print("\n" + "="*70)
    print("PHASE 2: PubChem Enrichment")
    print("="*70)
    
    # Get drugs that need enrichment (missing SMILES or InChI)
    conn = loader.conn
    with conn.cursor() as cur:
        cur.execute("""
            SELECT drug_id, drug_name, pubchem_cid, smiles, inchikey
            FROM drugs
            WHERE pubchem_cid IS NULL AND inchikey IS NOT NULL
            LIMIT 2000
        """)
        drugs_to_enrich = [
            {
                'drug_id': row[0],
                'drug_name': row[1],
                'pubchem_cid': row[2],
                'smiles': row[3],
                'inchikey': row[4]
            }
            for row in cur.fetchall()
        ]
    
    if not drugs_to_enrich:
        print("No drugs need enrichment")
        return
    
    print(f"\nEnriching {len(drugs_to_enrich)} drugs with missing data...")
    
    pubchem_parser = PubChemParser(
        requests_per_second=int(os.getenv('PUBCHEM_REQUESTS_PER_SECOND', 5))
    )
    enrichments = pubchem_parser.enrich_drugs(drugs_to_enrich)
    
    if enrichments:
        loader.enrich_drugs_from_pubchem(enrichments)


def run_chembl_integration(loader, drugbank_data, enable=True):
    """Add ChEMBL binding affinity data."""
    if not enable:
        print("\nSkipping ChEMBL integration (disabled)")
        return
    
    print("\n" + "="*70)
    print("PHASE 3: ChEMBL Binding Affinities")
    print("="*70)
    
    # Get drugs with InChIKeys for ChEMBL lookup
    conn = loader.conn
    with conn.cursor() as cur:
        cur.execute("""
            SELECT drug_id, inchikey
            FROM drugs
            WHERE inchikey IS NOT NULL
            -- No LIMIT for high detail run
        """)
        drugs_for_chembl = [
            {'drug_id': row[0], 'inchikey': row[1]}
            for row in cur.fetchall()
        ]
    
    if not drugs_for_chembl:
        print("No drugs available for ChEMBL lookup")
        return
    
    # Map key -> id for regrouping
    key_to_id = {d['inchikey']: d['drug_id'] for d in drugs_for_chembl}
    inchikeys = list(key_to_id.keys())

    print(f"\nFetching ChEMBL data for {len(drugs_for_chembl)} drugs...")
    print("Using LocalChEMBLParser (High Performance SQLite)...")
    
    # Use Local Parser
    db_path = 'chembl_36/chembl_36_sqlite/chembl_36.db'
    local_parser = LocalChEMBLParser(db_path)
    
    # Fetch flat list of activities
    flat_activities = local_parser.get_activities_for_inchikeys(
        inchikeys, 
        min_confidence=int(os.getenv('MIN_BINDING_AFFINITY_CONFIDENCE', 5))
    )
    
    if not flat_activities:
        print("No ChEMBL data found")
        return

    # Regroup by drug_id
    chembl_data = {}
    for act in flat_activities:
        key = act['inchikey']
        if key in key_to_id:
            did = key_to_id[key]
            if did not in chembl_data:
                chembl_data[did] = []
            chembl_data[did].append(act)
            
    print(f"grouped {len(flat_activities)} activities into {len(chembl_data)} drugs")
    loader.load_chembl_affinities(chembl_data)


def run_bindingdb_integration(loader, pubchem_to_drugbank, enable=True):
    """Add BindingDB binding affinity data."""
    if not enable:
        print("\nSkipping BindingDB integration (disabled)")
        return
    
    bindingdb_path = os.getenv('BINDINGDB_TSV_PATH')
    if not bindingdb_path or not os.path.exists(bindingdb_path):
        print(f"\nSkipping BindingDB (file not found at {bindingdb_path})")
        return
    
    print("\n" + "="*70)
    print("PHASE 4: BindingDB Binding Affinities")
    print("="*70)
    
    print(f"\nParsing BindingDB from {bindingdb_path}...")
    print("Note: This may take several minutes for large files...")
    
    bindingdb_parser = BindingDBParser(bindingdb_path, filter_human=True)
    bindingdb_data = bindingdb_parser.parse(chunk_size=10000)
    
    # Map to DrugBank IDs
    print("\nMapping BindingDB entries to DrugBank IDs...")
    mapped_bindings = bindingdb_parser.map_to_drugbank(
        bindingdb_data['bindings'],
        pubchem_to_drugbank
    )
    
    print(f"Mapped {len(mapped_bindings)} of {len(bindingdb_data['bindings'])} bindings")
    
    if mapped_bindings:
        loader.load_bindingdb_affinities(mapped_bindings, bindingdb_data['targets'])


def main():
    """Main enhanced ETL pipeline."""
    parser = argparse.ArgumentParser(description='Enhanced ETL Pipeline for Side Effect Estimator')
    parser.add_argument('--skip-base', action='store_true', help='Skip base ETL (DrugBank + SIDER)')
    parser.add_argument('--pubchem-only', action='store_true', help='Only run PubChem enrichment')
    parser.add_argument('--affinities-only', action='store_true', help='Only add binding affinities')
    parser.add_argument('--no-pubchem', action='store_true', help='Disable PubChem enrichment')
    parser.add_argument('--no-chembl', action='store_true', help='Disable ChEMBL integration')
    parser.add_argument('--no-bindingdb', action='store_true', help='Disable BindingDB integration')
    
    args = parser.parse_args()
    
    print("=" * 70)
    print("Side Effect Estimator - Enhanced ETL Pipeline")
    print("=" * 70)
    
    # Load environment variables
    load_dotenv()
    
    # Connect to database
    print("\nConnecting to database...")
    conn = get_db_connection()
    loader = DatabaseLoader(conn)
    print("✓ Connected to database")
    
    # Run base ETL
    drugbank_data = {}
    pubchem_to_drugbank = {}
    
    if not args.pubchem_only and not args.affinities_only:
        drugbank_data, pubchem_to_drugbank = run_base_etl(loader, args.skip_base)
    elif args.skip_base:
        # Load mapping from database
        with conn.cursor() as cur:
            cur.execute("SELECT pubchem_cid, drug_id FROM drugs WHERE pubchem_cid IS NOT NULL")
            pubchem_to_drugbank = {row[0]: row[1] for row in cur.fetchall()}
    
    # Run PubChem enrichment
    if not args.affinities_only and not args.no_pubchem:
        enable_pubchem = os.getenv('ENABLE_PUBCHEM_ENRICHMENT', 'true').lower() == 'true'
        run_pubchem_enrichment(loader, enable_pubchem)
    
    # Run ChEMBL integration
    if not args.pubchem_only and not args.no_chembl:
        enable_chembl = os.getenv('ENABLE_CHEMBL', 'true').lower() == 'true'
        run_chembl_integration(loader, drugbank_data, enable_chembl)
    
    # Run BindingDB integration
    if not args.pubchem_only and not args.no_bindingdb:
        enable_bindingdb = os.getenv('ENABLE_BINDINGDB', 'true').lower() == 'true'
        run_bindingdb_integration(loader, pubchem_to_drugbank, enable_bindingdb)
    
    # Recompute target-side effect links
    if not args.pubchem_only:
        print("\n" + "="*70)
        print("FINAL: Computing Target-Side Effect Aggregations")
        print("="*70)
        loader.compute_target_side_effect_links()
    
    # Print final statistics
    print("\n" + "=" * 70)
    print("Enhanced ETL Pipeline Complete!")
    print("=" * 70)
    
    stats = loader.get_statistics()
    print("\nFinal Database Statistics:")
    print(f"  Drugs:                    {stats['drugs']:,}")
    print(f"  Targets:                  {stats['targets']:,}")
    print(f"  Side Effects:             {stats['side_effects']:,}")
    print(f"  Drug-Target Interactions: {stats['drug_targets']:,}")
    print(f"  Drug-Side Effects:        {stats['drug_side_effects']:,}")
    print(f"  Dosage Records:           {stats['drug_dosages']:,}")
    print(f"  Target-Side Effect Links: {stats['target_side_effects']:,}")
    
    # Show binding affinity breakdown by source
    print("\nBinding Affinity Coverage by Source:")
    with conn.cursor() as cur:
        cur.execute("""
            SELECT source, COUNT(*) as count,
                   COUNT(DISTINCT drug_id) as unique_drugs,
                   COUNT(DISTINCT target_id) as unique_targets
            FROM drug_targets
            WHERE binding_affinity_value IS NOT NULL
            GROUP BY source
            ORDER BY count DESC
        """)
        for row in cur.fetchall():
            print(f"  {row[0]:12s}: {row[1]:6,} measurements ({row[2]:,} drugs, {row[3]:,} targets)")
    
    conn.close()
    print("\n✓ Database connection closed")
    print("\nYour enhanced knowledge base is ready for side effect prediction!")


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("\n\nETL pipeline interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n\nError during ETL pipeline: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
