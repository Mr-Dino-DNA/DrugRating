import json
import sys

# Add the directory to the path so we can import the scoring module
sys.path.insert(0, '/home/michael/FDA Approval')
from bayesian_scoring import compute_bayesian_scores
from generate_html_reports import load_assets, load_target_map, load_molecule_target_activity, load_molecule_toxicology, load_clinical_data, find_by_inchi_prefix

def main():
    target_map = load_target_map()
    molecule_target_activity = load_molecule_target_activity(target_map)
    molecule_toxicology = load_molecule_toxicology()
    assets = load_assets()

    print(f"{'Drug':<15} | {'Mult':<6} | {'PK(I)':<6} | {'Tox(II)':<7} | {'ADME(III)':<9} | {'Tol(IV)':<7} | {'Eff(V)':<6} | {'Total':<6}")
    print("-" * 75)

    
    # Get max/min values to see spread
    max_pk, min_pk = 0, 1
    max_tox, min_tox = 0, 1
    
    for asset in assets:
        smi = asset['smiles']
        molecule_toxicology_key = find_by_inchi_prefix(molecule_toxicology, asset['inchi']) if not molecule_toxicology.get(smi) else smi
        asset_molecule_toxicology = molecule_toxicology.get(smi) or (molecule_toxicology.get(molecule_toxicology_key, {}) if molecule_toxicology_key else {})
        molecule_target_activity_key = find_by_inchi_prefix(molecule_target_activity, asset['inchi']) if not molecule_target_activity.get(smi) else smi
        asset_molecule_target_activity = molecule_target_activity.get(smi) or (molecule_target_activity.get(molecule_target_activity_key, []) if molecule_target_activity_key else [])
        clinical_data = load_clinical_data(asset['name'])

        if not asset_molecule_toxicology or not asset_molecule_target_activity: continue

        sl_prob = float(asset.get('FDA_approval_prob', 0.5))
        max_pk = max(max_pk, sl_prob)
        min_pk = min(min_pk, sl_prob)
        
        molecule_toxicology_organs = []
        for organ in ['renal', 'cardio', 'hepa', 'gen']:
            if organ in asset_molecule_toxicology:
                molecule_toxicology_organs.append(asset_molecule_toxicology[organ])
        
        avg_tox_prob = sum(v['probability'] for v in molecule_toxicology_organs) / len(molecule_toxicology_organs) if molecule_toxicology_organs else 0.5
        max_tox = max(max_tox, avg_tox_prob)
        min_tox = min(min_tox, avg_tox_prob)
        
    print(f"FDA Approval Prob Spread: {min_pk:.3f} to {max_pk:.3f}")
    print(f"Molecule Toxicology Tox Avg Spread: {min_tox:.3f} to {max_tox:.3f}")

if __name__ == '__main__':
    main()
