#!/usr/bin/env python3
"""
Enrich a specific drug with PubChem data.
"""

import os
import sys
import psycopg2
from dotenv import load_dotenv
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from etl.parsers.pubchem_parser import PubChemParser
from etl.loaders.database_loader import DatabaseLoader

def main():
    if len(sys.argv) < 2:
        print("Usage: python enrich_specific.py <drug_name>")
        return 1
        
    drug_name = sys.argv[1]
    print(f"Enriching {drug_name}...")
    
    load_dotenv()
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        database=os.getenv('DB_NAME', 'side_effect_estimator'),
        user=os.getenv('DB_USER', 'michael'),
        password=os.getenv('DB_PASSWORD')
    )
    
    # Get drug details
    with conn.cursor() as cur:
        cur.execute("""
            SELECT drug_id, drug_name, pubchem_cid, smiles, inchikey
            FROM drugs
            WHERE drug_name ILIKE %s
        """, (f'%{drug_name}%',))
        row = cur.fetchone()
        
    if not row:
        print(f"Drug matching '{drug_name}' not found in database.")
        conn.close()
        return 1
        
    drug_data = {
        'drug_id': row[0],
        'drug_name': row[1],
        'pubchem_cid': row[2],
        'smiles': row[3],
        'inchikey': row[4]
    }
    
    print(f"Found drug: {drug_data['drug_name']} (ID: {drug_data['drug_id']})")
    
    if drug_data['pubchem_cid']:
        print(f"Drug already has PubChem CID: {drug_data['pubchem_cid']}")
    
    # Enrich
    parser = PubChemParser()
    enrichments = parser.enrich_drugs([drug_data])
    
    if enrichments:
        print(f"Enrichment successful! CID: {enrichments[0].get('pubchem_cid')}")
        loader = DatabaseLoader(conn)
        loader.enrich_drugs_from_pubchem(enrichments)
        print("Updated database.")
    else:
        print("Enrichment failed (no data found in PubChem).")
        
    conn.close()
    return 0

if __name__ == "__main__":
    sys.exit(main())
