import json
import os
import sys
from datetime import datetime

# Add the directory to the path so we can import the scoring module
sys.path.insert(0, '/home/michael/FDA Approval')
from bayesian_scoring import compute_bayesian_scores
from generate_html_reports import load_assets, load_target_map, load_molecule_target_activity, load_molecule_toxicology, load_clinical_data, find_by_inchi_prefix

def main():
    target_map = load_target_map()
    molecule_target_activity = load_molecule_target_activity(target_map)
    molecule_toxicology = load_molecule_toxicology()
    assets = load_assets()

    report_lines = []
    report_lines.append("# FDA Approval Drug Benchmarking Scores")
    report_lines.append(f"**Generated on:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} PST")
    report_lines.append("")
    report_lines.append("The following table summarizes the final Bayesian probability and grade for each of the 23 benchmarked assets, calculated using the updated 5-domain methodology.")
    report_lines.append("")
    report_lines.append("| Drug Name (Company) | Target/Indication Base Rate | Prior | Final Probability | Multiplier | Grade |")
    report_lines.append("| :--- | :---: | :---: | :---: | :---: | :---: |")

    # Keep track of biologics to add them at the bottom
    biologics = []

    for asset in assets:
        smi = asset['smiles']
        
        # Match data
        molecule_toxicology_key = find_by_inchi_prefix(molecule_toxicology, asset['inchi']) if not molecule_toxicology.get(smi) else smi
        asset_molecule_toxicology = molecule_toxicology.get(smi) or (molecule_toxicology.get(molecule_toxicology_key, {}) if molecule_toxicology_key else {})
        molecule_target_activity_key = find_by_inchi_prefix(molecule_target_activity, asset['inchi']) if not molecule_target_activity.get(smi) else smi
        asset_molecule_target_activity = molecule_target_activity.get(smi) or (molecule_target_activity.get(molecule_target_activity_key, []) if molecule_target_activity_key else [])

        # Clinical Data and Side effects
        clinical_data = load_clinical_data(asset['name'])
        side_effects_data = None
        # (This is just a mock grab for the test script since actual HTML gen handles running SIDE_EFFECTS)

        # Compute Bayesian scores
        bayesian_scores = compute_bayesian_scores(asset, asset_molecule_toxicology, asset_molecule_target_activity, clinical_data, side_effects_data)

        name = asset['name']
        company = asset['company']

        if bayesian_scores:
            base_rate = bayesian_scores['base_rate']
            prior = bayesian_scores['prior']
            prob = bayesian_scores['probability_pct']
            mult = bayesian_scores['multiplier']
            grade = bayesian_scores['grade']
            
            row = f"| **{name}** ({company}) | {base_rate:.0%} | {prior:.2f} | **{prob}** | {mult}x | **{grade}** |"
            report_lines.append(row)
        else:
            biologics.append(f"| **{name}** ({company}) | N/A | N/A | N/A | N/A | **N/A (Biologic)** |")

    # Add biologics at the end
    for b in biologics:
        report_lines.append(b)

    report_lines.append("")
    report_lines.append("---")
    report_lines.append("*Note: Biologics, antibodies, and gene therapies do not receive Bayesian scores in this model as they are incompatible with the SMILES-based Molecule Target Activity and Molecule Toxicology prediction engines. They are evaluated separately via Pathway Analysis.*")

    with open('/home/michael/FDA Approval/FDA Approval_Drug_Scores.md', 'w') as f:
        f.write("\n".join(report_lines))
        
    print("Saved to FDA Approval_Drug_Scores.md")

if __name__ == '__main__':
    main()
