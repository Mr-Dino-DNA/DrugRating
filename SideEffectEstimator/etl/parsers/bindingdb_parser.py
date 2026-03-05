#!/usr/bin/env python3
"""
BindingDB Parser for Side Effect Estimator.
Parses BindingDB TSV file for binding affinity data.
"""

import pandas as pd
from typing import Dict, List, Optional
from tqdm import tqdm
import re


class BindingDBParser:
    """Parser for BindingDB TSV files."""
    
    # Affinity types we're interested in
    AFFINITY_TYPES = ['Ki', 'Kd', 'IC50', 'EC50']
    
    def __init__(self, tsv_file: str, filter_human: bool = True):
        """
        Initialize BindingDB parser.
        
        Args:
            tsv_file: Path to BindingDB TSV file
            filter_human: Only include human targets
        """
        self.tsv_file = tsv_file
        self.filter_human = filter_human
        
    def parse(self, chunk_size: int = 10000) -> Dict[str, List[Dict]]:
        """
        Parse BindingDB TSV file in chunks.
        
        Args:
            chunk_size: Number of rows to process at a time
            
        Returns:
            Dictionary with 'bindings' and 'targets' lists
        """
        print(f"Loading BindingDB from {self.tsv_file}...")
        
        bindings = []
        targets = {}
        
        # Read in chunks to handle large file
        chunks = pd.read_csv(
            self.tsv_file,
            sep='\t',
            chunksize=chunk_size,
            low_memory=False,
            on_bad_lines='skip'
        )
        
        for chunk in tqdm(chunks, desc="Processing BindingDB"):
            chunk_bindings, chunk_targets = self._process_chunk(chunk)
            bindings.extend(chunk_bindings)
            targets.update(chunk_targets)
        
        print(f"Extracted {len(bindings)} binding measurements")
        print(f"Found {len(targets)} unique targets")
        
        return {
            'bindings': bindings,
            'targets': list(targets.values())
        }
    
    def _process_chunk(self, df: pd.DataFrame) -> tuple:
        """Process a chunk of the BindingDB data."""
        bindings = []
        targets = {}
        
        # Filter for human targets if requested
        if self.filter_human:
            df = df[df['Target Source Organism According to Curator or DataSource'].str.contains(
                'Homo sapiens', case=False, na=False
            )]
        
        for _, row in df.iterrows():
            # Extract drug identifiers
            drugbank_id = self._extract_drugbank_id(row)
            pubchem_cid = self._extract_pubchem_cid(row)
            inchikey = row.get('Ligand InChI Key')
            
            if not drugbank_id and not pubchem_cid:
                continue
            
            # Extract target information
            target_data = self._extract_target(row)
            if not target_data:
                continue
            
            target_id = target_data['target_id']
            if target_id not in targets:
                targets[target_id] = target_data
            
            # Extract binding affinities
            affinity_data = self._extract_affinities(row)
            
            for affinity in affinity_data:
                binding = {
                    'drugbank_id': drugbank_id,
                    'pubchem_cid': pubchem_cid,
                    'inchikey': inchikey,
                    'target_id': target_id,
                    'binding_affinity_value': affinity['value'],
                    'binding_affinity_unit': affinity['unit'],
                    'binding_affinity_type': affinity['type'],
                    'source': 'BindingDB'
                }
                bindings.append(binding)
        
        return bindings, targets
    
    def _extract_drugbank_id(self, row) -> Optional[str]:
        """Extract DrugBank ID from row."""
        # Check DrugBank ID column
        drugbank_col = row.get('DrugBank ID')
        if pd.notna(drugbank_col):
            # May contain multiple IDs separated by semicolon
            ids = str(drugbank_col).split(';')
            for id_str in ids:
                id_str = id_str.strip()
                if id_str.startswith('DB') and len(id_str) == 7:
                    return id_str
        return None
    
    def _extract_pubchem_cid(self, row) -> Optional[int]:
        """Extract PubChem CID from row."""
        cid_col = row.get('PubChem CID')
        if pd.notna(cid_col):
            try:
                return int(cid_col)
            except (ValueError, TypeError):
                pass
        return None
    
    def _extract_target(self, row) -> Optional[Dict]:
        """Extract target information from row."""
        # Get UniProt ID
        uniprot_id = row.get('UniProt (SwissProt) Primary ID of Target Chain')
        if pd.isna(uniprot_id):
            uniprot_id = row.get('UniProt (SwissProt) Recommended Name of Target Chain')
        
        if pd.isna(uniprot_id):
            return None
        
        uniprot_id = str(uniprot_id).strip()
        if not uniprot_id:
            return None
        
        # Get target name
        target_name = row.get('Target Name Assigned by Curator or DataSource')
        if pd.isna(target_name):
            target_name = row.get('Target Name')
        
        # Get gene symbol
        gene_symbol = row.get('Target Source Organism According to Curator or DataSource')
        
        return {
            'target_id': uniprot_id,
            'target_name': str(target_name) if pd.notna(target_name) else None,
            'uniprot_id': uniprot_id,
            'gene_symbol': None,  # BindingDB doesn't always have this
            'target_type': None
        }
    
    def _extract_affinities(self, row) -> List[Dict]:
        """Extract all affinity measurements from row."""
        affinities = []
        
        for affinity_type in self.AFFINITY_TYPES:
            # BindingDB has columns like 'Ki (nM)', 'Kd (nM)', 'IC50 (nM)', 'EC50 (nM)'
            col_name = f'{affinity_type} (nM)'
            
            if col_name in row and pd.notna(row[col_name]):
                value = row[col_name]
                
                # Try to convert to float
                try:
                    value = float(value)
                    if value > 0:  # Only positive values
                        affinities.append({
                            'type': affinity_type,
                            'value': value,
                            'unit': 'nM'
                        })
                except (ValueError, TypeError):
                    # Try to parse strings like '>10000' or '<0.1'
                    value_str = str(value).strip()
                    match = re.search(r'([<>]?)(\d+\.?\d*)', value_str)
                    if match:
                        try:
                            numeric_value = float(match.group(2))
                            if numeric_value > 0:
                                affinities.append({
                                    'type': affinity_type,
                                    'value': numeric_value,
                                    'unit': 'nM'
                                })
                        except ValueError:
                            pass
        
        return affinities
    
    def map_to_drugbank(self, bindings: List[Dict], 
                        pubchem_to_drugbank: Dict[int, str]) -> List[Dict]:
        """
        Map BindingDB entries to DrugBank IDs.
        
        Args:
            bindings: List of binding dictionaries
            pubchem_to_drugbank: Mapping from PubChem CID to DrugBank ID
            
        Returns:
            List of bindings with DrugBank IDs
        """
        mapped_bindings = []
        
        for binding in bindings:
            drugbank_id = binding.get('drugbank_id')
            
            # If no DrugBank ID, try to map via PubChem CID
            if not drugbank_id and binding.get('pubchem_cid'):
                drugbank_id = pubchem_to_drugbank.get(binding['pubchem_cid'])
            
            if drugbank_id:
                binding['drugbank_id'] = drugbank_id
                mapped_bindings.append(binding)
        
        return mapped_bindings


if __name__ == '__main__':
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python bindingdb_parser.py <BindingDB_All.tsv>")
        print("\nDownload from: https://www.bindingdb.org/bind/downloads.jsp")
        sys.exit(1)
    
    tsv_file = sys.argv[1]
    parser = BindingDBParser(tsv_file)
    
    # Parse a small sample
    print("Parsing BindingDB (this may take a while for large files)...")
    data = parser.parse(chunk_size=1000)
    
    print(f"\nSummary:")
    print(f"  Bindings: {len(data['bindings'])}")
    print(f"  Targets: {len(data['targets'])}")
    
    # Show sample
    if data['bindings']:
        print(f"\nSample binding:")
        sample = data['bindings'][0]
        for key, value in sample.items():
            print(f"  {key}: {value}")
