import sqlite3
import pandas as pd
from typing import List, Dict
import os
from tqdm import tqdm

class LocalChEMBLParser:
    """
    High-performance local parser for ChEMBL SQLite database.
    Directly queries the database file instead of using the slow REST API.
    """
    
    def __init__(self, db_path: str):
        """
        Initialize with path to ChEMBL sqlite database.
        """
        self.db_path = db_path
        if not os.path.exists(db_path):
            raise FileNotFoundError(f"ChEMBL database not found at {db_path}")
            
    def get_activities_for_inchikeys(self, inchikeys: List[str], min_confidence: int = 5) -> List[Dict]:
        """
        Retrieve binding activities for a list of InChIKeys.
        
        Args:
            inchikeys: List of InChIKey strings
            min_confidence: Minimum assay confidence score (0-9)
            
        Returns:
            List of activity dictionaries
        """
        print(f"Querying local ChEMBL DB for {len(inchikeys)} compounds...")
        
        # Connect to DB
        conn = sqlite3.connect(self.db_path)
        
        # Prepare valid InChIKeys for SQL IN clause
        # sqlite has a limit on variables, so we might need to chunk if list is huge
        # But for ~2500 drugs it might be okay, or we can use a temp table
        
        chunk_size = 500
        all_activities = []
        
        unique_keys = list(set(inchikeys))
        
        pbar = tqdm(total=len(unique_keys), desc="Fetching ChEMBL Activities")
        
        for i in range(0, len(unique_keys), chunk_size):
            chunk = unique_keys[i:i + chunk_size]
            placeholders = ','.join(['?'] * len(chunk))
            
            query = f"""
                SELECT 
                    cs.standard_inchi_key,
                    md.chembl_id as molecule_chembl_id,
                    act.standard_type,
                    act.standard_value,
                    act.standard_units,
                    td.pref_name as target_name,
                    td.chembl_id as target_chembl_id,
                    td.target_type,
                    cseq.accession as uniprot_id,
                    ass.confidence_score,
                    ass.description as assay_description
                FROM compound_structures cs
                JOIN activities act ON cs.molregno = act.molregno
                JOIN molecule_dictionary md ON cs.molregno = md.molregno
                JOIN assays ass ON act.assay_id = ass.assay_id
                JOIN target_dictionary td ON ass.tid = td.tid
                JOIN target_components tc ON td.tid = tc.tid
                JOIN component_sequences cseq ON tc.component_id = cseq.component_id
                WHERE cs.standard_inchi_key IN ({placeholders})
                AND act.standard_type IN ('IC50', 'Ki', 'Kd', 'EC50')
                AND act.standard_units = 'nM'
                AND ass.confidence_score >= ?
                AND td.target_type = 'SINGLE PROTEIN' 
            """
            
            # Execute
            params = chunk + [min_confidence]
            df = pd.read_sql_query(query, conn, params=params)
            
            # Convert to list of dicts
            for _, row in df.iterrows():
                all_activities.append({
                    'inchikey': row['standard_inchi_key'],
                    'target_chembl_id': row['target_chembl_id'],
                    'binding_affinity_value': row['standard_value'],
                    'binding_affinity_unit': row['standard_units'],
                    'binding_affinity_type': row['standard_type'],
                    'confidence_score': row['confidence_score'],
                    'assay_description': row['assay_description'],
                    'source': 'ChEMBL',
                    'target_info': {
                        'target_name': row['target_name'],
                        'target_chembl_id': row['target_chembl_id'],
                        'target_type': row['target_type'],
                        'uniprot_id': row['uniprot_id']
                    }
                })
            
            pbar.update(len(chunk))
            
        conn.close()
        pbar.close()
        
        print(f"Found {len(all_activities)} bioactivity records.")
        return all_activities

