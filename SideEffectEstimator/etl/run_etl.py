#!/usr/bin/env python3
"""
Main ETL script for Side Effect Estimator.
Orchestrates parsing and loading of DrugBank, SIDER, and OnSIDES data.
"""

import os
import sys
import psycopg2
from dotenv import load_dotenv
from pathlib import Path

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent))

from parsers.drugbank_parser import DrugBankParser
from parsers.sider_parser import SIDERParser
from parsers.onsides_parser import OnSIDESParser
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
        print("\nPlease ensure:")
        print("  1. PostgreSQL is running")
        print("  2. Database exists (or run database/init_db.py first)")
        print("  3. .env file has correct credentials")
        sys.exit(1)


def validate_files():
    """Validate that required data files exist."""
    drugbank_xml = os.getenv('DRUGBANK_XML_PATH')
    sider_all_se = os.getenv('SIDER_MEDDRA_ALL_SE_PATH')
    sider_freq = os.getenv('SIDER_MEDDRA_FREQ_PATH')
    
    missing = []
    
    if not drugbank_xml or not os.path.exists(drugbank_xml):
        missing.append(f"DrugBank XML: {drugbank_xml}")
    
    if not sider_all_se or not os.path.exists(sider_all_se):
        missing.append(f"SIDER MedDRA All SE: {sider_all_se}")
    
    if missing:
        print("Error: Required data files not found:")
        for m in missing:
            print(f"  - {m}")
        print("\nPlease update paths in .env file")
        sys.exit(1)
    
    return drugbank_xml, sider_all_se, sider_freq


def main():
    """Main ETL pipeline."""
    print("=" * 70)
    print("Side Effect Estimator - ETL Pipeline")
    print("=" * 70)
    
    # Load environment variables
    load_dotenv()
    
    # Check if OnSIDES is enabled
    enable_onsides = os.getenv('ENABLE_ONSIDES', 'false').lower() == 'true'
    total_steps = 7 if enable_onsides else 6
    
    # Validate files
    print(f"\n[1/{total_steps}] Validating data files...")
    drugbank_xml, sider_all_se, sider_freq = validate_files()
    print("✓ All required files found")
    
    # Parse DrugBank
    print(f"\n[2/{total_steps}] Parsing DrugBank XML...")
    drugbank_parser = DrugBankParser(drugbank_xml)
    drugbank_data = drugbank_parser.parse()
    
    # Parse SIDER
    print(f"\n[3/{total_steps}] Parsing SIDER data...")
    sider_parser = SIDERParser(sider_all_se, sider_freq)
    sider_data = sider_parser.parse()
    
    # Parse OnSIDES (if enabled)
    onsides_data = None
    if enable_onsides:
        print(f"\n[4/{total_steps}] Parsing OnSIDES data...")
        onsides_dir = os.getenv('ONSIDES_CSV_DIR')
        min_confidence = float(os.getenv('ONSIDES_MIN_CONFIDENCE', '0.5'))
        
        if onsides_dir and os.path.exists(onsides_dir):
            onsides_parser = OnSIDESParser(onsides_dir, min_confidence=min_confidence)
            onsides_data = onsides_parser.parse()
        else:
            print(f"Warning: OnSIDES directory not found: {onsides_dir}")
            print("Skipping OnSIDES data...")
    
    # Connect to database
    step_db = 5 if enable_onsides else 4
    print(f"\n[{step_db}/{total_steps}] Connecting to database...")
    conn = get_db_connection()
    loader = DatabaseLoader(conn)
    print("✓ Connected to database")
    
    # Load data
    step_load = 6 if enable_onsides else 5
    print(f"\n[{step_load}/{total_steps}] Loading data into database...")
    
    # Load DrugBank data
    loader.load_drugs(drugbank_data['drugs'])
    loader.load_targets(drugbank_data['targets'])
    loader.load_drug_targets(drugbank_data['drug_targets'])
    loader.load_dosages(drugbank_data['dosages'])
    
    # Load SIDER side effects first (to populate side_effects table)
    loader.load_side_effects(sider_data['side_effects'])
    
    # Load OnSIDES side effects (adds new ones, updates existing)
    if onsides_data:
        print("\nLoading OnSIDES side effects (MedDRA terms)...")
        loader.load_side_effects(onsides_data['side_effects'])
    
    # Create PubChem CID to DrugBank ID mapping for SIDER
    print("\nCreating PubChem to DrugBank mapping...")
    pubchem_to_drugbank = {}
    for drug in drugbank_data['drugs']:
        if drug.get('pubchem_cid'):
            try:
                # SIDER parser returns int CIDs, so we must match types
                cid = int(drug['pubchem_cid'])
                pubchem_to_drugbank[cid] = drug['drug_id']
            except (ValueError, TypeError):
                continue
    print(f"✓ Mapped {len(pubchem_to_drugbank)} PubChem CIDs to DrugBank IDs")
    
    # Load SIDER drug-side effects
    loader.load_drug_side_effects(sider_data['drug_side_effects'], pubchem_to_drugbank)
    
    # Load OnSIDES drug-side effects
    if onsides_data:
        print("\nLoading OnSIDES drug-side effect associations...")
        loader.load_onsides_drug_side_effects(onsides_data['drug_side_effects'])
    
    # Compute target-side effect links
    step_compute = 7 if enable_onsides else 6
    print(f"\n[{step_compute}/{total_steps}] Computing target-side effect aggregations...")
    loader.compute_target_side_effect_links()
    
    # Print statistics
    print("\n" + "=" * 70)
    print("ETL Pipeline Complete!")
    print("=" * 70)
    
    stats = loader.get_statistics()
    print("\nDatabase Statistics:")
    print(f"  Drugs:                    {stats['drugs']:,}")
    print(f"  Targets:                  {stats['targets']:,}")
    print(f"  Side Effects:             {stats['side_effects']:,}")
    print(f"  Drug-Target Interactions: {stats['drug_targets']:,}")
    print(f"  Drug-Side Effects:        {stats['drug_side_effects']:,}")
    print(f"  Dosage Records:           {stats['drug_dosages']:,}")
    print(f"  Target-Side Effect Links: {stats['target_side_effects']:,}")
    
    conn.close()
    print("\n✓ Database connection closed")
    print("\nYou can now use the knowledge base for side effect prediction!")


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
