#!/usr/bin/env python3
"""
OnSIDES Parser for Side Effect Estimator.
Extracts side effect information from OnSIDES database files.

OnSIDES (Observational Studies and NLP Identification of Drug Effects and Safety)
provides drug-side effect associations extracted from FDA drug labels using NLP/ML.
"""

import os
import pandas as pd
from typing import Dict, List, Optional, Tuple
from tqdm import tqdm


class OnSIDESParser:
    """Parser for OnSIDES database files."""
    
    def __init__(self, csv_dir: str, min_confidence: float = 0.5):
        """
        Initialize parser with OnSIDES CSV directory.
        
        Args:
            csv_dir: Path to OnSIDES/csv directory
            min_confidence: Minimum ML confidence score to include (0-1)
        """
        self.csv_dir = csv_dir
        self.min_confidence = min_confidence
        
        # File paths
        self.product_adverse_effect_file = os.path.join(csv_dir, 'product_adverse_effect.csv')
        self.meddra_vocab_file = os.path.join(csv_dir, 'vocab_meddra_adverse_effect.csv')
        self.rxnorm_ingredient_file = os.path.join(csv_dir, 'vocab_rxnorm_ingredient.csv')
        self.product_label_file = os.path.join(csv_dir, 'product_label.csv')
        self.product_to_rxnorm_file = os.path.join(csv_dir, 'product_to_rxnorm.csv')
        self.rxnorm_product_file = os.path.join(csv_dir, 'vocab_rxnorm_product.csv')
        self.ingredient_to_product_file = os.path.join(csv_dir, 'vocab_rxnorm_ingredient_to_product.csv')
        
    def parse(self) -> Dict[str, any]:
        """
        Parse OnSIDES files and return structured data.
        
        Returns:
            Dictionary with keys: 
              - 'side_effects': List of side effect dicts
              - 'drug_side_effects': List of drug-SE association dicts
              - 'drug_names': Dict mapping rxnorm_id to drug name
        """
        print(f"Loading OnSIDES data from {self.csv_dir}...")
        
        # Load MedDRA vocabulary
        meddra_vocab = self._load_meddra_vocabulary()
        
        # Load drug ingredient names
        drug_names = self._load_drug_names()
        
        # Load product to ingredient mapping
        product_to_ingredients = self._load_product_to_ingredients()
        
        # Load and process main drug-SE associations
        side_effects, drug_side_effects = self._process_drug_side_effects(
            meddra_vocab, drug_names, product_to_ingredients
        )
        
        print(f"\nOnSIDES Summary:")
        print(f"  Unique side effects: {len(side_effects):,}")
        print(f"  Drug-SE associations: {len(drug_side_effects):,}")
        print(f"  Unique drug ingredients: {len(drug_names):,}")
        
        return {
            'side_effects': side_effects,
            'drug_side_effects': drug_side_effects,
            'drug_names': drug_names
        }
    
    def _load_meddra_vocabulary(self) -> Dict[int, Dict]:
        """Load MedDRA vocabulary mapping."""
        print("Loading MedDRA vocabulary...")
        df = pd.read_csv(self.meddra_vocab_file)
        
        vocab = {}
        for _, row in df.iterrows():
            vocab[row['meddra_id']] = {
                'meddra_id': str(row['meddra_id']),
                'side_effect_name': row['meddra_name'],
                'term_type': row['meddra_term_type']
            }
        
        print(f"  Loaded {len(vocab):,} MedDRA terms")
        return vocab
    
    def _load_drug_names(self) -> Dict[int, str]:
        """Load RxNorm ingredient names."""
        print("Loading drug ingredient names...")
        df = pd.read_csv(self.rxnorm_ingredient_file)
        
        names = {}
        for _, row in df.iterrows():
            names[row['rxnorm_id']] = row['rxnorm_name']
        
        print(f"  Loaded {len(names):,} drug ingredients")
        return names
    
    def _load_product_to_ingredients(self) -> Dict[int, List[int]]:
        """
        Load mapping from product_label_id to ingredient RxNorm IDs.
        
        This requires chaining:
        product_label -> product_to_rxnorm -> vocab_rxnorm_ingredient_to_product -> ingredient
        """
        print("Loading product-to-ingredient mappings...")
        
        # Load product_to_rxnorm (label_id -> rxnorm_product_id)
        product_to_rxnorm_df = pd.read_csv(self.product_to_rxnorm_file)
        label_to_product = {}
        for _, row in product_to_rxnorm_df.iterrows():
            label_id = row['label_id']
            if label_id not in label_to_product:
                label_to_product[label_id] = []
            label_to_product[label_id].append(row['rxnorm_product_id'])
        
        # Load ingredient_to_product (product_id -> ingredient_id)
        ing_to_prod_df = pd.read_csv(self.ingredient_to_product_file)
        product_to_ing = {}
        for _, row in ing_to_prod_df.iterrows():
            prod_id = row['product_id']
            if prod_id not in product_to_ing:
                product_to_ing[prod_id] = []
            product_to_ing[prod_id].append(row['ingredient_id'])
        
        # Chain: label_id -> product_ids -> ingredient_ids
        label_to_ingredients = {}
        for label_id, product_ids in label_to_product.items():
            ingredients = set()
            for prod_id in product_ids:
                if prod_id in product_to_ing:
                    ingredients.update(product_to_ing[prod_id])
            if ingredients:
                label_to_ingredients[label_id] = list(ingredients)
        
        print(f"  Mapped {len(label_to_ingredients):,} product labels to ingredients")
        return label_to_ingredients
    
    def _process_drug_side_effects(
        self, 
        meddra_vocab: Dict[int, Dict],
        drug_names: Dict[int, str],
        product_to_ingredients: Dict[int, List[int]]
    ) -> Tuple[List[Dict], List[Dict]]:
        """
        Process main drug-side effect file.
        
        Returns:
            Tuple of (side_effects list, drug_side_effects list)
        """
        print(f"Loading drug-side effect associations...")
        
        # Load in chunks due to large file size
        chunk_size = 500000
        side_effects_seen = {}  # meddra_id -> side_effect dict
        drug_se_list = []
        
        # Track unique drug-SE pairs to avoid duplicates
        seen_pairs = set()
        
        total_rows = sum(1 for _ in open(self.product_adverse_effect_file)) - 1
        
        for chunk in tqdm(
            pd.read_csv(self.product_adverse_effect_file, chunksize=chunk_size, low_memory=False),
            total=(total_rows // chunk_size) + 1,
            desc="Processing drug-SE associations"
        ):
            for _, row in chunk.iterrows():
                meddra_id = row['effect_meddra_id']
                product_label_id = row['product_label_id']
                
                # Get confidence score if available
                pred1 = row.get('pred1')
                if pd.notna(pred1) and pred1 < self.min_confidence:
                    continue  # Skip low confidence predictions
                
                # Get MedDRA info
                if meddra_id not in meddra_vocab:
                    continue
                    
                meddra_info = meddra_vocab[meddra_id]
                
                # Add to side effects if not seen
                if meddra_id not in side_effects_seen:
                    side_effects_seen[meddra_id] = {
                        'side_effect_name': meddra_info['side_effect_name'],
                        'meddra_id': meddra_info['meddra_id'],
                        'umls_id': None,  # OnSIDES uses MedDRA, not UMLS
                        'severity': None
                    }
                
                # Get ingredient(s) for this product label
                ingredients = product_to_ingredients.get(product_label_id, [])
                
                for ingredient_id in ingredients:
                    drug_name = drug_names.get(ingredient_id)
                    if not drug_name:
                        continue
                    
                    # Create unique key to avoid duplicates
                    pair_key = (ingredient_id, meddra_id)
                    if pair_key in seen_pairs:
                        continue
                    seen_pairs.add(pair_key)
                    
                    drug_se_list.append({
                        'rxnorm_id': ingredient_id,
                        'drug_name': drug_name,
                        'side_effect_name': meddra_info['side_effect_name'],
                        'meddra_id': meddra_info['meddra_id'],
                        'confidence': pred1 if pd.notna(pred1) else None,
                        'match_method': row.get('match_method'),
                        'source': 'OnSIDES'
                    })
        
        return list(side_effects_seen.values()), drug_se_list


if __name__ == '__main__':
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python onsides_parser.py <onsides_csv_dir> [min_confidence]")
        sys.exit(1)
    
    csv_dir = sys.argv[1]
    min_conf = float(sys.argv[2]) if len(sys.argv) > 2 else 0.5
    
    parser = OnSIDESParser(csv_dir, min_confidence=min_conf)
    data = parser.parse()
    
    print(f"\nResults:")
    print(f"  Side Effects: {len(data['side_effects'])}")
    print(f"  Drug-SE Associations: {len(data['drug_side_effects'])}")
    
    # Show sample
    if data['side_effects']:
        print(f"\nSample side effect: {data['side_effects'][0]}")
    if data['drug_side_effects']:
        print(f"Sample association: {data['drug_side_effects'][0]}")
