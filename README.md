# Drug Benchmarking Pipeline
This repository contains the end-to-end tools to extract drug assets, query properties, run computational evaluations, and generate elegant Bayesian Score reports.

## Getting Started

### Prerequisites
Make sure dependencies are installed:
```bash
pip install -r requirements.txt
```

Note: This repository contains git submodules and large files for the Side Effect Estimator. 

### Running the Pipeline
You can trigger the entire sequence from extraction to PDF generation simply by executing:

```bash
python3 run_pipeline.py
```

### Understanding the Architecture
`run_pipeline.py` executes the following sequence:
1. `extract_assets.py` - Parses PDFs for named assets.
2. `convert_smiles.py` - standardizes structures.
3. `extract_properties.py` - gathers molecular properties.
4. `map_FDA_approval_results.py` - associates SMILES with prediction JSON files.
5. `fetch_antibody_pathways.py` - Fetches mechanistic pathways for biologics (Biologics are skipped in regular scoring).
6. `export_scores.py` - Loads `bayesian_scoring.py` and calculates the 5-domain scores.
7. `generate_score_report.py` - Creates a population-level score overview.
8. `generate_reports.py` - Markdown generation for each drug.
9. `generate_html_reports.py` - HTML visually-appealing generation.
10. `export_pdfs.py` - Converts the Markdowns to final deliverables.

