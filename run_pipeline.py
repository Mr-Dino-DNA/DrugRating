#!/usr/bin/env python3
"""
Drug Benchmarking Pipeline Runner
Executes the entire Drug Benchmarking sequence end-to-end.
"""

import os
import sys
import subprocess

def run_step(script_name, description):
    print(f"\n{'='*60}")
    print(f"🚀 STEP: {description}")
    print(f"{'='*60}")
    
    if not os.path.exists(script_name):
        print(f"❌ Error: Could not find {script_name}")
        sys.exit(1)
        
    try:
        # Run script and stream output
        result = subprocess.run([sys.executable, script_name], check=True)
    except subprocess.CalledProcessError as e:
        print(f"\n❌ Pipeline failed at {script_name}")
        sys.exit(e.returncode)

def main():
    print("Starting Drug Benchmarking Pipeline...")
    
    # Step 1: Extract assets from source docs (PDFs)
    run_step("extract_assets.py", "Extracting drug assets from PDFs")
    
    # Step 2: Convert names to SMILES and InChI
    run_step("convert_smiles.py", "Converting assets to SMILES and InChI")
    
    # Step 3: Fetch related properties
    run_step("extract_properties.py", "Fetching drug properties")
    
    # Step 4: Run Target Activity, Toxicology, Inhibitor, FDA Approval mapping
    run_step("map_FDA_approval_results.py", "Mapping computational results to assets")
    
    # Step 5: Gather Pathways for Biologics/Antibodies
    run_step("fetch_antibody_pathways.py", "Fetching pathways for biologics/antibodies")
    
    # Step 6: Generate Bayesian Scores
    run_step("export_scores.py", "Computing Bayesian Scores over Computational Data")
    
    # Step 7: Export Score Distribution Report
    run_step("generate_score_report.py", "Generating High-Level Score Distribution")
    
    # Step 8: Generate Markdown Reports
    run_step("generate_reports.py", "Generating individual Markdown reports")
    
    # Step 9: Generate neo-brutalist HTML Reports
    run_step("generate_html_reports.py", "Generating individual HTML reports")
    
    # Step 10: Convert Markdown to PDFs
    run_step("export_pdfs.py", "Converting Markdown reports to PDF")
    
    print("\n✅ Pipeline completed successfully.")

if __name__ == "__main__":
    main()
