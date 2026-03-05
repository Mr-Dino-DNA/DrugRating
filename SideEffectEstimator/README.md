# Side Effect Estimator

A knowledge base and prediction system for drug side effects based on target binding profiles.

## Overview

This system builds a comprehensive knowledge base from DrugBank and SIDER databases, linking drugs to their molecular targets and known side effects. It enables prediction of potential side effects for new drug candidates based on their target binding profiles.

## Prerequisites

- **PostgreSQL 12+** (database)
- **Python 3.8+**
- **RDKit** (for chemical structure processing)

> [!IMPORTANT]
> PostgreSQL must be installed and running before proceeding with the setup.

## Installation

### 1. Install PostgreSQL

```bash
# Ubuntu/Debian
sudo apt-get install postgresql postgresql-contrib

# macOS
brew install postgresql
```

### 2. Create Database

```bash
# Start PostgreSQL service
sudo service postgresql start  # Linux
brew services start postgresql  # macOS

# Create database
sudo -u postgres createdb side_effect_estimator

# Create user (optional)
sudo -u postgres createuser -P your_username
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE side_effect_estimator TO your_username;"
```

### 3. Install Python Dependencies

```bash
# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # Linux/macOS
# or: venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt
```

**Note:** RDKit installation may require conda:
```bash
conda install -c conda-forge rdkit
```

### 4. Configure Environment

```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your settings
nano .env
```

Update the following in `.env`:
- `DB_PASSWORD`: Your PostgreSQL password
- `DRUGBANK_XML_PATH`: Path to your DrugBank XML file
- `SIDER_MEDDRA_ALL_SE_PATH`: Path to SIDER meddra_all_se.tsv
- `SIDER_MEDDRA_FREQ_PATH`: Path to SIDER meddra_freq.tsv (optional)

## Data Acquisition

### DrugBank
1. Register at https://go.drugbank.com/releases/latest
2. Download the "Open Data" XML file (free)
3. Extract and note the path

### SIDER
1. Visit http://sideeffects.embl.de/download/
2. Download:
   - `meddra_all_se.tsv.gz`
   - `meddra_freq.tsv.gz` (optional, for frequency data)
3. Extract the files

## Usage

### 1. Initialize Database Schema

```bash
python database/init_db.py
```

This creates all necessary tables and indexes.

### 2. Run ETL Pipeline

```bash
python etl/run_etl.py
```

This will:
1. Parse DrugBank XML (~10-30 minutes depending on file size)
2. Parse SIDER data (~5 minutes)
3. Load data into PostgreSQL
4. Compute molecular fingerprints
5. Aggregate target-side effect relationships

### 3. Verify Data

```bash
# Connect to database
psql -d side_effect_estimator

# Check statistics
SELECT 
    (SELECT COUNT(*) FROM drugs) as drugs,
    (SELECT COUNT(*) FROM targets) as targets,
    (SELECT COUNT(*) FROM side_effects) as side_effects,
    (SELECT COUNT(*) FROM drug_targets) as drug_target_interactions,
    (SELECT COUNT(*) FROM target_side_effects) as target_se_links;
```

## Database Schema

### Core Tables

- **drugs**: Drug information, structures (SMILES, InChI), molecular fingerprints
- **targets**: Biological targets (proteins, receptors, enzymes)
- **side_effects**: Known side effects with medical terminology (MedDRA, UMLS)
- **drug_targets**: Drug-target interactions with binding affinities
- **drug_side_effects**: Known side effects for each drug
- **drug_dosages**: Dosage information
- **target_side_effects**: Aggregated evidence linking targets to side effects

## Example Queries

### Find drugs targeting a specific protein

```sql
SELECT d.drug_name, dt.interaction_type
FROM drugs d
JOIN drug_targets dt ON d.drug_id = dt.drug_id
JOIN targets t ON dt.target_id = t.target_id
WHERE t.gene_symbol = 'DRD2';
```

### Find common side effects for a target

```sql
SELECT se.side_effect_name, tse.evidence_count, tse.confidence_score
FROM target_side_effects tse
JOIN side_effects se ON tse.side_effect_id = se.side_effect_id
JOIN targets t ON tse.target_id = t.target_id
WHERE t.gene_symbol = 'HTR2A'
ORDER BY tse.confidence_score DESC;
```

### Find similar drugs by structure

```sql
-- Find drugs with similar fingerprints (requires custom similarity function)
SELECT drug_name, smiles
FROM drugs
WHERE drug_id != 'DB00502'
ORDER BY fingerprint_morgan2048 <-> (
    SELECT fingerprint_morgan2048 FROM drugs WHERE drug_id = 'DB00502'
)
LIMIT 10;
```

## Project Structure

```
SideEffectEstimator/
├── database/
│   ├── schema.sql           # PostgreSQL schema
│   └── init_db.py          # Database initialization script
├── etl/
│   ├── parsers/
│   │   ├── drugbank_parser.py
│   │   └── sider_parser.py
│   ├── loaders/
│   │   └── database_loader.py
│   └── run_etl.py          # Main ETL orchestration
├── requirements.txt
├── .env.example
└── README.md
```

## Troubleshooting

### RDKit Installation Issues
If pip installation fails, use conda:
```bash
conda create -n side_effect_estimator python=3.9
conda activate side_effect_estimator
conda install -c conda-forge rdkit
pip install psycopg2-binary pandas python-dotenv tqdm lxml
```

### PostgreSQL Connection Errors
- Ensure PostgreSQL is running: `sudo service postgresql status`
- Check credentials in `.env`
- Verify database exists: `psql -l`

### Memory Issues During ETL
- Reduce `BATCH_SIZE` in `.env` (default: 1000)
- Process in chunks if needed

## Next Steps

After populating the database, you can:
1. Build a prediction API to estimate side effects for new compounds
2. Add ChEMBL data for better binding affinity information
3. Implement similarity search for drug repurposing
4. Create visualization tools for target-side effect networks

## License

This project uses data from:
- DrugBank (https://go.drugbank.com/) - Check their license terms
- SIDER (http://sideeffects.embl.de/) - CC BY-NC-SA 4.0

## Support

For issues or questions, please check:
1. Database connection settings in `.env`
2. File paths are correct and files exist
3. PostgreSQL service is running
4. All dependencies are installed
