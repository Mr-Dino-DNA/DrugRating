#!/usr/bin/env python3
"""
SIDER MedDRA Parser for Side Effect Estimator.
Extracts side effect information from SIDER database files.
"""

import pandas as pd
from typing import Dict, List
from tqdm import tqdm


class SIDERParser:
    """Parser for SIDER MedDRA files."""
    
    def __init__(self, meddra_all_se_file: str, meddra_freq_file: str = None):
        """
        Initialize parser with SIDER file paths.
        
        Args:
            meddra_all_se_file: Path to meddra_all_se.tsv
            meddra_freq_file: Path to meddra_freq.tsv (optional, for frequency data)
        """
        self.meddra_all_se_file = meddra_all_se_file
        self.meddra_freq_file = meddra_freq_file
        
    def parse(self) -> Dict[str, List[Dict]]:
        """
        Parse SIDER files and return structured data.
        
        Returns:
            Dictionary with keys: 'side_effects', 'drug_side_effects'
        """
        print(f"Loading SIDER data from {self.meddra_all_se_file}...")
        
        # Load main side effects file
        # Columns: STITCH compound id (flat), STITCH compound id (stereo), 
        #          UMLS concept id, MedDRA concept type, UMLS concept id for MedDRA term, side effect name
        df = pd.read_csv(
            self.meddra_all_se_file,
            sep='\t',
            header=None,
            names=['flat_compound_id', 'stereo_compound_id', 'umls_id_label', 
                   'meddra_type', 'umls_id', 'side_effect_name']
        )
        
        print(f"Loaded {len(df)} side effect records")
        
        # Load frequency data if available
        freq_data = {}
        if self.meddra_freq_file:
            print(f"Loading frequency data from {self.meddra_freq_file}...")
            freq_df = pd.read_csv(
                self.meddra_freq_file,
                sep='\t',
                header=None,
                names=['stitch_flat', 'stitch_stereo', 'umls_id', 'placebo', 
                       'frequency_description', 'frequency_lower', 'frequency_upper', 'meddra_type']
            )
            # Create lookup: (compound_id, umls_id) -> frequency
            for _, row in freq_df.iterrows():
                key = (row['stitch_stereo'], row['umls_id'])
                freq_data[key] = row['frequency_description']
            print(f"Loaded {len(freq_data)} frequency records")
        
        # Extract unique side effects
        side_effects = self._extract_side_effects(df)
        
        # Extract drug-side effect relationships
        drug_side_effects = self._extract_drug_side_effects(df, freq_data)
        
        print(f"Extracted {len(side_effects)} unique side effects")
        print(f"Extracted {len(drug_side_effects)} drug-side effect associations")
        
        return {
            'side_effects': side_effects,
            'drug_side_effects': drug_side_effects
        }
    
    def _extract_side_effects(self, df: pd.DataFrame) -> List[Dict]:
        """Extract unique side effects."""
        # Get unique side effects
        unique_se = df[['umls_id', 'side_effect_name']].drop_duplicates()
        
        side_effects = []
        for _, row in unique_se.iterrows():
            # Extract MedDRA ID from UMLS ID if possible
            umls_id = row['umls_id']
            meddra_id = None
            
            # UMLS IDs starting with 'C' are concept IDs
            if isinstance(umls_id, str) and umls_id.startswith('C'):
                meddra_id = umls_id
            
            side_effect = {
                'side_effect_name': row['side_effect_name'],
                'meddra_id': meddra_id,
                'umls_id': umls_id,
                'severity': None  # SIDER doesn't provide severity
            }
            side_effects.append(side_effect)
        
        return side_effects
    
    def _extract_drug_side_effects(self, df: pd.DataFrame, freq_data: Dict) -> List[Dict]:
        """Extract drug-side effect relationships."""
        drug_side_effects = []
        
        # Group by compound and side effect
        grouped = df.groupby(['stereo_compound_id', 'umls_id', 'side_effect_name']).first().reset_index()
        
        for _, row in tqdm(grouped.iterrows(), total=len(grouped), desc="Processing drug-SE associations"):
            compound_id = row['stereo_compound_id']
            umls_id = row['umls_id']
            
            # Convert STITCH compound ID to PubChem CID
            # STITCH IDs are formatted as CIDm{pubchem_cid} or CIDs{pubchem_cid}
            pubchem_cid = self._stitch_to_pubchem(compound_id)
            
            # Look up frequency if available
            frequency = freq_data.get((compound_id, umls_id))
            
            drug_se = {
                'drug_id': f'CID{pubchem_cid}',  # Temporary ID, will map to DrugBank later
                'pubchem_cid': pubchem_cid,
                'side_effect_name': row['side_effect_name'],
                'umls_id': umls_id,
                'frequency': frequency,
                'source': 'SIDER'
            }
            drug_side_effects.append(drug_se)
        
        return drug_side_effects
    
    @staticmethod
    def _stitch_to_pubchem(stitch_id: str) -> int:
        """
        Convert STITCH compound ID to PubChem CID.
        
        STITCH IDs are formatted as:
        - CIDm{pubchem_cid} for merged compounds
        - CIDs{pubchem_cid} for stereo-specific compounds
        - Or just the numeric ID with prefix like '100000001'
        
        Args:
            stitch_id: STITCH compound identifier
            
        Returns:
            PubChem CID as integer
        """
        if isinstance(stitch_id, str):
            # Remove 'CIDm' or 'CIDs' prefix if present
            if stitch_id.startswith('CID'):
                stitch_id = stitch_id[4:]  # Remove 'CIDm' or 'CIDs'
        
        # Convert to int and subtract 100000000 (STITCH offset)
        try:
            stitch_num = int(stitch_id)
            if stitch_num > 100000000:
                return stitch_num - 100000000
            return stitch_num
        except (ValueError, TypeError):
            return None


if __name__ == '__main__':
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python sider_parser.py <meddra_all_se.tsv> [meddra_freq.tsv]")
        sys.exit(1)
    
    meddra_file = sys.argv[1]
    freq_file = sys.argv[2] if len(sys.argv) > 2 else None
    
    parser = SIDERParser(meddra_file, freq_file)
    data = parser.parse()
    
    print(f"\nSummary:")
    print(f"  Unique Side Effects: {len(data['side_effects'])}")
    print(f"  Drug-Side Effect Associations: {len(data['drug_side_effects'])}")
    
    # Show sample
    if data['side_effects']:
        print(f"\nSample side effect: {data['side_effects'][0]}")
    if data['drug_side_effects']:
        print(f"Sample association: {data['drug_side_effects'][0]}")
