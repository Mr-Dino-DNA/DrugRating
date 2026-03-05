#!/usr/bin/env python3
"""
Active Probability Parser for Side Effect Estimator.
Parses CSV file containing ML-predicted binding probabilities.
"""

import pandas as pd
from typing import Dict, List
from tqdm import tqdm


class ActiveProbabilityParser:
    """Parser for active probability CSV files."""
    
    def __init__(self, csv_file: str):
        """
        Initialize parser.
        
        Args:
            csv_file: Path to active probability CSV file
        """
        self.csv_file = csv_file
    
    def parse(self) -> List[Dict]:
        """
        Parse active probability CSV file.
        
        Expected columns:
        - target_id: Target identifier (ChEMBL ID or UniProt ID)
        - Gene names: Associated gene names
        - activity: Binary activity prediction (0/1 or True/False)
        - active_probability: Probability of activity (0-1)
        - non_active_probability: Probability of non-activity (0-1)
        
        Returns:
            List of active probability dictionaries
        """
        print(f"Loading active probabilities from {self.csv_file}...")
        
        # Read CSV
        df = pd.read_csv(self.csv_file)
        
        # Normalize column names (handle variations)
        df.columns = df.columns.str.strip()
        column_mapping = {
            'Gene names': 'gene_names',
            'gene_names': 'gene_names',
            'Gene Names': 'gene_names',
            'target_id': 'target_id',
            'Target_ID': 'target_id',
            'chembl_id': 'chembl_id',
            'ChEMBL_ID': 'chembl_id',
            'activity': 'activity',
            'Activity': 'activity',
            'active_probability': 'active_probability',
            'Active_Probability': 'active_probability',
            'non_active_probability': 'non_active_probability',
            'Non_Active_Probability': 'non_active_probability'
        }
        
        # Rename columns
        df = df.rename(columns=column_mapping)
        
        # Validate required columns
        required_cols = ['target_id', 'activity', 'active_probability']
        missing_cols = [col for col in required_cols if col not in df.columns]
        if missing_cols:
            raise ValueError(f"Missing required columns: {missing_cols}")
        
        # Calculate non_active_probability if missing
        if 'non_active_probability' not in df.columns:
            df['non_active_probability'] = 1.0 - df['active_probability']
        
        # Convert to list of dictionaries
        probabilities = []
        skipped = 0
        
        for _, row in tqdm(df.iterrows(), total=len(df), desc="Parsing probabilities"):
            # Validate probabilities
            active_prob = row.get('active_probability')
            non_active_prob = row.get('non_active_probability')
            
            if pd.isna(active_prob) or pd.isna(non_active_prob):
                skipped += 1
                continue
            
            # Check probability range
            if not (0 <= active_prob <= 1) or not (0 <= non_active_prob <= 1):
                skipped += 1
                continue
            
            # Check probabilities sum to ~1 (allow small floating point error)
            prob_sum = active_prob + non_active_prob
            if not (0.99 <= prob_sum <= 1.01):
                skipped += 1
                continue
            
            # Parse activity
            activity = row.get('activity')
            if pd.notna(activity):
                if isinstance(activity, bool):
                    activity = activity
                elif isinstance(activity, (int, float)):
                    activity = bool(int(activity))
                elif isinstance(activity, str):
                    activity = activity.lower() in ['true', '1', 'yes']
                else:
                    activity = None
            else:
                activity = None
            
            # Extract target_id and chembl_id
            target_id = str(row['target_id']).strip()
            
            # Check if target_id is ChEMBL format
            chembl_id = None
            if target_id.startswith('CHEMBL'):
                chembl_id = target_id
                # Try to extract UniProt ID from other columns if available
                if 'uniprot_id' in row and pd.notna(row['uniprot_id']):
                    target_id = str(row['uniprot_id']).strip()
            
            probabilities.append({
                'target_id': target_id,
                'chembl_id': chembl_id,
                'gene_names': str(row.get('gene_names', '')).strip() if pd.notna(row.get('gene_names')) else None,
                'activity': activity,
                'active_probability': float(active_prob),
                'non_active_probability': float(non_active_prob)
            })
        
        if skipped > 0:
            print(f"Warning: Skipped {skipped} records with invalid probabilities")
        
        print(f"✓ Parsed {len(probabilities)} active probability records")
        
        # Print statistics
        if probabilities:
            avg_prob = sum(p['active_probability'] for p in probabilities) / len(probabilities)
            high_prob = sum(1 for p in probabilities if p['active_probability'] > 0.7)
            print(f"  Average active probability: {avg_prob:.3f}")
            print(f"  High confidence predictions (>0.7): {high_prob}")
        
        return probabilities
    
    def get_statistics(self, probabilities: List[Dict]) -> Dict:
        """
        Get statistics about parsed probabilities.
        
        Args:
            probabilities: List of probability dictionaries
            
        Returns:
            Dictionary with statistics
        """
        if not probabilities:
            return {}
        
        active_probs = [p['active_probability'] for p in probabilities]
        
        return {
            'total_records': len(probabilities),
            'avg_active_probability': sum(active_probs) / len(active_probs),
            'min_active_probability': min(active_probs),
            'max_active_probability': max(active_probs),
            'high_confidence_count': sum(1 for p in active_probs if p > 0.7),
            'medium_confidence_count': sum(1 for p in active_probs if 0.3 <= p <= 0.7),
            'low_confidence_count': sum(1 for p in active_probs if p < 0.3),
            'unique_targets': len(set(p['target_id'] for p in probabilities))
        }


if __name__ == '__main__':
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python active_probability_parser.py <active_probabilities.csv>")
        sys.exit(1)
    
    csv_file = sys.argv[1]
    parser = ActiveProbabilityParser(csv_file)
    
    # Parse
    probabilities = parser.parse()
    
    # Show statistics
    stats = parser.get_statistics(probabilities)
    print("\nStatistics:")
    for key, value in stats.items():
        print(f"  {key}: {value}")
    
    # Show sample
    if probabilities:
        print("\nSample records:")
        for i, prob in enumerate(probabilities[:3]):
            print(f"\n{i+1}. Target: {prob['target_id']}")
            print(f"   Active probability: {prob['active_probability']:.3f}")
            print(f"   Activity: {prob['activity']}")
            if prob['gene_names']:
                print(f"   Genes: {prob['gene_names']}")
