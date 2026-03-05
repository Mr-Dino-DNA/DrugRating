#!/usr/bin/env python3
"""
DrugBank XML Parser for Side Effect Estimator.
Extracts drugs, targets, and dosage information from DrugBank XML file.
"""

import xml.etree.ElementTree as ET
from typing import Dict, List, Optional
import re
from tqdm import tqdm


class DrugBankParser:
    """Parser for DrugBank XML files."""
    
    # DrugBank XML namespace
    NS = {'db': 'http://www.drugbank.ca'}
    
    def __init__(self, xml_file: str):
        """Initialize parser with XML file path."""
        self.xml_file = xml_file
        self.tree = None
        self.root = None
        
    def parse(self) -> Dict[str, List[Dict]]:
        """
        Parse DrugBank XML and return structured data.
        
        Returns:
            Dictionary with keys: 'drugs', 'targets', 'drug_targets', 'dosages'
        """
        print(f"Loading DrugBank XML from {self.xml_file}...")
        self.tree = ET.parse(self.xml_file)
        self.root = self.tree.getroot()
        
        drugs = []
        targets = []
        drug_targets = []
        dosages = []
        
        # Get all drug entries
        drug_entries = self.root.findall('db:drug', self.NS)
        print(f"Found {len(drug_entries)} drug entries")
        
        for drug_elem in tqdm(drug_entries, desc="Parsing drugs"):
            # Only process approved small molecule drugs
            drug_type = drug_elem.get('type', '')
            groups = [g.text for g in drug_elem.findall('db:groups/db:group', self.NS)]
            
            # Skip non-approved or biotech drugs for now
            if 'approved' not in groups and 'vet_approved' not in groups:
                continue
                
            drug_data = self._parse_drug(drug_elem)
            if drug_data:
                drugs.append(drug_data['drug'])
                
                # Collect targets
                for target_data in drug_data['targets']:
                    targets.append(target_data['target'])
                    drug_targets.append(target_data['interaction'])
                
                # Collect dosages
                dosages.extend(drug_data['dosages'])
        
        print(f"Parsed {len(drugs)} drugs, {len(targets)} targets, {len(drug_targets)} interactions")
        
        return {
            'drugs': drugs,
            'targets': targets,
            'drug_targets': drug_targets,
            'dosages': dosages
        }
    
    def _parse_drug(self, drug_elem) -> Optional[Dict]:
        """Parse a single drug entry."""
        # Get primary DrugBank ID
        drugbank_id_elem = drug_elem.find('db:drugbank-id[@primary="true"]', self.NS)
        if drugbank_id_elem is None:
            return None
            
        drugbank_id = drugbank_id_elem.text
        
        # Basic info
        name_elem = drug_elem.find('db:name', self.NS)
        name = name_elem.text if name_elem is not None else None
        
        # Chemical structure
        smiles = self._get_property(drug_elem, 'SMILES')
        inchi = self._get_property(drug_elem, 'InChI')
        inchikey = self._get_property(drug_elem, 'InChIKey')
        molecular_formula = self._get_property(drug_elem, 'Molecular Formula')
        molecular_weight = self._get_property(drug_elem, 'Molecular Weight')
        
        # Convert molecular weight to float
        if molecular_weight:
            try:
                molecular_weight = float(molecular_weight)
            except (ValueError, TypeError):
                molecular_weight = None
        
        drug_data = {
            'drug_id': drugbank_id,
            'drug_name': name,
            'smiles': smiles,
            'inchi': inchi,
            'inchikey': inchikey,
            'molecular_formula': molecular_formula,
            'molecular_weight': molecular_weight,
            'drugbank_id': drugbank_id,
            'pubchem_cid': self._get_external_id(drug_elem, 'PubChem Compound')
        }
        
        # Parse targets
        targets_data = self._parse_targets(drug_elem, drugbank_id)
        
        # Parse dosages
        dosages_data = self._parse_dosages(drug_elem, drugbank_id)
        
        return {
            'drug': drug_data,
            'targets': targets_data,
            'dosages': dosages_data
        }
    
    def _get_property(self, drug_elem, property_kind: str) -> Optional[str]:
        """Extract a calculated property from drug element."""
        prop_elem = drug_elem.find(
            f'.//db:calculated-properties/db:property[db:kind="{property_kind}"]/db:value',
            self.NS
        )
        if prop_elem is None:
            # Try experimental properties
            prop_elem = drug_elem.find(
                f'.//db:experimental-properties/db:property[db:kind="{property_kind}"]/db:value',
                self.NS
            )
        return prop_elem.text if prop_elem is not None else None
    
    def _get_external_id(self, drug_elem, resource: str) -> Optional[str]:
        """Extract external identifier."""
        identifier = None
        for ext_id in drug_elem.findall('db:external-identifiers/db:external-identifier', self.NS):
            res_elem = ext_id.find('db:resource', self.NS)
            if res_elem is not None and res_elem.text == resource:
                id_elem = ext_id.find('db:identifier', self.NS)
                if id_elem is not None:
                    identifier = id_elem.text
                    break
        return identifier

    
    def _parse_targets(self, drug_elem, drug_id: str) -> List[Dict]:
        """Parse target information for a drug."""
        targets_data = []
        
        for target_elem in drug_elem.findall('db:targets/db:target', self.NS):
            target_id_elem = target_elem.find('db:id', self.NS)
            if target_id_elem is None:
                continue
                
            target_id = target_id_elem.text
            
            # Target name
            name_elem = target_elem.find('db:name', self.NS)
            target_name = name_elem.text if name_elem is not None else None
            
            # Polypeptide info (UniProt ID, gene symbol)
            polypeptide = target_elem.find('db:polypeptide', self.NS)
            uniprot_id = None
            gene_symbol = None
            
            if polypeptide is not None:
                uniprot_id = polypeptide.get('id')
                gene_elem = polypeptide.find('db:gene-name', self.NS)
                gene_symbol = gene_elem.text if gene_elem is not None else None
            
            # Actions (agonist, antagonist, inhibitor, etc.)
            actions = [a.text for a in target_elem.findall('db:actions/db:action', self.NS)]
            interaction_type = ', '.join(actions) if actions else None
            
            # Known action (pharmacological action)
            known_action_elem = target_elem.find('db:known-action', self.NS)
            known_action = known_action_elem.text if known_action_elem is not None else None
            
            target_data = {
                'target_id': uniprot_id if uniprot_id else target_id,
                'target_name': target_name,
                'target_type': None,  # DrugBank doesn't always specify
                'gene_symbol': gene_symbol,
                'uniprot_id': uniprot_id,
                'pathway_info': None  # Can be added later
            }
            
            interaction_data = {
                'drug_id': drug_id,
                'target_id': uniprot_id if uniprot_id else target_id,
                'binding_affinity_value': None,  # DrugBank doesn't include this
                'binding_affinity_unit': None,
                'binding_affinity_type': None,
                'interaction_type': interaction_type,
                'source': 'DrugBank'
            }
            
            targets_data.append({
                'target': target_data,
                'interaction': interaction_data
            })
        
        return targets_data
    
    def _parse_dosages(self, drug_elem, drug_id: str) -> List[Dict]:
        """Parse dosage information for a drug."""
        dosages_data = []
        
        for dosage_elem in drug_elem.findall('db:dosages/db:dosage', self.NS):
            form_elem = dosage_elem.find('db:form', self.NS)
            route_elem = dosage_elem.find('db:route', self.NS)
            strength_elem = dosage_elem.find('db:strength', self.NS)
            
            form = form_elem.text if form_elem is not None else None
            route = route_elem.text if route_elem is not None else None
            strength = strength_elem.text if strength_elem is not None else None
            
            # Try to extract numeric dose from strength
            dose_mg = None
            if strength:
                # Look for patterns like "500 mg", "10mg", etc.
                match = re.search(r'(\d+(?:\.\d+)?)\s*mg', strength, re.IGNORECASE)
                if match:
                    try:
                        dose_mg = float(match.group(1))
                    except ValueError:
                        pass
            
            dosage_data = {
                'drug_id': drug_id,
                'indication': None,  # Not in dosage element
                'route': route,
                'min_dose_mg': None,
                'max_dose_mg': None,
                'typical_dose_mg': dose_mg,
                'frequency': None,  # Not always specified
                'source': 'DrugBank'
            }
            
            dosages_data.append(dosage_data)
        
        return dosages_data


if __name__ == '__main__':
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python drugbank_parser.py <drugbank.xml>")
        sys.exit(1)
    
    parser = DrugBankParser(sys.argv[1])
    data = parser.parse()
    
    print(f"\nSummary:")
    print(f"  Drugs: {len(data['drugs'])}")
    print(f"  Targets: {len(data['targets'])}")
    print(f"  Drug-Target Interactions: {len(data['drug_targets'])}")
    print(f"  Dosages: {len(data['dosages'])}")
