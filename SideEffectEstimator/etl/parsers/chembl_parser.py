#!/usr/bin/env python3
"""
ChEMBL API Parser for Side Effect Estimator.
Fetches high-quality binding affinity data from ChEMBL database.
"""

import requests
import time
from typing import Dict, List, Optional
from tqdm import tqdm


class ChEMBLParser:
    """Parser for ChEMBL REST API."""
    
    BASE_URL = "https://www.ebi.ac.uk/chembl/api/data"
    
    def __init__(self, min_confidence_score: int = 5, requests_per_second: int = 10):
        """
        Initialize ChEMBL parser.
        
        Args:
            min_confidence_score: Minimum confidence score (0-9, higher is better)
            requests_per_second: Rate limit for API requests
        """
        self.min_confidence_score = min_confidence_score
        self.requests_per_second = requests_per_second
        self.request_delay = 1.0 / requests_per_second
        self.last_request_time = 0
        
    def _rate_limit(self):
        """Enforce rate limiting between requests."""
        elapsed = time.time() - self.last_request_time
        if elapsed < self.request_delay:
            time.sleep(self.request_delay - elapsed)
        self.last_request_time = time.time()
    
    def _make_request(self, url: str, params: Dict = None) -> Optional[Dict]:
        """
        Make rate-limited request with retry logic.
        
        Args:
            url: API endpoint URL
            params: Query parameters
            
        Returns:
            JSON response or None if failed
        """
        for attempt in range(3):
            try:
                self._rate_limit()
                response = requests.get(url, params=params, timeout=30)
                
                if response.status_code == 200:
                    return response.json()
                elif response.status_code == 404:
                    return None
                else:
                    if attempt < 2:
                        time.sleep(2 ** attempt)
                        continue
                    return None
            except requests.RequestException:
                if attempt < 2:
                    time.sleep(2)
                    continue
                return None
        
        return None
    
    def get_molecule_by_drugbank_id(self, drugbank_id: str) -> Optional[str]:
        """
        Get ChEMBL molecule ID by DrugBank ID.
        
        Args:
            drugbank_id: DrugBank identifier (e.g., 'DB00001')
            
        Returns:
            ChEMBL molecule ID or None
        """
        url = f"{self.BASE_URL}/molecule.json"
        params = {
            'molecule_xrefs__xref_id': drugbank_id,
            'molecule_xrefs__xref_src': 'DrugBank',
            'limit': 1
        }
        
        data = self._make_request(url, params)
        if data and 'molecules' in data and data['molecules']:
            return data['molecules'][0]['molecule_chembl_id']
        return None
    
    def get_molecule_by_inchikey(self, inchikey: str) -> Optional[str]:
        """
        Get ChEMBL molecule ID by InChIKey.
        
        Args:
            inchikey: Standard InChIKey
            
        Returns:
            ChEMBL molecule ID or None
        """
        url = f"{self.BASE_URL}/molecule.json"
        params = {
            'molecule_structures__standard_inchi_key': inchikey,
            'limit': 1
        }
        
        data = self._make_request(url, params)
        if data and 'molecules' in data and data['molecules']:
            return data['molecules'][0]['molecule_chembl_id']
        return None
    
    def get_activities(self, chembl_id: str, limit: int = 1000) -> List[Dict]:
        """
        Get bioactivity data for a molecule.
        
        Args:
            chembl_id: ChEMBL molecule ID
            limit: Maximum number of activities to retrieve
            
        Returns:
            List of activity dictionaries
        """
        activities = []
        offset = 0
        batch_size = 100
        
        while offset < limit:
            url = f"{self.BASE_URL}/activity.json"
            params = {
                'molecule_chembl_id': chembl_id,
                'limit': batch_size,
                'offset': offset
            }
            
            data = self._make_request(url, params)
            if not data or 'activities' not in data or not data['activities']:
                break
            
            activities.extend(data['activities'])
            
            # Check if we've got all results
            if len(data['activities']) < batch_size:
                break
            
            offset += batch_size
        
        return activities
    
    def get_target_info(self, target_chembl_id: str) -> Optional[Dict]:
        """
        Get target information including UniProt ID.
        
        Args:
            target_chembl_id: ChEMBL target ID
            
        Returns:
            Dictionary with target info or None
        """
        url = f"{self.BASE_URL}/target/{target_chembl_id}.json"
        
        data = self._make_request(url)
        if data:
            target_components = data.get('target_components', [])
            uniprot_id = None
            gene_symbol = None
            
            if target_components:
                accessions = target_components[0].get('target_component_xrefs', [])
                for acc in accessions:
                    if acc.get('xref_src_db') == 'UniProt':
                        uniprot_id = acc.get('xref_id')
                        break
                
                # Get gene symbol
                synonyms = target_components[0].get('target_component_synonyms', [])
                for syn in synonyms:
                    if syn.get('syn_type') == 'GENE_SYMBOL':
                        gene_symbol = syn.get('component_synonym')
                        break
            
            return {
                'target_chembl_id': target_chembl_id,
                'target_name': data.get('pref_name'),
                'target_type': data.get('target_type'),
                'organism': data.get('organism'),
                'uniprot_id': uniprot_id,
                'gene_symbol': gene_symbol
            }
        return None
    
    def parse_binding_affinities(self, activities: List[Dict]) -> List[Dict]:
        """
        Parse and filter binding affinity data from activities.
        
        Args:
            activities: List of activity dictionaries from ChEMBL
            
        Returns:
            List of parsed binding affinity dictionaries
        """
        affinities = []
        
        for activity in activities:
            # Filter by activity type
            activity_type = activity.get('standard_type')
            if activity_type not in ['Ki', 'Kd', 'IC50', 'EC50']:
                continue
            
            # Filter by confidence score
            confidence = activity.get('confidence_score')
            if confidence is None or confidence < self.min_confidence_score:
                continue
            
            # Filter for human targets (optional)
            # organism = activity.get('target_organism')
            # if organism and 'Homo sapiens' not in organism:
            #     continue
            
            # Get binding value
            value = activity.get('standard_value')
            units = activity.get('standard_units')
            
            if value is None:
                continue
            
            # Convert to float
            try:
                value = float(value)
            except (ValueError, TypeError):
                continue
            
            affinity = {
                'target_chembl_id': activity.get('target_chembl_id'),
                'binding_affinity_value': value,
                'binding_affinity_unit': units,
                'binding_affinity_type': activity_type,
                'confidence_score': confidence,
                'assay_description': activity.get('assay_description'),
                'source': 'ChEMBL'
            }
            
            affinities.append(affinity)
        
        return affinities
    
    def get_binding_data_for_drug(self, drugbank_id: str, inchikey: str = None) -> List[Dict]:
        """
        Get all binding affinity data for a drug.
        
        Args:
            drugbank_id: DrugBank ID
            inchikey: InChIKey (optional, used as fallback)
            
        Returns:
            List of binding affinity dictionaries with target info
        """
        # Try to find ChEMBL molecule ID
        chembl_id = self.get_molecule_by_drugbank_id(drugbank_id)
        
        if not chembl_id and inchikey:
            chembl_id = self.get_molecule_by_inchikey(inchikey)
        
        if not chembl_id:
            return []
        
        # Get activities
        activities = self.get_activities(chembl_id)
        
        # Parse binding affinities
        affinities = self.parse_binding_affinities(activities)
        
        # Enrich with target information
        target_cache = {}
        enriched_affinities = []
        
        for affinity in affinities:
            target_chembl_id = affinity['target_chembl_id']
            
            # Get target info (with caching)
            if target_chembl_id not in target_cache:
                target_info = self.get_target_info(target_chembl_id)
                target_cache[target_chembl_id] = target_info
            else:
                target_info = target_cache[target_chembl_id]
            
            if target_info:
                affinity['target_info'] = target_info
                enriched_affinities.append(affinity)
        
        return enriched_affinities
    
    def get_binding_data_for_drugs(self, drugs: List[Dict]) -> Dict[str, List[Dict]]:
        """
        Get binding data for multiple drugs.
        
        Args:
            drugs: List of drug dictionaries with 'drug_id' and optionally 'inchikey'
            
        Returns:
            Dictionary mapping drug_id to list of binding affinities
        """
        results = {}
        
        for drug in tqdm(drugs, desc="Fetching ChEMBL binding data"):
            drug_id = drug.get('drug_id')
            inchikey = drug.get('inchikey')
            
            affinities = self.get_binding_data_for_drug(drug_id, inchikey)
            if affinities:
                results[drug_id] = affinities
        
        return results


if __name__ == '__main__':
    import sys
    
    parser = ChEMBLParser()
    
    if len(sys.argv) > 1:
        drugbank_id = sys.argv[1]
        print(f"Fetching ChEMBL data for {drugbank_id}...")
        
        # Get ChEMBL ID
        chembl_id = parser.get_molecule_by_drugbank_id(drugbank_id)
        if chembl_id:
            print(f"ChEMBL ID: {chembl_id}")
            
            # Get binding data
            affinities = parser.get_binding_data_for_drug(drugbank_id)
            print(f"\nFound {len(affinities)} binding measurements")
            
            # Show first few
            for i, aff in enumerate(affinities[:5]):
                print(f"\n{i+1}. {aff['binding_affinity_type']}: {aff['binding_affinity_value']} {aff['binding_affinity_unit']}")
                if 'target_info' in aff:
                    print(f"   Target: {aff['target_info'].get('target_name')}")
                    print(f"   UniProt: {aff['target_info'].get('uniprot_id')}")
        else:
            print("Not found in ChEMBL")
    else:
        print("Usage: python chembl_parser.py <DrugBank_ID>")
        print("\nExample:")
        print("  python chembl_parser.py DB00945")
