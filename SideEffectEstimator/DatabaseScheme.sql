-- Core tables
CREATE TABLE targets (
    target_id VARCHAR(50) PRIMARY KEY,  -- e.g., 'P14416' (UniProt ID)
    target_name VARCHAR(255),
    target_type VARCHAR(50),  -- 'protein', 'receptor', 'enzyme', etc.
    gene_symbol VARCHAR(50),
    uniprot_id VARCHAR(50),
    pathway_info JSONB  -- store pathway associations
);

CREATE TABLE drugs (
    drug_id VARCHAR(50) PRIMARY KEY,  -- DrugBank ID, e.g., 'DB00502'
    drug_name VARCHAR(255),
    smiles TEXT,
    inchi TEXT,
    inchikey VARCHAR(27),
    molecular_formula VARCHAR(100),
    molecular_weight FLOAT,
    fingerprint_morgan2048 BIT(2048),  -- precomputed for fast similarity
    drugbank_id VARCHAR(20),
    pubchem_cid INTEGER
);

CREATE TABLE side_effects (
    side_effect_id SERIAL PRIMARY KEY,
    side_effect_name VARCHAR(255),
    meddra_id VARCHAR(20),  -- Medical Dictionary for Regulatory Activities
    umls_id VARCHAR(20),  -- Unified Medical Language System
    severity VARCHAR(50)  -- 'mild', 'moderate', 'severe'
);

CREATE TABLE drug_targets (
    id SERIAL PRIMARY KEY,
    drug_id VARCHAR(50) REFERENCES drugs(drug_id),
    target_id VARCHAR(50) REFERENCES targets(target_id),
    binding_affinity_value FLOAT,  -- Ki, Kd, IC50, etc.
    binding_affinity_unit VARCHAR(10),  -- 'nM', 'uM', etc.
    binding_affinity_type VARCHAR(10),  -- 'Ki', 'Kd', 'IC50'
    interaction_type VARCHAR(50),  -- 'agonist', 'antagonist', 'inhibitor'
    source VARCHAR(100),  -- 'DrugBank', 'ChEMBL', 'BindingDB'
    UNIQUE(drug_id, target_id, binding_affinity_type)
);

CREATE TABLE drug_side_effects (
    id SERIAL PRIMARY KEY,
    drug_id VARCHAR(50) REFERENCES drugs(drug_id),
    side_effect_id INTEGER REFERENCES side_effects(side_effect_id),
    frequency VARCHAR(50),  -- 'common', 'uncommon', 'rare', or percentages
    source VARCHAR(100),  -- 'SIDER', 'FDA', 'DrugBank'
    UNIQUE(drug_id, side_effect_id)
);

CREATE TABLE drug_dosages (
    id SERIAL PRIMARY KEY,
    drug_id VARCHAR(50) REFERENCES drugs(drug_id),
    indication VARCHAR(255),  -- what condition this dosage is for
    route VARCHAR(50),  -- 'oral', 'IV', 'topical'
    min_dose_mg FLOAT,
    max_dose_mg FLOAT,
    typical_dose_mg FLOAT,
    frequency VARCHAR(100),  -- 'once daily', 'twice daily', etc.
    source VARCHAR(100)
);

-- Junction table for target → side effect connections
CREATE TABLE target_side_effects (
    id SERIAL PRIMARY KEY,
    target_id VARCHAR(50) REFERENCES targets(target_id),
    side_effect_id INTEGER REFERENCES side_effects(side_effect_id),
    evidence_count INTEGER DEFAULT 1,  -- how many drugs support this link
    confidence_score FLOAT,  -- computed based on evidence strength
    mechanism TEXT  -- brief mechanistic explanation
);

-- Indexes for performance
CREATE INDEX idx_drug_targets_drug ON drug_targets(drug_id);
CREATE INDEX idx_drug_targets_target ON drug_targets(target_id);
CREATE INDEX idx_drug_side_effects_drug ON drug_side_effects(drug_id);
CREATE INDEX idx_drug_side_effects_effect ON drug_side_effects(side_effect_id);
CREATE INDEX idx_drugs_fingerprint ON drugs USING hash(fingerprint_morgan2048);