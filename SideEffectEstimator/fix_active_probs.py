#!/usr/bin/env python3
"""
Fix Active Probabilities Target IDs.
Maps ChEMBL IDs to UniProt IDs to align with the rest of the database.
"""

import os
import sys
import sqlite3
import psycopg2
from typing import Dict, Optional
from dotenv import load_dotenv

def get_pg_connection():
    load_dotenv()
    return psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        port=os.getenv('DB_PORT', '5432'),
        database=os.getenv('DB_NAME', 'side_effect_estimator'),
        user=os.getenv('DB_USER', 'postgres'),
        password=os.getenv('DB_PASSWORD')
    )

def get_chembl_connection():
    db_path = "/home/michael/SideEffectEstimator/chembl_36/chembl_36_sqlite/chembl_36.db"
    return sqlite3.connect(db_path)

def get_uniprot_id(chembl_conn, chembl_id: str) -> Optional[str]:
    """Get UniProt accession for a ChEMBL target ID."""
    cursor = chembl_conn.cursor()
    cursor.execute("""
        SELECT cs.accession
        FROM component_sequences cs
        JOIN target_components tc ON cs.component_id = tc.component_id
        JOIN target_dictionary td ON tc.tid = td.tid
        WHERE td.chembl_id = ?
        LIMIT 1
    """, (chembl_id,))
    row = cursor.fetchone()
    return row[0] if row else None

def main():
    pg_conn = get_pg_connection()
    chembl_conn = get_chembl_connection()
    
    print("Fixing active_probabilities target IDs...")
    
    try:
        with pg_conn.cursor() as pg_cur:
            # Get all ChEMBL IDs from active_probabilities
            pg_cur.execute("SELECT DISTINCT target_id FROM active_probabilities WHERE target_id LIKE 'CHEMBL%'")
            chembl_ids = [row[0] for row in pg_cur.fetchall()]
            
            print(f"Found {len(chembl_ids)} ChEMBL IDs to map.")
            
            updates = 0
            failures = 0
            
            for cid in chembl_ids:
                uid = get_uniprot_id(chembl_conn, cid)
                
                if uid:
                    # Update active_probabilities
                    # Only update if the new target_id exists in targets table (referential integrity)
                    # Check if target exists
                    pg_cur.execute("SELECT 1 FROM targets WHERE target_id = %s", (uid,))
                    if pg_cur.fetchone():
                        pg_cur.execute("""
                            UPDATE active_probabilities 
                            SET target_id = %s 
                            WHERE target_id = %s
                        """, (uid, cid))
                        updates += 1
                    else:
                        print(f"Warning: UniProt ID {uid} for {cid} not found in targets table. Skipping.")
                        failures += 1
                else:
                    print(f"Warning: No UniProt mapping for {cid}")
                    failures += 1
            
            pg_conn.commit()
            print(f"Updated {updates} targets. Failed/Skipped {failures}.")
            
    except Exception as e:
        print(f"Error: {e}")
        pg_conn.rollback()
    finally:
        pg_conn.close()
        chembl_conn.close()

if __name__ == "__main__":
    main()
