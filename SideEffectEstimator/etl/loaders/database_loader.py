#!/usr/bin/env python3
"""
Database loader for Side Effect Estimator.
Handles batch insertion of parsed data into PostgreSQL with RDKit fingerprint computation.
"""

import psycopg2
from psycopg2.extras import execute_batch
from typing import List, Dict, Optional
from rdkit import Chem
from rdkit.Chem import AllChem
from tqdm import tqdm


class DatabaseLoader:
    """Handles loading parsed data into PostgreSQL database."""
    
    BLACKLIST_TERMS = {
        "Escherichia coli",
        "Staphylococcus aureus",
        "Pseudomonas aeruginosa",
        "Homo sapiens",
        "Rattus norvegicus",
        "Mus musculus",
        "Saccharomyces cerevisiae",
        "Bovine spongiform encephalopathy",
        "Helicobacter pylori",
        "Klebsiella pneumoniae",
        "Candida albicans"
    }

    def __init__(self, conn):
        """
        Initialize loader with database connection.
        
        Args:
            conn: psycopg2 connection object
        """
        self.conn = conn
        
    def load_drugs(self, drugs: List[Dict], batch_size: int = 1000):
        """
        Load drugs into database with computed fingerprints.
        
        Args:
            drugs: List of drug dictionaries
            batch_size: Number of records to insert per batch
        """
        print(f"Loading {len(drugs)} drugs...")
        
        # Prepare data with fingerprints
        drug_records = []
        skipped = 0
        
        for drug in tqdm(drugs, desc="Computing fingerprints"):
            # Compute fingerprint if SMILES is available
            fingerprint = None
            if drug.get('smiles'):
                fingerprint = self._compute_fingerprint(drug['smiles'])
            
            if fingerprint is None and drug.get('smiles'):
                skipped += 1
            
            drug_records.append((
                drug['drug_id'],
                drug['drug_name'],
                drug.get('smiles'),
                drug.get('inchi'),
                drug.get('inchikey'),
                drug.get('molecular_formula'),
                drug.get('molecular_weight'),
                fingerprint,
                drug.get('drugbank_id'),
                drug.get('pubchem_cid')
            ))
        
        if skipped > 0:
            print(f"Warning: {skipped} drugs had invalid SMILES and no fingerprint was computed")
        
        # Insert in batches
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                INSERT INTO drugs (
                    drug_id, drug_name, smiles, inchi, inchikey,
                    molecular_formula, molecular_weight, fingerprint_morgan2048,
                    drugbank_id, pubchem_cid
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s::bit(2048), %s, %s)
                ON CONFLICT (drug_id) DO UPDATE SET
                    drug_name = EXCLUDED.drug_name,
                    smiles = EXCLUDED.smiles,
                    inchi = EXCLUDED.inchi,
                    inchikey = EXCLUDED.inchikey,
                    molecular_formula = EXCLUDED.molecular_formula,
                    molecular_weight = EXCLUDED.molecular_weight,
                    fingerprint_morgan2048 = EXCLUDED.fingerprint_morgan2048,
                    drugbank_id = EXCLUDED.drugbank_id,
                    pubchem_cid = EXCLUDED.pubchem_cid
            """, drug_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Loaded {len(drug_records)} drugs")
    
    def load_targets(self, targets: List[Dict], batch_size: int = 1000):
        """Load targets into database."""
        print(f"Loading {len(targets)} targets...")
        
        # Remove duplicates based on target_id
        unique_targets = {}
        for target in targets:
            target_id = target['target_id']
            if target_id not in unique_targets:
                unique_targets[target_id] = target
        
        target_records = [
            (
                t['target_id'],
                t['target_name'],
                t.get('target_type'),
                t.get('gene_symbol'),
                t.get('uniprot_id'),
                t.get('pathway_info')
            )
            for t in unique_targets.values()
        ]
        
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                INSERT INTO targets (
                    target_id, target_name, target_type, gene_symbol,
                    uniprot_id, pathway_info
                )
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (target_id) DO UPDATE SET
                    target_name = EXCLUDED.target_name,
                    target_type = EXCLUDED.target_type,
                    gene_symbol = EXCLUDED.gene_symbol,
                    uniprot_id = EXCLUDED.uniprot_id,
                    pathway_info = EXCLUDED.pathway_info
            """, target_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Loaded {len(target_records)} unique targets")
    
    def load_drug_targets(self, drug_targets: List[Dict], batch_size: int = 1000):
        """Load drug-target interactions."""
        print(f"Loading {len(drug_targets)} drug-target interactions...")
        
        interaction_records = [
            (
                dt['drug_id'],
                dt['target_id'],
                dt.get('binding_affinity_value'),
                dt.get('binding_affinity_unit'),
                dt.get('binding_affinity_type'),
                dt.get('interaction_type'),
                dt.get('source', 'DrugBank')
            )
            for dt in drug_targets
        ]
        
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                INSERT INTO drug_targets (
                    drug_id, target_id, binding_affinity_value,
                    binding_affinity_unit, binding_affinity_type,
                    interaction_type, source
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                ON CONFLICT (drug_id, target_id, binding_affinity_type, source) DO NOTHING
            """, interaction_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Loaded drug-target interactions")
    
    def load_dosages(self, dosages: List[Dict], batch_size: int = 1000):
        """Load dosage information."""
        print(f"Loading {len(dosages)} dosage records...")
        
        dosage_records = [
            (
                d['drug_id'],
                d.get('indication'),
                d.get('route'),
                d.get('min_dose_mg'),
                d.get('max_dose_mg'),
                d.get('typical_dose_mg'),
                d.get('frequency'),
                d.get('source', 'DrugBank')
            )
            for d in dosages
        ]
        
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                INSERT INTO drug_dosages (
                    drug_id, indication, route, min_dose_mg,
                    max_dose_mg, typical_dose_mg, frequency, source
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """, dosage_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Loaded dosage information")
    
    def load_side_effects(self, side_effects: List[Dict], batch_size: int = 1000):
        """Load side effects into database."""
        print(f"Loading {len(side_effects)} side effects...")
        
        # Filter out blacklisted terms
        valid_side_effects = [
            se for se in side_effects 
            if se['side_effect_name'] not in self.BLACKLIST_TERMS
        ]
        
        if len(valid_side_effects) < len(side_effects):
            print(f"Filtered {len(side_effects) - len(valid_side_effects)} invalid side effects (organisms, etc.)")
        
        se_records = [
            (
                se['side_effect_name'],
                se.get('meddra_id'),
                se.get('umls_id'),
                se.get('severity')
            )
            for se in valid_side_effects
        ]
        
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                INSERT INTO side_effects (
                    side_effect_name, meddra_id, umls_id, severity
                )
                VALUES (%s, %s, %s, %s)
                ON CONFLICT (side_effect_name) DO UPDATE SET
                    meddra_id = EXCLUDED.meddra_id,
                    umls_id = EXCLUDED.umls_id,
                    severity = EXCLUDED.severity
            """, se_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Loaded side effects")
    
    def load_drug_side_effects(self, drug_side_effects: List[Dict], 
                                pubchem_to_drugbank: Dict[int, str],
                                batch_size: int = 1000):
        """
        Load drug-side effect associations.
        
        Args:
            drug_side_effects: List of drug-SE associations from SIDER
            pubchem_to_drugbank: Mapping from PubChem CID to DrugBank ID
            batch_size: Batch size for insertion
        """
        print(f"Loading {len(drug_side_effects)} drug-side effect associations...")
        
        # First, get side_effect_id mapping
        with self.conn.cursor() as cur:
            cur.execute("SELECT side_effect_id, side_effect_name, umls_id FROM side_effects")
            se_name_to_id = {row[1]: row[0] for row in cur.fetchall()}
            se_umls_to_id = {row[2]: row[0] for row in cur.fetchall() if row[2]}
        
        dse_records = []
        skipped = 0
        
        for dse in drug_side_effects:
            # Map PubChem CID to DrugBank ID
            pubchem_cid = dse.get('pubchem_cid')
            drug_id = pubchem_to_drugbank.get(pubchem_cid)
            
            if not drug_id:
                # Try string lookup if int failed (or vice versa)
                drug_id = pubchem_to_drugbank.get(str(pubchem_cid))
                
            if not drug_id:
                skipped += 1
                continue
            
            # Get side effect ID
            se_id = se_umls_to_id.get(dse.get('umls_id'))
            if not se_id:
                se_id = se_name_to_id.get(dse.get('side_effect_name'))
            
            if not se_id:
                skipped += 1
                continue
            
            dse_records.append((
                drug_id,
                se_id,
                dse.get('frequency'),
                dse.get('source', 'SIDER')
            ))
        
        if skipped > 0:
            print(f"Warning: Skipped {skipped} associations (drug or side effect not found)")
        
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                INSERT INTO drug_side_effects (
                    drug_id, side_effect_id, frequency, source
                )
                VALUES (%s, %s, %s, %s)
                ON CONFLICT (drug_id, side_effect_id, source) DO NOTHING
            """, dse_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Loaded {len(dse_records)} drug-side effect associations")
    
    def compute_target_side_effect_links(self):
        """
        Compute aggregated target-side effect links based on drug evidence.
        This creates the knowledge base for predicting side effects from targets.
        """
        print("Computing target-side effect links...")
        
        with self.conn.cursor() as cur:
            # Clear existing data
            cur.execute("DELETE FROM target_side_effects")
            
            # Aggregate evidence
            cur.execute("""
                INSERT INTO target_side_effects (
                    target_id, side_effect_id, evidence_count, confidence_score
                )
                SELECT 
                    dt.target_id,
                    dse.side_effect_id,
                    COUNT(DISTINCT dt.drug_id) as evidence_count,
                    LEAST(1.0, COUNT(DISTINCT dt.drug_id)::float / 
                        NULLIF((SELECT COUNT(DISTINCT drug_id) 
                                FROM drug_targets 
                                WHERE target_id = dt.target_id), 0)) as confidence_score
                FROM drug_targets dt
                JOIN drug_side_effects dse ON dt.drug_id = dse.drug_id
                GROUP BY dt.target_id, dse.side_effect_id
                HAVING COUNT(DISTINCT dt.drug_id) >= 1
            """)
            
            rows_inserted = cur.rowcount
        
        self.conn.commit()
        print(f"✓ Computed {rows_inserted} target-side effect links")
    
    @staticmethod
    def _compute_fingerprint(smiles: str) -> Optional[str]:
        """
        Compute Morgan fingerprint from SMILES.
        
        Args:
            smiles: SMILES string
            
        Returns:
            Binary string representation of fingerprint, or None if invalid
        """
        try:
            mol = Chem.MolFromSmiles(smiles)
            if mol is None:
                return None
            
            fp = AllChem.GetMorganFingerprintAsBitVect(mol, radius=2, nBits=2048)
            # Convert to binary string
            fp_binary = ''.join([str(int(x)) for x in fp])
            return fp_binary
        except Exception:
            return None
    
    
    def enrich_drugs_from_pubchem(self, enrichments: List[Dict], batch_size: int = 1000):
        """
        Enrich existing drugs with PubChem data.
        
        Args:
            enrichments: List of enrichment dictionaries from PubChem parser
            batch_size: Batch size for updates
        """
        print(f"Enriching {len(enrichments)} drugs with PubChem data...")
        
        update_records = []
        for enrich in enrichments:
            # Only update if we have new data
            if any(enrich.get(k) for k in ['smiles', 'inchi', 'inchikey', 'molecular_formula', 'molecular_weight', 'pubchem_cid']):
                # Compute fingerprint if SMILES is provided
                fingerprint = None
                if enrich.get('smiles'):
                    fingerprint = self._compute_fingerprint(enrich['smiles'])
                
                update_records.append((
                    enrich.get('smiles'),
                    enrich.get('inchi'),
                    enrich.get('inchikey'),
                    enrich.get('molecular_formula'),
                    enrich.get('molecular_weight'),
                    fingerprint,
                    enrich.get('pubchem_cid'),
                    enrich['drug_id']
                ))
        
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                UPDATE drugs SET
                    smiles = COALESCE(%s, smiles),
                    inchi = COALESCE(%s, inchi),
                    inchikey = COALESCE(%s, inchikey),
                    molecular_formula = COALESCE(%s, molecular_formula),
                    molecular_weight = COALESCE(%s, molecular_weight),
                    fingerprint_morgan2048 = COALESCE(%s::bit(2048), fingerprint_morgan2048),
                    pubchem_cid = COALESCE(%s, pubchem_cid)
                WHERE drug_id = %s
            """, update_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Enriched {len(update_records)} drugs")
    
    def load_chembl_affinities(self, chembl_data: Dict[str, List[Dict]], batch_size: int = 1000):
        """
        Load ChEMBL binding affinity data.
        
        Args:
            chembl_data: Dictionary mapping drug_id to list of affinities
            batch_size: Batch size for insertion
        """
        print("Loading ChEMBL binding affinities...")
        
        target_records = []
        affinity_records = []
        
        for drug_id, affinities in tqdm(chembl_data.items(), desc="Processing ChEMBL data"):
            for aff in affinities:
                target_info = aff.get('target_info')
                if not target_info:
                    continue
                
                # Add target
                uniprot_id = target_info.get('uniprot_id')
                if uniprot_id:
                    target_records.append((
                        uniprot_id,
                        target_info.get('target_name'),
                        target_info.get('target_type'),
                        target_info.get('gene_symbol'),
                        uniprot_id,
                        None  # pathway_info
                    ))
                    
                    # Add affinity
                    affinity_records.append((
                        drug_id,
                        uniprot_id,
                        aff.get('binding_affinity_value'),
                        aff.get('binding_affinity_unit'),
                        aff.get('binding_affinity_type'),
                        None,  # interaction_type (ChEMBL doesn't provide this)
                        'ChEMBL'
                    ))
        
        # Load targets first
        if target_records:
            with self.conn.cursor() as cur:
                execute_batch(cur, """
                    INSERT INTO targets (
                        target_id, target_name, target_type, gene_symbol,
                        uniprot_id, pathway_info
                    )
                    VALUES (%s, %s, %s, %s, %s, %s)
                    ON CONFLICT (target_id) DO UPDATE SET
                        target_name = COALESCE(EXCLUDED.target_name, targets.target_name),
                        target_type = COALESCE(EXCLUDED.target_type, targets.target_type),
                        gene_symbol = COALESCE(EXCLUDED.gene_symbol, targets.gene_symbol)
                """, target_records, page_size=batch_size)
            self.conn.commit()
        
        # Load affinities
        if affinity_records:
            with self.conn.cursor() as cur:
                execute_batch(cur, """
                    INSERT INTO drug_targets (
                        drug_id, target_id, binding_affinity_value,
                        binding_affinity_unit, binding_affinity_type,
                        interaction_type, source
                    )
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                    ON CONFLICT (drug_id, target_id, binding_affinity_type, source) DO NOTHING
                """, affinity_records, page_size=batch_size)
            self.conn.commit()
        
        print(f"✓ Loaded {len(affinity_records)} ChEMBL affinities for {len(target_records)} targets")
    
    def load_bindingdb_affinities(self, bindings: List[Dict], targets: List[Dict], 
                                   batch_size: int = 1000):
        """
        Load BindingDB binding affinity data.
        
        Args:
            bindings: List of binding dictionaries
            targets: List of target dictionaries
            batch_size: Batch size for insertion
        """
        print(f"Loading BindingDB data...")
        
        # Load targets first
        target_records = [
            (
                t['target_id'],
                t.get('target_name'),
                t.get('target_type'),
                t.get('gene_symbol'),
                t.get('uniprot_id'),
                None
            )
            for t in targets
        ]
        
        if target_records:
            with self.conn.cursor() as cur:
                execute_batch(cur, """
                    INSERT INTO targets (
                        target_id, target_name, target_type, gene_symbol,
                        uniprot_id, pathway_info
                    )
                    VALUES (%s, %s, %s, %s, %s, %s)
                    ON CONFLICT (target_id) DO UPDATE SET
                        target_name = COALESCE(EXCLUDED.target_name, targets.target_name),
                        target_type = COALESCE(EXCLUDED.target_type, targets.target_type),
                        gene_symbol = COALESCE(EXCLUDED.gene_symbol, targets.gene_symbol)
                """, target_records, page_size=batch_size)
            self.conn.commit()
        
        # Load affinities (only for drugs with DrugBank IDs)
        affinity_records = [
            (
                b['drugbank_id'],
                b['target_id'],
                b['binding_affinity_value'],
                b['binding_affinity_unit'],
                b['binding_affinity_type'],
                None,  # interaction_type
                'BindingDB'
            )
            for b in bindings
            if b.get('drugbank_id')
        ]
        
        if affinity_records:
            with self.conn.cursor() as cur:
                execute_batch(cur, """
                    INSERT INTO drug_targets (
                        drug_id, target_id, binding_affinity_value,
                        binding_affinity_unit, binding_affinity_type,
                        interaction_type, source
                    )
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                    ON CONFLICT (drug_id, target_id, binding_affinity_type, source) DO NOTHING
                """, affinity_records, page_size=batch_size)
            self.conn.commit()
        
        print(f"✓ Loaded {len(affinity_records)} BindingDB affinities for {len(target_records)} targets")
    
    def load_active_probabilities(self, probabilities: List[Dict], batch_size: int = 1000):
        """
        Load active probability predictions.
        
        Args:
            probabilities: List of active probability dictionaries
            batch_size: Batch size for insertion
        """
        print(f"Loading {len(probabilities)} active probability predictions...")
        
        probability_records = [
            (
                p['target_id'],
                p.get('chembl_id'),
                p.get('gene_names'),
                p.get('activity'),
                p['active_probability'],
                p['non_active_probability']
            )
            for p in probabilities
        ]
        
        with self.conn.cursor() as cur:
            execute_batch(cur, """
                INSERT INTO active_probabilities (
                    target_id, chembl_id, gene_names, activity,
                    active_probability, non_active_probability
                )
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (target_id, chembl_id) DO UPDATE SET
                    gene_names = EXCLUDED.gene_names,
                    activity = EXCLUDED.activity,
                    active_probability = EXCLUDED.active_probability,
                    non_active_probability = EXCLUDED.non_active_probability
            """, probability_records, page_size=batch_size)
        
        self.conn.commit()
        print(f"✓ Loaded {len(probability_records)} active probabilities")
    
    def load_onsides_drug_side_effects(self, drug_side_effects: List[Dict], 
                                        batch_size: int = 1000):
        """
        Load OnSIDES drug-side effect associations.
        
        OnSIDES uses drug names (from RxNorm) rather than PubChem CIDs,
        so we match by drug name to find corresponding DrugBank IDs.
        
        Args:
            drug_side_effects: List of drug-SE associations from OnSIDES parser
            batch_size: Batch size for insertion
        """
        print(f"Loading {len(drug_side_effects)} OnSIDES drug-side effect associations...")
        
        # Build drug name to DrugBank ID mapping from existing drugs
        with self.conn.cursor() as cur:
            cur.execute("SELECT drug_id, LOWER(drug_name) FROM drugs")
            drugname_to_id = {row[1]: row[0] for row in cur.fetchall()}
            
            # Also get side_effect_id mappings
            cur.execute("SELECT side_effect_id, side_effect_name, meddra_id FROM side_effects")
            rows = cur.fetchall()
            se_name_to_id = {row[1]: row[0] for row in rows}
            se_meddra_to_id = {row[2]: row[0] for row in rows if row[2]}
        
        print(f"  Found {len(drugname_to_id):,} drugs and {len(se_name_to_id):,} side effects in database")
        
        dse_records = []
        skipped_drug = 0
        skipped_se = 0
        matched_drugs = set()
        
        for dse in tqdm(drug_side_effects, desc="Mapping OnSIDES associations"):
            # Match drug by name (case-insensitive)
            drug_name = dse.get('drug_name', '').lower()
            drug_id = drugname_to_id.get(drug_name)
            
            if not drug_id:
                skipped_drug += 1
                continue
            
            matched_drugs.add(drug_id)
            
            # Match side effect by MedDRA ID first, then by name
            se_id = se_meddra_to_id.get(dse.get('meddra_id'))
            if not se_id:
                se_id = se_name_to_id.get(dse.get('side_effect_name'))
            
            if not se_id:
                skipped_se += 1
                continue
            
            dse_records.append((
                drug_id,
                se_id,
                None,  # frequency (OnSIDES doesn't provide this)
                'OnSIDES'
            ))
        
        print(f"  Matched {len(matched_drugs):,} unique drugs")
        if skipped_drug > 0:
            print(f"  Skipped {skipped_drug:,} associations (drug not in database)")
        if skipped_se > 0:
            print(f"  Skipped {skipped_se:,} associations (side effect not in database)")
        
        if dse_records:
            with self.conn.cursor() as cur:
                execute_batch(cur, """
                    INSERT INTO drug_side_effects (
                        drug_id, side_effect_id, frequency, source
                    )
                    VALUES (%s, %s, %s, %s)
                    ON CONFLICT (drug_id, side_effect_id, source) DO NOTHING
                """, dse_records, page_size=batch_size)
            
            self.conn.commit()
        
        print(f"✓ Loaded {len(dse_records):,} OnSIDES drug-side effect associations")
    
    def get_statistics(self) -> Dict[str, int]:

        """Get database statistics."""
        stats = {}
        
        with self.conn.cursor() as cur:
            tables = ['drugs', 'targets', 'side_effects', 'drug_targets', 
                     'drug_side_effects', 'drug_dosages', 'target_side_effects',
                     'active_probabilities']
            
            for table in tables:
                cur.execute(f"SELECT COUNT(*) FROM {table}")
                stats[table] = cur.fetchone()[0]
        
        return stats
