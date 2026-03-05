-- Side Effect Estimator Knowledge Base Schema
-- PostgreSQL Database Schema

-- Drop existing tables if they exist (for clean reinstall)
DROP TABLE IF EXISTS active_probabilities CASCADE;
DROP TABLE IF EXISTS target_side_effects CASCADE;
DROP TABLE IF EXISTS drug_dosages CASCADE;
DROP TABLE IF EXISTS drug_side_effects CASCADE;
DROP TABLE IF EXISTS drug_targets CASCADE;
DROP TABLE IF EXISTS side_effects CASCADE;
DROP TABLE IF EXISTS drugs CASCADE;
DROP TABLE IF EXISTS targets CASCADE;

-- Core tables
CREATE TABLE targets (
    target_id VARCHAR(50) PRIMARY KEY,  -- e.g., 'P14416' (UniProt ID)
    target_name VARCHAR(255),
    target_type VARCHAR(50),  -- 'protein', 'receptor', 'enzyme', etc.
    gene_symbol VARCHAR(50),
    uniprot_id VARCHAR(50),
    pathway_info JSONB,  -- store pathway associations
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
    pubchem_cid INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE side_effects (
    side_effect_id SERIAL PRIMARY KEY,
    side_effect_name VARCHAR(255) UNIQUE NOT NULL,
    meddra_id VARCHAR(20),  -- Medical Dictionary for Regulatory Activities
    umls_id VARCHAR(20),  -- Unified Medical Language System
    severity VARCHAR(50),  -- 'mild', 'moderate', 'severe'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE drug_targets (
    id SERIAL PRIMARY KEY,
    drug_id VARCHAR(50) REFERENCES drugs(drug_id) ON DELETE CASCADE,
    target_id VARCHAR(50) REFERENCES targets(target_id) ON DELETE CASCADE,
    binding_affinity_value FLOAT,  -- Ki, Kd, IC50, etc.
    binding_affinity_unit VARCHAR(10),  -- 'nM', 'uM', etc.
    binding_affinity_type VARCHAR(10),  -- 'Ki', 'Kd', 'IC50'
    interaction_type VARCHAR(50),  -- 'agonist', 'antagonist', 'inhibitor'
    source VARCHAR(100),  -- 'DrugBank', 'ChEMBL', 'BindingDB'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(drug_id, target_id, binding_affinity_type, source)
);

CREATE TABLE drug_side_effects (
    id SERIAL PRIMARY KEY,
    drug_id VARCHAR(50) REFERENCES drugs(drug_id) ON DELETE CASCADE,
    side_effect_id INTEGER REFERENCES side_effects(side_effect_id) ON DELETE CASCADE,
    frequency VARCHAR(50),  -- 'common', 'uncommon', 'rare', or percentages
    source VARCHAR(100),  -- 'SIDER', 'FDA', 'DrugBank'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(drug_id, side_effect_id, source)
);

CREATE TABLE drug_dosages (
    id SERIAL PRIMARY KEY,
    drug_id VARCHAR(50) REFERENCES drugs(drug_id) ON DELETE CASCADE,
    indication VARCHAR(255),  -- what condition this dosage is for
    route VARCHAR(200),  -- 'oral', 'IV', 'topical', etc (increased for long values)
    min_dose_mg FLOAT,
    max_dose_mg FLOAT,
    typical_dose_mg FLOAT,
    frequency VARCHAR(100),  -- 'once daily', 'twice daily', etc.
    source VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Junction table for target → side effect connections
CREATE TABLE target_side_effects (
    id SERIAL PRIMARY KEY,
    target_id VARCHAR(50) REFERENCES targets(target_id) ON DELETE CASCADE,
    side_effect_id INTEGER REFERENCES side_effects(side_effect_id) ON DELETE CASCADE,
    evidence_count INTEGER DEFAULT 1,  -- how many drugs support this link
    confidence_score FLOAT,  -- computed based on evidence strength
    mechanism TEXT,  -- brief mechanistic explanation
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(target_id, side_effect_id)
);

-- Active probability predictions for drug-target binding
CREATE TABLE active_probabilities (
    id SERIAL PRIMARY KEY,
    target_id VARCHAR(50),  -- ChEMBL ID or UniProt ID (no FK constraint - may not exist in targets yet)
    chembl_id VARCHAR(20),  -- ChEMBL molecule ID if available
    gene_names TEXT,  -- Associated gene names
    activity BOOLEAN,  -- Binary activity prediction
    active_probability FLOAT CHECK (active_probability BETWEEN 0 AND 1),
    non_active_probability FLOAT CHECK (non_active_probability BETWEEN 0 AND 1),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(target_id, chembl_id)
);

-- Indexes for performance
CREATE INDEX idx_drug_targets_drug ON drug_targets(drug_id);
CREATE INDEX idx_drug_targets_target ON drug_targets(target_id);
CREATE INDEX idx_drug_targets_source ON drug_targets(source);

CREATE INDEX idx_drug_side_effects_drug ON drug_side_effects(drug_id);
CREATE INDEX idx_drug_side_effects_effect ON drug_side_effects(side_effect_id);
CREATE INDEX idx_drug_side_effects_source ON drug_side_effects(source);

CREATE INDEX idx_target_side_effects_target ON target_side_effects(target_id);
CREATE INDEX idx_target_side_effects_effect ON target_side_effects(side_effect_id);
CREATE INDEX idx_target_side_effects_confidence ON target_side_effects(confidence_score DESC);

CREATE INDEX idx_drugs_name ON drugs(drug_name);
CREATE INDEX idx_drugs_drugbank_id ON drugs(drugbank_id);
-- Note: Fingerprint similarity searches done in application code

CREATE INDEX idx_targets_uniprot ON targets(uniprot_id);
CREATE INDEX idx_targets_gene_symbol ON targets(gene_symbol);

CREATE INDEX idx_side_effects_name ON side_effects(side_effect_name);
CREATE INDEX idx_side_effects_meddra ON side_effects(meddra_id);
CREATE INDEX idx_side_effects_umls ON side_effects(umls_id);

CREATE INDEX idx_active_prob_target ON active_probabilities(target_id);
CREATE INDEX idx_active_prob_chembl ON active_probabilities(chembl_id);
CREATE INDEX idx_active_prob_probability ON active_probabilities(active_probability DESC);
CREATE INDEX idx_active_prob_activity ON active_probabilities(activity);

-- Comments for documentation
COMMENT ON TABLE drugs IS 'Core drug information including chemical structures and identifiers';
COMMENT ON TABLE targets IS 'Biological targets (proteins, receptors, enzymes) that drugs interact with';
COMMENT ON TABLE side_effects IS 'Known side effects with standardized medical terminology';
COMMENT ON TABLE drug_targets IS 'Drug-target interactions with binding affinity data';
COMMENT ON TABLE drug_side_effects IS 'Known side effects for each drug';
COMMENT ON TABLE drug_dosages IS 'Dosage information for different indications and routes';
COMMENT ON TABLE target_side_effects IS 'Aggregated evidence linking targets to side effects';
COMMENT ON TABLE active_probabilities IS 'ML-predicted probabilities for drug-target binding activity';
