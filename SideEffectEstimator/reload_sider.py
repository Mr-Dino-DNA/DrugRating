#!/usr/bin/env python3
"""
Reload SIDER data using updated PubChem CIDs from database.
"""

import os
import sys
import psycopg2
from dotenv import load_dotenv
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from etl.parsers.sider_parser import SIDERParser
from etl.loaders.database_loader import DatabaseLoader

def main():
    print("=" * 70)
    print("Reloading SIDER Data")
    print("=" * 70)
    
    load_dotenv()
    
    # Connect
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        database=os.getenv('DB_NAME', 'side_effect_estimator'),
        user=os.getenv('DB_USER', 'michael'),
        password=os.getenv('DB_PASSWORD')
    )
    
    # 1. Get PubChem CIDs from Database (updated by Enrichment)
    print("\nFetching current PubChem CIDs from database...")
    with conn.cursor() as cur:
        cur.execute("SELECT pubchem_cid, drug_id FROM drugs WHERE pubchem_cid IS NOT NULL")
        pubchem_to_drugbank = {str(row[0]): row[1] for row in cur.fetchall()}
        # Handle int/str mismatch just in case
        for k, v in list(pubchem_to_drugbank.items()):
            try:
                # SIDER uses flat CIDs (integer compatible)
                # Ensure mapping covers string representations of ints
                pubchem_to_drugbank[str(int(k))] = v
            except:
                pass
                
    print(f"✓ Found {len(pubchem_to_drugbank)} drugs with PubChem CIDs")
    
    if not pubchem_to_drugbank:
        print("Error: No PubChem CIDs found in database. Enrichment failed or wasn't run.")
        return 1
    
    # 2. Parse SIDER
    print("\nParsing SIDER files...")
    sider_all_se = os.getenv('SIDER_MEDDRA_ALL_SE_PATH')
    sider_freq = os.getenv('SIDER_MEDDRA_FREQ_PATH')
    
    if not sider_all_se:
        print("Error: SIDER path not set")
        return 1
        
    sider_parser = SIDERParser(sider_all_se, sider_freq)
    sider_data = sider_parser.parse()
    
    # 3. Load Drug-Side Effects
    print("\nLoading drug-side effect associations...")
    loader = DatabaseLoader(conn)
    loader.load_drug_side_effects(sider_data['drug_side_effects'], pubchem_to_drugbank)
    
    # 4. Compute Links
    print("\nComputing target-side effect links...")
    loader.compute_target_side_effect_links()
    
    # Stats
    stats = loader.get_statistics()
    print("\nUpdated Statistics:")
    print(f"  Drug-Side Effects:        {stats['drug_side_effects']:,}")
    print(f"  Target-Side Effect Links: {stats['target_side_effects']:,}")
    
    conn.close()
    return 0

if __name__ == "__main__":
    sys.exit(main())
