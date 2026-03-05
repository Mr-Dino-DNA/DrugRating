#!/usr/bin/env python3
"""
PubChem API Parser for Side Effect Estimator.
Enriches drug data with chemical structures and properties from PubChem.
"""

import requests
import time
from typing import Dict, List, Optional
from tqdm import tqdm


class PubChemParser:
    """Parser for PubChem REST API."""
    
    BASE_URL = "https://pubchem.ncbi.nlm.nih.gov/rest/pug"
    
    def __init__(self, requests_per_second: int = 5, max_retries: int = 3):
        """
        Initialize PubChem parser.
        
        Args:
            requests_per_second: Rate limit (PubChem allows 5/sec)
            max_retries: Maximum retry attempts for failed requests
        """
        self.requests_per_second = requests_per_second
        self.max_retries = max_retries
        self.request_delay = 1.0 / requests_per_second
        self.last_request_time = 0
        
    def _rate_limit(self):
        """Enforce rate limiting between requests."""
        elapsed = time.time() - self.last_request_time
        if elapsed < self.request_delay:
            time.sleep(self.request_delay - elapsed)
        self.last_request_time = time.time()
    
    def _make_request(self, url: str) -> Optional[Dict]:
        """
        Make rate-limited request with retry logic.
        
        Args:
            url: API endpoint URL
            
        Returns:
            JSON response or None if failed
        """
        for attempt in range(self.max_retries):
            try:
                self._rate_limit()
                response = requests.get(url, timeout=10)
                
                if response.status_code == 200:
                    return response.json()
                elif response.status_code == 404:
                    return None  # Not found
                elif response.status_code == 429:
                    # Rate limited, wait longer
                    time.sleep(2 ** attempt)
                    continue
                else:
                    # Other error
                    if attempt < self.max_retries - 1:
                        time.sleep(1)
                        continue
                    return None
            except requests.RequestException:
                if attempt < self.max_retries - 1:
                    time.sleep(1)
                    continue
                return None
        
        return None
    
    def get_compound_by_cid(self, cid: int) -> Optional[Dict]:
        """
        Get compound data by PubChem CID.
        
        Args:
            cid: PubChem Compound ID
            
        Returns:
            Dictionary with compound properties or None
        """
        url = f"{self.BASE_URL}/compound/cid/{cid}/property/CanonicalSMILES,InChI,InChIKey,MolecularFormula,MolecularWeight/JSON"
        
        data = self._make_request(url)
        if data and 'PropertyTable' in data and 'Properties' in data['PropertyTable']:
            props = data['PropertyTable']['Properties'][0]
            return {
                'pubchem_cid': cid,
                'smiles': props.get('CanonicalSMILES'),
                'inchi': props.get('InChI'),
                'inchikey': props.get('InChIKey'),
                'molecular_formula': props.get('MolecularFormula'),
                'molecular_weight': props.get('MolecularWeight')
            }
        return None
    
    def get_compound_by_name(self, name: str) -> Optional[Dict]:
        """
        Search for compound by name.
        
        Args:
            name: Drug name or synonym
            
        Returns:
            Dictionary with compound properties or None
        """
        # URL encode the name
        encoded_name = requests.utils.quote(name)
        url = f"{self.BASE_URL}/compound/name/{encoded_name}/property/CanonicalSMILES,InChI,InChIKey,MolecularFormula,MolecularWeight/JSON"
        
        data = self._make_request(url)
        if data and 'PropertyTable' in data and 'Properties' in data['PropertyTable']:
            props = data['PropertyTable']['Properties'][0]
            return {
                'smiles': props.get('CanonicalSMILES'),
                'inchi': props.get('InChI'),
                'inchikey': props.get('InChIKey'),
                'molecular_formula': props.get('MolecularFormula'),
                'molecular_weight': props.get('MolecularWeight')
            }
        return None
    
    def get_cid_by_drugbank_id(self, drugbank_id: str) -> Optional[int]:
        """
        Get PubChem CID by DrugBank ID.
        
        Args:
            drugbank_id: DrugBank identifier (e.g., 'DB00001')
            
        Returns:
            PubChem CID or None
        """
        url = f"{self.BASE_URL}/compound/name/{drugbank_id}/cids/JSON"
        
        data = self._make_request(url)
        if data and 'IdentifierList' in data and 'CID' in data['IdentifierList']:
            cids = data['IdentifierList']['CID']
            return cids[0] if cids else None
        return None
    
    def get_synonyms(self, cid: int) -> List[str]:
        """
        Get all synonyms for a compound.
        
        Args:
            cid: PubChem Compound ID
            
        Returns:
            List of synonym strings
        """
        url = f"{self.BASE_URL}/compound/cid/{cid}/synonyms/JSON"
        
        data = self._make_request(url)
        if data and 'InformationList' in data and 'Information' in data['InformationList']:
            info = data['InformationList']['Information']
            if info and 'Synonym' in info[0]:
                return info[0]['Synonym']
        return []
    
    def find_drugbank_id_in_synonyms(self, cid: int) -> Optional[str]:
        """
        Find DrugBank ID in compound synonyms.
        
        Args:
            cid: PubChem Compound ID
            
        Returns:
            DrugBank ID or None
        """
        synonyms = self.get_synonyms(cid)
        for synonym in synonyms:
            if synonym.startswith('DB') and len(synonym) == 7:
                return synonym
        return None
    
    def enrich_drugs(self, drugs: List[Dict]) -> List[Dict]:
        """
        Enrich drug list with PubChem data.
        
        Args:
            drugs: List of drug dictionaries with 'drug_id' and 'drug_name'
            
        Returns:
            List of enrichment data dictionaries
        """
        enrichments = []
        
        for drug in tqdm(drugs, desc="Enriching from PubChem"):
            drug_id = drug.get('drug_id')
            drug_name = drug.get('drug_name')
            pubchem_cid = drug.get('pubchem_cid')
            
            enrichment = {'drug_id': drug_id}
            
            # Try to get data by CID if available
            if pubchem_cid:
                data = self.get_compound_by_cid(pubchem_cid)
                if data:
                    enrichment.update(data)
                    enrichments.append(enrichment)
                    continue
            
            # Try to get CID by DrugBank ID
            if not pubchem_cid and drug_id:
                cid = self.get_cid_by_drugbank_id(drug_id)
                if cid:
                    data = self.get_compound_by_cid(cid)
                    if data:
                        enrichment.update(data)
                        enrichments.append(enrichment)
                        continue
            
            # Try by drug name
            if drug_name:
                data = self.get_compound_by_name(drug_name)
                if data:
                    enrichment.update(data)
                    enrichments.append(enrichment)
                    continue
        
        return enrichments
    
    def map_pubchem_to_drugbank(self, pubchem_cids: List[int]) -> Dict[int, str]:
        """
        Create mapping from PubChem CID to DrugBank ID.
        
        Args:
            pubchem_cids: List of PubChem CIDs
            
        Returns:
            Dictionary mapping CID to DrugBank ID
        """
        mapping = {}
        
        for cid in tqdm(pubchem_cids, desc="Mapping PubChem to DrugBank"):
            drugbank_id = self.find_drugbank_id_in_synonyms(cid)
            if drugbank_id:
                mapping[cid] = drugbank_id
        
        return mapping


if __name__ == '__main__':
    import sys
    
    parser = PubChemParser()
    
    if len(sys.argv) > 1:
        # Test with a specific compound
        query = sys.argv[1]
        
        if query.isdigit():
            # CID
            print(f"Fetching CID {query}...")
            data = parser.get_compound_by_cid(int(query))
        else:
            # Name or DrugBank ID
            print(f"Searching for '{query}'...")
            data = parser.get_compound_by_name(query)
        
        if data:
            print("\nResult:")
            for key, value in data.items():
                print(f"  {key}: {value}")
        else:
            print("Not found")
    else:
        print("Usage: python pubchem_parser.py <CID|name|DrugBank_ID>")
        print("\nExamples:")
        print("  python pubchem_parser.py 2244")
        print("  python pubchem_parser.py aspirin")
        print("  python pubchem_parser.py DB00945")
