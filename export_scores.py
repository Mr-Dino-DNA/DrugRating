import os
import csv
from generate_html_reports import load_target_map, load_molecule_target_activity, load_molecule_toxicology, load_assets, load_clinical_data, find_by_inchi_prefix
from bayesian_scoring import compute_bayesian_scores, run_side_effect_prediction

def export_scores(output_filename="FDA Approval_Scores_Comparison.csv"):
    print("Loading data sources...")
    target_map = load_target_map()
    molecule_target_activity = load_molecule_target_activity(target_map)
    molecule_toxicology = load_molecule_toxicology()
    assets = load_assets()

    results = []

    for asset in assets:
        smi = asset.get('smiles', '')
        name = asset.get('name', 'Unknown')
        print(f"Processing {name}...")
        
        molecule_toxicology_key = find_by_inchi_prefix(molecule_toxicology, asset.get('inchi', '')) if not molecule_toxicology.get(smi) else smi
        asset_molecule_toxicology = molecule_toxicology.get(smi) or (molecule_toxicology.get(molecule_toxicology_key, {}) if molecule_toxicology_key else {})
        molecule_target_activity_key = find_by_inchi_prefix(molecule_target_activity, asset.get('inchi', '')) if not molecule_target_activity.get(smi) else smi
        asset_molecule_target_activity = molecule_target_activity.get(smi) or (molecule_target_activity.get(molecule_target_activity_key, []) if molecule_target_activity_key else [])

        side_effects = run_side_effect_prediction(smi)
        clinical_data = load_clinical_data(name)
        
        bayesian_scores = compute_bayesian_scores(asset, asset_molecule_toxicology, asset_molecule_target_activity, clinical_data, side_effects)
        
        initial_score = asset.get('FDA_approval_prob')
        if not initial_score:
            initial_score = "N/A"
            
        final_score = "N/A"
        grade = "N/A"
        rationale = "N/A"

        if bayesian_scores:
            final_score = bayesian_scores.get('probability_pct', 'N/A')
            grade = bayesian_scores.get('grade', 'N/A')
            
            rationales = []
            for d in bayesian_scores.get('domains', []):
                domain_name = d.get('name')
                domain_rationale = d.get('rationale')
                contrib = d.get('contribution', 0)
                if contrib != 0:
                    sign = "+" if contrib > 0 else "-"
                    rationales.append(f"{domain_name} ({sign}): {domain_rationale}")
            
            rationale = " | ".join(rationales)

        row = {
            "Drug": name,
            "Company": asset.get('company', 'Unknown'),
            "Initial FDA Approval Score": initial_score,
            "Final Bayesian Score": final_score,
            "Final Grade": grade,
            "Contributing Factors": rationale
        }
        results.append(row)

    mode = 'w'
    with open(output_filename, mode, newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=["Drug", "Company", "Initial FDA Approval Score", "Final Bayesian Score", "Final Grade", "Contributing Factors"])
        writer.writeheader()
        writer.writerows(results)

    print(f"\\nSuccessfully exported {len(results)} drugs to {output_filename}")

if __name__ == "__main__":
    export_scores()
