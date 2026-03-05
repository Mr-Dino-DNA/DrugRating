#!/usr/bin/env python3
"""
Fetch Pathway Data from UniProt for Side Effect Estimator.
Updates targets table with Reactome and KEGG pathway information.
"""

import os
import sys
import json
import time
import requests
import psycopg2
from psycopg2.extras import execute_batch
from typing import List, Dict, Any
from dotenv import load_dotenv
from tqdm import tqdm

def get_db_connection():
    """Create database connection."""
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

def chunk_list(lst: List[Any], n: int):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

def fetch_uniprot_pathways(accessions: List[str]) -> Dict[str, List[Dict]]:
    """
    Fetch pathway data from UniProt API for a list of accessions.
    Returns a dictionary mapping accession -> list of pathway dicts.
    """
    url = "https://rest.uniprot.org/uniprotkb/accessions"
    results = {}
    
    # UniProt allows ~200-500 accessions per request usually, but let's be safe with 100
    # Actually, we are chunking outside, so 'accessions' here is already a chunk
    
    params = {
        "accessions": ",".join(accessions),
        "fields": "accession,cc_pathway,xref_reactome,xref_kegg"
    }
    
    try:
        response = requests.get(url, params=params, timeout=30)
        
        if response.status_code != 200:
            print(f"Error fetching data: {response.status_code}")
            return {}
            
        data = response.json()
        
        for entry in data.get('results', []):
            acc = entry['primaryAccession']
            pathways = []
            
            # Extract Reactome pathways
            if 'uniProtKBCrossReferences' in entry:
                for ref in entry['uniProtKBCrossReferences']:
                    if ref['database'] == 'Reactome':
                        # Reactome structure: { "database": "Reactome", "id": "R-HSA-123", "properties": [{"key": "PathwayName", "value": "Name"}] }
                        pathway_name = None
                        for prop in ref.get('properties', []):
                            if prop['key'] == 'PathwayName':
                                pathway_name = prop['value']
                                break
                        
                        if pathway_name:
                            pathways.append({
                                'source': 'Reactome',
                                'id': ref['id'],
                                'name': pathway_name
                            })
                    elif ref['database'] == 'KEGG':
                         pathways.append({
                                'source': 'KEGG',
                                'id': ref['id'],
                                'name': ref.get('properties', [{}])[0].get('value', 'Unknown')
                            })

            # Extract UniProt Pathway comments
            if 'comments' in entry:
                for comment in entry['comments']:
                    if comment['commentType'] == 'PATHWAY':
                         # Usually text description
                         if 'text' in comment:
                             for txt in comment['text']:
                                 pathways.append({
                                     'source': 'UniProt',
                                     'id': None,
                                     'name': txt.get('value')
                                 })

            results[acc] = pathways
            
    except Exception as e:
        print(f"Exception fetching UniProt data: {e}")
        
    return results

def main():
    load_dotenv()
    conn = get_db_connection()
    
    print("Fetching targets with UniProt IDs...")
    with conn.cursor() as cur:
        # Only fetch targets showing as UniProt IDs (e.g., P12345, Q9H2S6, etc.)
        # Simple heuristic: look for uniprot_id field or target_id length/format
        # Since we stored uniprot_id in the targets table, let's use that.
        cur.execute("SELECT target_id, uniprot_id FROM targets WHERE uniprot_id IS NOT NULL")
        rows = cur.fetchall()
    
    print(f"Found {len(rows)} targets with UniProt IDs")
    
    # Map target_id to uniprot_id (and vice versa for updating)
    target_map = {row[0]: row[1] for row in rows}
    uniprot_ids = list(set(target_map.values()))
    
    print(f"Unique UniProt IDs to fetch: {len(uniprot_ids)}")
    
    batch_size = 50
    updated_count = 0
    
    # Prepare updates list
    updates = []
    
    for chunk in tqdm(list(chunk_list(uniprot_ids, batch_size)), desc="Fetching pathways"):
        pathway_data = fetch_uniprot_pathways(chunk)
        
        for acc, pathways in pathway_data.items():
            if pathways:
                # Find which target_id corresponds to this accession
                # In our DB, target_id might be the accession itself or mapped.
                # We update all targets that span this uniprot_id
                target_ids = [tid for tid, uid in target_map.items() if uid == acc]
                
                json_data = json.dumps(pathways)
                for tid in target_ids:
                    updates.append((json_data, tid))
        
        # Rate limiting kindness
        time.sleep(0.2)
        
    print(f"Updating database with {len(updates)} pathway records...")
    
    with conn.cursor() as cur:
        execute_batch(cur, """
            UPDATE targets 
            SET pathway_info = %s 
            WHERE target_id = %s
        """, updates, page_size=100)
    
    conn.commit()
    conn.close()
    
    print("Done! Pathways updated.")

if __name__ == "__main__":
    main()
