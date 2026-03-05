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

    for asset in assets:
        smi = asset['smiles']
        molecule_toxicology_key = find_by_inchi_prefix(molecule_toxicology, asset['inchi']) if not molecule_toxicology.get(smi) else smi
        asset_molecule_toxicology = molecule_toxicology.get(smi) or (molecule_toxicology.get(molecule_toxicology_key, {}) if molecule_toxicology_key else {})
        molecule_target_activity_key = find_by_inchi_prefix(molecule_target_activity, asset['inchi']) if not molecule_target_activity.get(smi) else smi
        asset_molecule_target_activity = molecule_target_activity.get(smi) or (molecule_target_activity.get(molecule_target_activity_key, []) if molecule_target_activity_key else [])
        clinical_data = load_clinical_data(asset['name'])

        scores = compute_bayesian_scores(asset, asset_molecule_toxicology, asset_molecule_target_activity, clinical_data)

        if scores:
            d = {dom['key']: dom['contribution'] for dom in scores['domains']}
            print(f"{asset['name']:<15} | {scores['multiplier']:<6.2f} | {d.get('pk',0):>6.3f} | {d.get('tox',0):>7.3f} | {d.get('adme',0):>9.3f} | {d.get('tol',0):>7.3f} | {d.get('eff',0):>6.3f} | {scores['total_adjustment']:>6.3f}")

if __name__ == '__main__':
    main()
