#!/usr/bin/env python3
"""
Side Effect Predictor - Core prediction engine.
Predicts side effects from SMILES strings using similarity search and active probabilities.
"""

import psycopg2
from rdkit import Chem
from rdkit.Chem import AllChem
from rdkit import DataStructs
from typing import Dict, List, Tuple, Optional
import os
from dotenv import load_dotenv
import pickle
import numpy as np
import warnings
import json
from rdkit import RDLogger
RDLogger.DisableLog('rdApp.*')


class SideEffectPredictor:
    """Predicts side effects from molecular structures."""

    BLACKLIST_TERMS = {
        "escherichia",
        "e. coli",
        "e.coli",
        "ecoli",
        "staphylococcus",
        "pseudomonas",
        "homo sapiens",
        "rattus norvegicus",
        "mus musculus",
        "saccharomyces",
        "bovine spongiform encephalopathy",
        "helicobacter",
        "klebsiella",
        # Avoid exact matching 'Candida' alone if 'Candidiasis' is a valid result,
        # but the request is to block Organisms. Usually the infections are fine, 
        # but we want to block the organism. For safety, let's keep candida albicans
        "candida albicans"
    }
    
    def __init__(self, conn=None, similarity_threshold: float = 0.7, 
                 min_confidence: float = 0.1):
        """
        Initialize predictor.
        
        Args:
            conn: Database connection (if None, creates new one)
            similarity_threshold: Minimum Tanimoto similarity for drug matching
            min_confidence: Minimum confidence for predictions
        """
        if conn is None:
            load_dotenv()
            self.conn = psycopg2.connect(
                host=os.getenv('DB_HOST', 'localhost'),
                port=os.getenv('DB_PORT', '5432'),
                database=os.getenv('DB_NAME', 'side_effect_estimator'),
                user=os.getenv('DB_USER', 'postgres'),
                password=os.getenv('DB_PASSWORD')
            )
            self.own_connection = True
        else:
            self.conn = conn
            self.own_connection = False
        
        self.similarity_threshold = similarity_threshold
        self.min_confidence = min_confidence
    
    def __del__(self):
        """Clean up connection if we own it."""
        if self.own_connection and hasattr(self, 'conn'):
            self.conn.close()

    def _is_valid_side_effect(self, name: str) -> bool:
        """Check if side effect name is valid (e.g. not an organism)."""
        if not name:
            return False
            
        lower_name = name.lower()
        
        # Substring match against blacklist
        for term in self.BLACKLIST_TERMS:
            if term in lower_name:
                return False
                
        return True
    
    def _infer_severity(self, side_effect: str, db_severity: Optional[str]) -> str:
        """Infer severity from text if missing in DB."""
        if db_severity and db_severity != 'unknown':
            return db_severity
            
        lower_se = side_effect.lower()
        if any(term in lower_se for term in ['death', 'failure', 'shock', 'arrest', 'coma', 'suicide', 'anaphylactic', 'malignant', 'carcinoma']):
            return 'severe'
        if any(term in lower_se for term in ['bleeding', 'fracture', 'ulcer', 'hepatitis', 'arrhythmia', 'seizure', 'infarction']):
            return 'severe'
        if any(term in lower_se for term in ['pain', 'nausea', 'vomiting', 'diarrhea', 'headache', 'rash', 'dizziness', 'fatigue', 'cough', 'itching']):
            return 'mild'
        if any(term in lower_se for term in ['fever', 'swelling', 'anxiety', 'insomnia', 'depression', 'hypertension', 'hypotension']):
            return 'moderate'
            
        return 'moderate'  # Default to moderate if unknown
        
    def predict_from_smiles(self, smiles: str, max_similar_drugs: int = 10) -> Dict:
        """
        Predict side effects from SMILES string.
        
        Args:
            smiles: SMILES string of molecule
            max_similar_drugs: Maximum number of similar drugs to consider
            
        Returns:
            Dictionary with predictions, similar drugs, and explanations
        """
        # Validate SMILES
        mol = Chem.MolFromSmiles(smiles)
        if mol is None:
            raise ValueError(f"Invalid SMILES: {smiles}")
        
        # Compute fingerprint
        fp = AllChem.GetMorganFingerprintAsBitVect(mol, radius=2, nBits=2048)
        fp_binary = ''.join([str(int(x)) for x in fp])
        
        # Find similar drugs
        similar_drugs = self._find_similar_drugs(fp_binary, max_similar_drugs)
        
        # Predict targets and side effects
        if similar_drugs:
            # Use similarity-based prediction
            predictions = self._predict_from_similar_drugs(similar_drugs, fp)
            method = "similarity"
        else:
            # Try ML-based prediction first
            ml_predictions = self._predict_from_ml_model(smiles, fp)
            if ml_predictions:
                predictions = ml_predictions
                method = "machine_learning"
            else:
                # Fallback to active probability-based prediction
                predictions = self._predict_from_active_probabilities(smiles)
                method = "active_probability"
        
        # Always compute target-based analysis for report enrichment
        # (gives mechanism, pathways, justification even when similarity is primary)
        target_predictions = []
        try:
            target_predictions = self._predict_from_active_probabilities(smiles)
        except Exception:
            pass
            
        # Merge similarity and target predictions for hybrid approach
        if method == "similarity" and target_predictions:
            predictions = self._merge_predictions(predictions, target_predictions)
            method = "hybrid_similarity_target"
        
        # Calculate overall risk score
        risk_score = self._calculate_risk_score(predictions)
        
        return {
            'smiles': smiles,
            'method': method,
            'similar_drugs': similar_drugs,
            'predictions': predictions,
            'target_analysis': target_predictions,
            'overall_risk_score': risk_score,
            'confidence': self._calculate_overall_confidence(predictions)
        }
    
    def _merge_predictions(self, sim_preds: List[Dict], target_preds: List[Dict]) -> List[Dict]:
        """Merge similarity-based and target-based predictions."""
        merged_map = {}
        
        # Index similarity predictions
        for p in sim_preds:
            se = p['side_effect']
            if not self._is_valid_side_effect(se):
                continue
            merged_map[se] = {
                'side_effect': se,
                'sim_prob': p['probability'],
                'target_prob': 0.0,
                'sim_conf': p['confidence'],
                'target_conf': 0.0,
                'severity': self._infer_severity(se, p['severity']),
                'evidence_count': p['evidence_count'],
                'mechanisms': [p['mechanism']] if p.get('mechanism') else [],
                'justifications': [p['justification']] if p.get('justification') else [],
                'pathways': p.get('pathways', []),
                'contributing_compounds': p.get('contributing_compounds', [])
            }

        # Merge target predictions
        for p in target_preds:
            se = p['side_effect']
            if not self._is_valid_side_effect(se):
                continue
            if se not in merged_map:
                merged_map[se] = {
                    'side_effect': se,
                    'sim_prob': 0.0,
                    'target_prob': p['probability'],
                    'sim_conf': 0.0,
                    'target_conf': p['confidence'],
                    'severity': self._infer_severity(se, p['severity']),
                    'evidence_count': 0,
                    'mechanisms': [],
                    'justifications': [],
                    'pathways': [],
                    'contributing_compounds': []
                }
            
            entry = merged_map[se]
            entry['target_prob'] = p['probability']
            entry['target_conf'] = p['confidence']
            if p.get('mechanism'):
                entry['mechanisms'].append(p['mechanism'])
            if p.get('justification'):
                entry['justifications'].append(p['justification'])
            # Extend lists
            if p.get('pathways'):
                entry['pathways'].extend(p['pathways'])
                entry['pathways'] = list(set(entry['pathways']))
        
        
        # Finalize merged list
        final_preds = []
        for se, data in merged_map.items():
            # Determine source
            is_target = data['target_prob'] > 0
            is_sim = data['sim_prob'] > 0
            
            if is_target and is_sim:
                source = 'hybrid'
            elif is_target:
                source = 'target'
            else:
                source = 'similarity'

            # Probabilistic OR: P(A or B) = 1 - (1-P(A))*(1-P(B))
            # This boosts side effects supported by BOTH methods
            combined_prob = 1.0 - (1.0 - data['sim_prob']) * (1.0 - data['target_prob'])
            combined_conf = max(data['sim_conf'], data['target_conf'])
            
            # User Feedback Adjustment: 
            # "Move usage closer to active_probabilities... similarity more supportive"
            # Cap similarity-only predictions to "Possible" (<0.5) so they don't crowd out target results
            if source == 'similarity':
                combined_prob = min(combined_prob, 0.49)
            
            # Combine mechanisms string
            mech_str = "; ".join(data['mechanisms'])
            if not mech_str:
                mech_str = "Inferred from structure/targets"
            
            # Combine justifications
            just_str = "; ".join(data['justifications'])
            
            final_preds.append({
                'side_effect': se,
                'probability': min(combined_prob, 1.0),
                'confidence': combined_conf,
                'severity': data['severity'],
                'evidence_count': data['evidence_count'],
                'mechanism': mech_str,
                'justification': just_str,
                'pathways': data['pathways'],
                'contributing_compounds': data['contributing_compounds'],
                'source': source  # Add source for report splitting
            })
            
        # Sort by probability DESC
        final_preds.sort(key=lambda x: x['probability'], reverse=True)
        return final_preds

    def _find_similar_drugs(self, fp_binary: str, max_drugs: int) -> List[Dict]:
        """Find similar drugs in database using fingerprint similarity."""
        with self.conn.cursor() as cur:
            # Get all drugs with fingerprints
            cur.execute("""
                SELECT drug_id, drug_name, smiles, fingerprint_morgan2048
                FROM drugs
                WHERE fingerprint_morgan2048 IS NOT NULL
            """)
            
            similar_drugs = []
            query_fp = DataStructs.ExplicitBitVect(2048)
            for i, bit in enumerate(fp_binary):
                if bit == '1':
                    query_fp.SetBit(i)
            
            for row in cur.fetchall():
                drug_id, drug_name, smiles, db_fp_str = row
                
                # Convert database fingerprint to RDKit format
                db_fp = DataStructs.ExplicitBitVect(2048)
                for i, bit in enumerate(db_fp_str):
                    if bit == '1':
                        db_fp.SetBit(i)
                
                # Calculate Tanimoto similarity
                similarity = DataStructs.TanimotoSimilarity(query_fp, db_fp)
                
                if similarity >= self.similarity_threshold:
                    similar_drugs.append({
                        'drug_id': drug_id,
                        'drug_name': drug_name,
                        'smiles': smiles,
                        'similarity': similarity
                    })
            
            # Sort by similarity and limit
            similar_drugs.sort(key=lambda x: x['similarity'], reverse=True)
            return similar_drugs[:max_drugs]
    
    def _predict_from_similar_drugs(self, similar_drugs: List[Dict], 
                                     query_fp) -> List[Dict]:
        """Predict side effects based on similar drugs."""
        drug_ids = [d['drug_id'] for d in similar_drugs]
        similarity_map = {d['drug_id']: d['similarity'] for d in similar_drugs}
        drug_name_map = {d['drug_id']: d['drug_name'] for d in similar_drugs}
        drug_smiles_map = {d['drug_id']: d.get('smiles') for d in similar_drugs}
        
        with self.conn.cursor() as cur:
            # Get side effects from similar drugs with array_agg to identify contributors
            cur.execute("""
                SELECT 
                    se.side_effect_name,
                    se.severity,
                    COUNT(DISTINCT dse.drug_id) as drug_count,
                    AVG(CASE 
                        WHEN dse.frequency = 'common' THEN 0.7
                        WHEN dse.frequency = 'uncommon' THEN 0.3
                        WHEN dse.frequency = 'rare' THEN 0.1
                        ELSE 0.5
                    END) as avg_frequency,
                    array_agg(DISTINCT dse.drug_id) as supporting_drug_ids
                FROM drug_side_effects dse
                JOIN side_effects se ON dse.side_effect_id = se.side_effect_id
                WHERE dse.drug_id = ANY(%s)
                GROUP BY se.side_effect_name, se.severity
                HAVING COUNT(DISTINCT dse.drug_id) >= 1
            """, (drug_ids,))
            
            predictions = []
            for row in cur.fetchall():
                side_effect, severity, drug_count, avg_freq, supporting_ids = row
                
                if not self._is_valid_side_effect(side_effect):
                    continue
                
                # Calculate weighted probability based on similarity
                weighted_prob = float(avg_freq) * (drug_count / len(drug_ids))
                
                # Identify contributing compounds
                contributors = []
                for did in supporting_ids:
                    if did in similarity_map:
                        contributors.append({
                            'name': drug_name_map.get(did, 'Unknown'),
                            'similarity': similarity_map[did]
                        })
                # Sort contributors by similarity
                contributors.sort(key=lambda x: x['similarity'], reverse=True)
                
                # Justification
                top_drug = contributors[0] if contributors else {'name': 'Unknown', 'similarity': 0}
                justification = (f"Observed in similar drug '{top_drug['name']}' "
                               f"(Similarity: {top_drug['similarity']:.2f})")

                # Get mechanism explanation (approximate via targets of similar drugs)
                # mechanism = self._get_mechanism(side_effect, supporting_ids) 
                # Optimization: _get_mechanism query is expensive inside loop.
                # For now, let's keep it simple or remove it if slow. 
                # The user wants "compounds it is using to draw these conclusions". We have that.
                mechanism = f"Present in {len(contributors)} similar drugs"
                
                predictions.append({
                    'side_effect': side_effect,
                    'probability': min(weighted_prob, 1.0),
                    'confidence': drug_count / len(drug_ids),
                    'severity': self._infer_severity(side_effect, severity),
                    'evidence_count': drug_count,
                    'mechanism': mechanism,
                    'justification': justification,
                    'pathways': [], # Similarity method doesn't directly link pathways
                    'contributing_compounds': contributors[:5]
                })
        
        # Filter by minimum confidence
        predictions = [p for p in predictions if p['confidence'] >= self.min_confidence]
        
        # Sort by probability
        predictions.sort(key=lambda x: x['probability'], reverse=True)
        
        return predictions
    
    def _predict_from_active_probabilities(self, smiles: str) -> List[Dict]:
        """Predict side effects using active probability data."""
        with self.conn.cursor() as cur:
            # Get high-probability targets with pathway info
            cur.execute("""
                SELECT 
                    ap.target_id,
                    t.target_name,
                    ap.active_probability,
                    t.pathway_info
                FROM active_probabilities ap
                JOIN targets t ON ap.target_id = t.target_id
                WHERE ap.active_probability > 0.5
                ORDER BY ap.active_probability DESC
                LIMIT 20
            """)
            
            predicted_targets = cur.fetchall()
            
            if not predicted_targets:
                return []
            
            target_ids = [t[0] for t in predicted_targets]
            # Map target_id -> {prob, name, pathways}
            target_info_map = {
                t[0]: {
                    'active_probability': t[2],
                    'target_name': t[1],
                    'pathways': self._format_pathways(t[3])
                } 
                for t in predicted_targets
            }
            
            # Get side effects for these targets
            cur.execute("""
                SELECT 
                    se.side_effect_name,
                    se.severity,
                    tse.target_id,
                    tse.confidence_score,
                    tse.evidence_count
                FROM target_side_effects tse
                JOIN side_effects se ON tse.side_effect_id = se.side_effect_id
                WHERE tse.target_id = ANY(%s)
                AND tse.confidence_score >= %s
            """, (target_ids, self.min_confidence))
            
            # Aggregate predictions
            side_effect_data = {}
            for row in cur.fetchall():
                se_name, severity, target_id, conf_score, evidence = row
                
                if not self._is_valid_side_effect(se_name):
                    continue
                
                if se_name not in side_effect_data:
                    side_effect_data[se_name] = {
                        'side_effect': se_name,
                        'severity': severity or 'unknown',
                        'targets': [],
                        'total_evidence': 0
                    }
                
                t_info = target_info_map[target_id]
                side_effect_data[se_name]['targets'].append({
                    'target_id': target_id,
                    'target_name': t_info['target_name'],
                    'confidence': conf_score,
                    'active_prob': t_info['active_probability'],
                    'pathways': t_info['pathways']
                })
                side_effect_data[se_name]['total_evidence'] += evidence
            
            # Calculate probabilities and format output
            predictions = []
            for se_name, data in side_effect_data.items():
                # Weighted average of target probabilities
                prob = sum(t['active_prob'] * t['confidence'] 
                          for t in data['targets']) / len(data['targets'])
                
                confidence = sum(t['confidence'] for t in data['targets']) / len(data['targets'])
                
                # Get detailed mechanism
                mechanism = self._get_detailed_mechanism(data['targets'])
                
                # Collect all unique pathways
                all_pathways = set()
                for t in data['targets']:
                    all_pathways.update(t['pathways'])
                
                # Justification string
                top_target = max(data['targets'], key=lambda x: x['confidence'])
                justification = (f"High confidence binding to {top_target['target_name']} "
                               f"(Conf: {top_target['confidence']:.2f})")
                
                predictions.append({
                    'side_effect': se_name,
                    'probability': min(prob, 1.0),
                    'confidence': confidence,
                    'severity': data['severity'],
                    'evidence_count': data['total_evidence'],
                    'mechanism': mechanism,
                    'justification': justification,
                    'pathways': list(all_pathways),
                    'contributing_compounds': []  # No similar drugs in this method
                })
            
            predictions.sort(key=lambda x: x['probability'], reverse=True)
            return predictions

    def _predict_from_ml_model(self, smiles: str, fp) -> List[Dict]:
        """Predict using trained ML model."""
        model_path = 'ml/models/target_predictor.pkl'
        names_path = 'ml/models/target_names.pkl'
        
        if not os.path.exists(model_path) or not os.path.exists(names_path):
            return []
            
        try:
            # Load models (cached would be better but this is CLI)
            with open(model_path, 'rb') as f:
                model = pickle.load(f)
            with open(names_path, 'rb') as f:
                target_names = pickle.load(f)
                
            # Convert fingerprint to numpy array
            fp_binary = ''.join([str(int(x)) for x in fp])
            X = np.array([[int(x) for x in fp_binary]], dtype=np.int8)
            
            # Predict probabilities
            # Suppress sklearn warnings about feature names
            with warnings.catch_warnings():
                warnings.simplefilter("ignore")
                # predict_proba returns a list of arrays, one for each target
                probs_list = model.predict_proba(X)
            
            # Get predicted targets with prob > 0.1
            predicted_targets = []
            
            for i, target_name in enumerate(target_names):
                # Handle prob array shape (n_samples, n_classes)
                # usually list of [prob_0, prob_1]
                p_arr = probs_list[i]
                if p_arr.shape[1] == 2:
                    prob = p_arr[0][1]
                else:
                    # Single class case
                    classes = model.estimators_[i].classes_
                    prob = 1.0 if (len(classes) == 1 and classes[0] == 1) else 0.0
                
                if prob >= 0.1:  # Lower threshold for multi-label inference
                    predicted_targets.append(target_name)
            
            if not predicted_targets:
                return []
                
            # Map predictions to side effects
            return self._map_targets_to_side_effects(predicted_targets)
            
        except Exception as e:
            print(f"ML Prediction error: {e}")
            return []

    def _map_targets_to_side_effects(self, target_names: List[str]) -> List[Dict]:
        """Map target names to side effects."""
        with self.conn.cursor() as cur:
            # Get target IDs
            cur.execute("SELECT target_id, target_name FROM targets WHERE target_name = ANY(%s)", (target_names,))
            rows = cur.fetchall()
            target_map = {row[1]: row[0] for row in rows}
            target_ids = list(target_map.values())
            
            if not target_ids:
                return []
                
            # Get side effects
            cur.execute("""
                SELECT 
                    se.side_effect_name,
                    se.severity,
                    tse.target_id,
                    tse.confidence_score,
                    tse.evidence_count
                FROM target_side_effects tse
                JOIN side_effects se ON tse.side_effect_id = se.side_effect_id
                WHERE tse.target_id = ANY(%s)
                AND tse.confidence_score >= %s
            """, (target_ids, self.min_confidence))
            
            # Aggregate
            side_effect_data = {}
            for row in cur.fetchall():
                se_name, severity, target_id, conf_score, evidence = row
                
                if not self._is_valid_side_effect(se_name):
                    continue
                
                if se_name not in side_effect_data:
                    side_effect_data[se_name] = {
                        'side_effect': se_name,
                        'severity': severity or 'unknown',
                        'targets': [],
                        'total_evidence': 0
                    }
                
                side_effect_data[se_name]['targets'].append({
                    'target_id': target_id,
                    'confidence': conf_score,
                    'active_prob': 0.8  # High probability because ML predicted it
                })
                side_effect_data[se_name]['total_evidence'] += evidence
            
            # Calculate probabilities
            predictions = []
            for se_name, data in side_effect_data.items():
                prob = sum(t['active_prob'] * t['confidence'] 
                          for t in data['targets']) / len(data['targets'])
                
                confidence = sum(t['confidence'] for t in data['targets']) / len(data['targets'])
                
                predictions.append({
                    'side_effect': se_name,
                    'probability': min(prob, 1.0),
                    'confidence': confidence,
                    'severity': data['severity'],
                    'evidence_count': data['total_evidence'],
                    'mechanism': f"Predicted binding to: {', '.join(target_names[:3])}"
                })
            
            predictions.sort(key=lambda x: x['probability'], reverse=True)
            return predictions
    
    def _get_mechanism(self, side_effect: str, drug_ids: List[str]) -> str:
        """Get mechanistic explanation for side effect."""
        with self.conn.cursor() as cur:
            cur.execute("""
                SELECT DISTINCT t.target_name, t.gene_symbol
                FROM drug_targets dt
                JOIN targets t ON dt.target_id = t.target_id
                JOIN target_side_effects tse ON t.target_id = tse.target_id
                JOIN side_effects se ON tse.side_effect_id = se.side_effect_id
                WHERE dt.drug_id = ANY(%s)
                AND se.side_effect_name = %s
                LIMIT 3
            """, (drug_ids, side_effect))
            
            targets = cur.fetchall()
            
            if targets:
                target_names = [t[0] or t[1] for t in targets if t[0] or t[1]]
                if target_names:
                    return f"Associated with {', '.join(target_names[:2])}"
            
            return "Mechanism unknown"
    
    def _calculate_risk_score(self, predictions: List[Dict]) -> float:
        """Calculate overall risk score (0-10)."""
        if not predictions:
            return 0.0
        
        severity_weights = {
            'mild': 1.0,
            'moderate': 2.0,
            'severe': 3.0,
            'unknown': 1.5
        }
        
        total_risk = 0.0
        for pred in predictions:
            severity_weight = severity_weights.get(pred['severity'], 1.5)
            total_risk += pred['probability'] * severity_weight * pred['confidence']
        
        # Normalize to 0-10 scale
        max_possible = len(predictions) * 3.0  # Max severity * max prob * max conf
        if max_possible > 0:
            risk_score = (total_risk / max_possible) * 10
        else:
            risk_score = 0.0
        
        return min(risk_score, 10.0)

    def _format_pathways(self, pathway_data) -> List[str]:
        """Format pathway JSON into readable strings."""
        if not pathway_data:
            return []
            
        if isinstance(pathway_data, str):
            try:
                pathways = json.loads(pathway_data)
            except json.JSONDecodeError:
                return []
        else:
            pathways = pathway_data

        # Prioritize Reactome/KEGG
        formatted = []
        seen = set()
        for p in pathways:
            name = p.get('name')
            if name and name not in seen:
                formatted.append(name)
                seen.add(name)
        return formatted[:5]  # Limit to top 5

    def _get_detailed_mechanism(self, targets: List[Dict]) -> str:
        """Generate detailed mechanism string from targets."""
        if not targets:
            return "Unknown mechanism"
        
        target_names = [t['target_name'] for t in targets[:3]]
        mech = f"Binding to {', '.join(target_names)}"
        if len(targets) > 3:
            mech += f" and {len(targets)-3} others"
            
        # Check for shared pathways
        all_pathways = []
        for t in targets:
            all_pathways.extend(t.get('pathways', []))
        
        if all_pathways:
            # Find most common pathway
            from collections import Counter
            common = Counter(all_pathways).most_common(1)
            if common:
                mech += f" (Pathway: {common[0][0]})"
        
        return mech
    
    def _calculate_overall_confidence(self, predictions: List[Dict]) -> float:
        """Calculate overall confidence in predictions."""
        if not predictions:
            return 0.0
        
        return sum(p['confidence'] for p in predictions) / len(predictions)
    
    def predict_from_drug_name(self, drug_name: str) -> Dict:
        """
        Predict side effects from known drug name.
        
        Args:
            drug_name: Name of drug
            
        Returns:
            Prediction dictionary
        """
        with self.conn.cursor() as cur:
            cur.execute("""
                SELECT smiles FROM drugs 
                WHERE LOWER(drug_name) = LOWER(%s)
                LIMIT 1
            """, (drug_name,))
            
            result = cur.fetchone()
            if not result or not result[0]:
                raise ValueError(f"Drug '{drug_name}' not found or has no SMILES")
            
            return self.predict_from_smiles(result[0])


