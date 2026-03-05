import json
import sys

sys.path.insert(0, '/home/michael/FDA Approval')
from generate_html_reports import load_assets, load_target_map, load_molecule_target_activity, find_by_inchi_prefix

def main():
    target_map = load_target_map()
    molecule_target_activity = load_molecule_target_activity(target_map)
    assets = load_assets()

    print(f"{'Drug':<15} | {'Avg Top 5 P(Active)':<20} | Top 5 individual probs")
    print("-" * 75)

    for asset in assets:
        smi = asset['smiles']
        molecule_target_activity_key = find_by_inchi_prefix(molecule_target_activity, asset['inchi']) if not molecule_target_activity.get(smi) else smi
        asset_molecule_target_activity = molecule_target_activity.get(smi) or (molecule_target_activity.get(molecule_target_activity_key, []) if molecule_target_activity_key else [])
        
        all_hits = asset_molecule_target_activity if asset_molecule_target_activity else []
        unique = list({h['target_id']: h for h in all_hits}.values())
        active = [h for h in unique if h['activity'] == 1]
        
        top_probs = sorted([h['active_prob'] for h in active], reverse=True)[:5]
        avg_top_activity = sum(top_probs) / len(top_probs) if top_probs else 0
        
        if avg_top_activity > 0:
            probs_str = ", ".join([f"{p:.3f}" for p in top_probs])
            print(f"{asset['name']:<15} | {avg_top_activity:<20.3f} | {probs_str}")

if __name__ == '__main__':
    main()