if __name__ == '__main__':
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python side_effect_predictor.py <SMILES>")
        print("   or: python side_effect_predictor.py --drug <drug_name>")
        sys.exit(1)
    
    predictor = SideEffectPredictor()
    
    if sys.argv[1] == '--drug':
        if len(sys.argv) < 3:
            print("Error: Drug name required")
            sys.exit(1)
        drug_name = ' '.join(sys.argv[2:])
        result = predictor.predict_from_drug_name(drug_name)
    else:
        smiles = sys.argv[1]
        result = predictor.predict_from_smiles(smiles)
    
    # Print results
    print(f"\n{'='*70}")
    print("SIDE EFFECT PREDICTION")
    print(f"{'='*70}")
    print(f"SMILES: {result['smiles']}")
    print(f"Method: {result['method']}")
    print(f"Overall Risk Score: {result['overall_risk_score']:.1f}/10")
    print(f"Confidence: {result['confidence']:.2f}")
    
    if result['similar_drugs']:
        print(f"\nSimilar Drugs ({len(result['similar_drugs'])}):")
        for drug in result['similar_drugs'][:3]:
            print(f"  • {drug['drug_name']} (similarity: {drug['similarity']:.2f})")
    
    print(f"\nPredicted Side Effects ({len(result['predictions'])}):")
    print(f"{'Side Effect':<30} {'Prob':<8} {'Conf':<8} {'Severity':<12}")
    print("-" * 70)
    
    for pred in result['predictions'][:15]:
        print(f"{pred['side_effect']:<30} {pred['probability']:<8.2f} "
              f"{pred['confidence']:<8.2f} {pred['severity']:<12}")
