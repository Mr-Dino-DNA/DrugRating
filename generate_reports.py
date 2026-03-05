#!/usr/bin/env python3
"""
Generate Drug Benchmarking Reports from Structured Data
No API key required - uses Molecule Target Activity, Molecule Toxicology, and EMP-01 JSON data directly.
"""
import os
import csv
import json
from datetime import datetime

# ─── Configuration ───────────────────────────────────────────────────────────
BASE_DIR = "/home/michael/FDA Approval/Drug_Benchmarking"
ASSETS_FILE = "/home/michael/FDA Approval/mapped_FDA_approval_assets.csv"
MOLECULE_TARGET_ACTIVITY_FILE = "/home/michael/FDA Approval/Source_Docs/FDA Approval_Project_Molecule Target Activity.json"
MOLECULE_TOXICOLOGY_FILE = "/home/michael/FDA Approval/Source_Docs/FDA Approval_Project_Molecule Toxicology.json"
EMP01_FILE = "/home/michael/FDA Approval/Source_Docs/EMP-01_Investigator_Brochure.json"
TARGET_MAP_FILE = "/home/michael/SciTech/molecule_target_activity_target_indications_mapping.csv"


def load_target_map():
    """Load ChEMBL ID → human-readable target name mapping."""
    tmap = {}
    if os.path.exists(TARGET_MAP_FILE):
        with open(TARGET_MAP_FILE, 'r') as f:
            reader = csv.DictReader(f)
            for row in reader:
                tid = row.get('target_id', '').strip()
                tname = row.get('target_name', '').strip()
                indications = row.get('indications', '').strip()
                if tid:
                    tmap[tid] = {'name': tname if tname else tid, 'indications': indications}
    return tmap


def load_molecule_target_activity(target_map):
    """Load Molecule Target Activity target activity predictions, keyed by SMILES AND standard_inchi."""
    molecule_target_activity = {}  # keyed by both SMILES and InChI
    if not os.path.exists(MOLECULE_TARGET_ACTIVITY_FILE):
        return molecule_target_activity
    with open(MOLECULE_TARGET_ACTIVITY_FILE, 'r') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            rec = json.loads(line)
            smi = rec.get('smi_code', '')
            inchi = rec.get('standard_inchi', '')
            tid = rec.get('target_id', '')
            info = target_map.get(tid, {'name': tid, 'indications': ''})
            entry = {
                'target_id': tid,
                'target_name': info['name'],
                'indications': info['indications'],
                'activity': rec.get('activity', 0),
                'active_prob': float(rec.get('active_probability', 0)),
                'inactive_prob': float(rec.get('not_active_probability', 1)),
            }
            molecule_target_activity.setdefault(smi, []).append(entry)
            if inchi:
                molecule_target_activity.setdefault(inchi, []).append(entry)
    return molecule_target_activity


def load_molecule_toxicology():
    """Load Molecule Toxicology safety/toxicity predictions, keyed by SMILES AND InChI."""
    molecule_toxicology = {}
    if not os.path.exists(MOLECULE_TOXICOLOGY_FILE):
        return molecule_toxicology
    with open(MOLECULE_TOXICOLOGY_FILE, 'r') as f:
        data = json.load(f)
        for rec in data.get('results', {}).get('results', []):
            smi = rec.get('smiles', '')
            inchi = rec.get('InChi', '')
            preds = rec.get('predictions', {})
            molecule_toxicology[smi] = preds
            if inchi:
                molecule_toxicology[inchi] = preds
    return molecule_toxicology


def load_emp01():
    """Load the EMP-01 clinical trial brochure."""
    if not os.path.exists(EMP01_FILE):
        return None
    with open(EMP01_FILE, 'r') as f:
        line = f.readline()
        if line.strip():
            return json.loads(line)
    return None


def load_assets():
    """Load the mapped asset list."""
    assets = []
    with open(ASSETS_FILE, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            name = row.get('Asset', '').strip()
            if name and name != 'Unknown':
                assets.append({
                    'name': name,
                    'company': row.get('Company', '').strip(),
                    'smiles': row.get('SMILES', '').strip(),
                    'inchi': row.get('InChI', '').strip(),
                    'FDA_approval_prob': row.get('FDA Approval_Probability', ''),
                    'FDA_approval_pred': row.get('FDA Approval_Prediction', ''),
                })
    return assets


# ─── Helper functions ────────────────────────────────────────────────────────

def decision_label(d):
    labels = {'flag': '🔴 Flag', 'abstain': '🟡 Abstain', 'clear': '🟢 Clear'}
    return labels.get(d, d)


def prob_bar(p, width=20):
    filled = int(p * width)
    return '█' * filled + '░' * (width - filled)


def get_top_targets(molecule_target_activity_hits, n=10, active_only=True):
    """Return top-n targets sorted by active probability."""
    hits = molecule_target_activity_hits if molecule_target_activity_hits else []
    if active_only:
        hits = [h for h in hits if h['activity'] == 1]
    hits.sort(key=lambda x: x['active_prob'], reverse=True)
    return hits[:n]


def get_offtargets(molecule_target_activity_hits, n=10):
    """Return targets predicted inactive but with moderate probability."""
    hits = molecule_target_activity_hits if molecule_target_activity_hits else []
    inactive = [h for h in hits if h['activity'] == 0 and h['active_prob'] > 0.05]
    inactive.sort(key=lambda x: x['active_prob'], reverse=True)
    return inactive[:n]


# ─── Report generators ───────────────────────────────────────────────────────

def gen_05_therapeutic_dose(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Therapeutic Dose Profile: {asset['name']}\n"]
    lines.append(f"**Company:** {asset['company']}  ")
    lines.append(f"**SMILES:** `{asset['smiles']}`  ")
    lines.append(f"**FDA Approval Approval Probability:** {asset['FDA_approval_prob']}  ")
    lines.append(f"**FDA Approval Prediction:** {'Approved' if asset['FDA_approval_pred'] == '1' else 'Not Approved'}\n")

    if asset['name'].upper() == 'EMP-01' and emp01:
        ps = emp01.get('protocolSection', {})
        desc = ps.get('descriptionModule', {})
        design = ps.get('designModule', {})
        lines.append("## Clinical Trial Context\n")
        lines.append(f"- **Trial:** {ps.get('identificationModule', {}).get('briefTitle', 'N/A')}")
        lines.append(f"- **Phase:** {', '.join(design.get('phases', []))}")
        lines.append(f"- **Enrollment:** {design.get('enrollmentInfo', {}).get('count', 'N/A')} participants")
        lines.append(f"- **Design:** {design.get('designInfo', {}).get('interventionModel', 'N/A')}")
        lines.append(f"- **Status:** {ps.get('statusModule', {}).get('overallStatus', 'N/A')}\n")
        lines.append("### Study Summary\n")
        lines.append(f"{desc.get('briefSummary', 'No summary available.')}\n")

    lines.append("## Dose Information\n")
    lines.append("> **Note:** No empirical dose-response data is available from computational sources for this asset. "
                 "Therapeutic dose ranges should be determined from clinical trial publications and regulatory filings.\n")

    if molecule_toxicology:
        lines.append("## Safety Considerations for Dose Selection\n")
        lines.append("The following computational toxicity flags from Molecule Toxicology may impact dose-limiting toxicity thresholds:\n")
        for organ, preds in molecule_toxicology.items():
            prob = preds.get('probability', 0)
            dec = preds.get('decision', 'N/A')
            lines.append(f"- **{organ.capitalize()} toxicity:** {prob:.2%} probability — {decision_label(dec)}")
        lines.append("")

    return "\n".join(lines)


def gen_06_herg_cardiac(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# hERG / Cardiac Safety Profile: {asset['name']}\n"]

    if molecule_toxicology and 'cardio' in molecule_toxicology:
        c = molecule_toxicology['cardio']
        lines.append("## Molecule Toxicology Cardiotoxicity Prediction\n")
        lines.append(f"| Metric | Value |")
        lines.append(f"|--------|-------|")
        lines.append(f"| Probability | **{c['probability']:.4f}** ({c['probability']:.2%}) |")
        lines.append(f"| Uncertainty | {c['uncertainty']:.4f} |")
        lines.append(f"| Decision | {decision_label(c['decision'])} |")
        lines.append(f"| Risk Bar | `{prob_bar(c['probability'])}` |\n")

        if c['probability'] > 0.7:
            lines.append("> [!CAUTION]\n> High cardiotoxicity probability detected. This compound may pose significant hERG inhibition or QT prolongation risk.\n")
        elif c['probability'] > 0.4:
            lines.append("> [!WARNING]\n> Moderate cardiotoxicity signal. Further electrophysiology studies recommended.\n")
        else:
            lines.append("> [!NOTE]\n> Low cardiotoxicity probability. Favorable cardiac safety profile predicted.\n")
    else:
        lines.append("*No Molecule Toxicology cardiotoxicity data available for this compound.*\n")

    return "\n".join(lines)


def gen_07_plasma_binding(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Plasma Protein Binding & Pharmacokinetics: {asset['name']}\n"]
    lines.append(f"**SMILES:** `{asset['smiles']}`\n")
    lines.append("## ADME Parameters\n")
    lines.append("> **Note:** Computational ADME predictions (PPB, Vd, t½) are not available from the current "
                 "Molecule Target Activity/Molecule Toxicology data sources. These parameters require separate ADME prediction platforms or experimental data.\n")

    if asset['name'].upper() == 'EMP-01' and emp01:
        lines.append("## Clinical Trial Reference\n")
        lines.append("PK parameters may be reported in the completed Phase 2a trial results for EMP-01 "
                     f"(NCT ID: {emp01.get('protocolSection', {}).get('identificationModule', {}).get('nctId', 'N/A')}).\n")

    return "\n".join(lines)


def gen_08_ld50_toxicity(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Acute Toxicity & LD50 Profile: {asset['name']}\n"]

    if molecule_toxicology:
        lines.append("## Molecule Toxicology Multi-Organ Toxicity Predictions\n")
        lines.append("| Organ System | Probability | Uncertainty | Decision |")
        lines.append("|-------------|-------------|-------------|----------|")
        for organ in ['renal', 'cardio', 'hepa', 'gen']:
            if organ in molecule_toxicology:
                p = molecule_toxicology[organ]
                lines.append(f"| {organ.capitalize()} | {p['probability']:.4f} | {p['uncertainty']:.4f} | {decision_label(p['decision'])} |")
        lines.append("")

        # Identify highest risk
        worst = max(molecule_toxicology.items(), key=lambda x: x[1].get('probability', 0))
        lines.append(f"### Primary Toxicity Concern\n")
        lines.append(f"The highest predicted toxicity risk is **{worst[0].capitalize()}** "
                     f"at **{worst[1]['probability']:.2%}** probability.\n")

        flagged = [k for k, v in molecule_toxicology.items() if v.get('decision') == 'flag']
        if flagged:
            lines.append(f"> [!CAUTION]\n> Flagged organs: **{', '.join(f.capitalize() for f in flagged)}**\n")
    else:
        lines.append("*No Molecule Toxicology toxicity predictions available for this compound.*\n")

    return "\n".join(lines)


def gen_09_systems_biology(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Systems Biology Impact: {asset['name']}\n"]
    top = get_top_targets(molecule_target_activity_hits, n=10)

    if top:
        lines.append("## Predicted Primary Target Engagement\n")
        lines.append("The following biological targets are predicted to be engaged by this compound, "
                     "with potential downstream systems-level effects:\n")

        for t in top:
            lines.append(f"### {t['target_name']} ({t['target_id']})\n")
            lines.append(f"- **Active Probability:** {t['active_prob']:.4f}")
            if t['indications']:
                ind_list = [i.strip() for i in t['indications'].split(';')[:5]]
                lines.append(f"- **Associated Indications:** {'; '.join(ind_list)}")
            lines.append("")
    else:
        lines.append("*No Molecule Target Activity target predictions available for systems-level analysis.*\n")

    if molecule_toxicology:
        lines.append("## Predicted Organ-System Impact (Molecule Toxicology)\n")
        for organ in ['renal', 'cardio', 'hepa', 'gen']:
            if organ in molecule_toxicology:
                p = molecule_toxicology[organ]
                system_map = {'renal': 'Renal/Urinary', 'cardio': 'Cardiovascular', 'hepa': 'Hepatic/GI', 'gen': 'Genotoxic/Reproductive'}
                lines.append(f"- **{system_map.get(organ, organ)}:** {p['probability']:.2%} risk — {decision_label(p['decision'])}")
        lines.append("")

    return "\n".join(lines)


def gen_10_downstream_effects(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Downstream Pathway Effects: {asset['name']}\n"]
    top = get_top_targets(molecule_target_activity_hits, n=5)

    if top:
        lines.append("## Primary Target → Pathway Mapping\n")
        lines.append("Based on Molecule Target Activity predictions, the following targets are most likely engaged, "
                     "with their associated downstream disease/pathway implications:\n")

        for t in top:
            lines.append(f"### {t['target_name']} (P(active) = {t['active_prob']:.4f})\n")
            if t['indications']:
                ind_list = [i.strip() for i in t['indications'].split(';')[:8]]
                lines.append(f"**Linked pathologies:** {'; '.join(ind_list)}\n")
            else:
                lines.append("*No indication data mapped for this target.*\n")
    else:
        lines.append("*No Molecule Target Activity target data available to infer downstream effects.*\n")

    return "\n".join(lines)


def gen_11_target_activity(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Target Activity Report: {asset['name']}\n"]
    top = get_top_targets(molecule_target_activity_hits, n=15)
    all_hits = molecule_target_activity_hits if molecule_target_activity_hits else []

    total_targets = len(set(h['target_id'] for h in all_hits))
    active_targets = len(set(h['target_id'] for h in all_hits if h['activity'] == 1))

    lines.append(f"## Summary\n")
    lines.append(f"- **Total targets screened:** {total_targets}")
    lines.append(f"- **Active targets (threshold > 0.3):** {active_targets}")
    if total_targets > 0:
        selectivity = active_targets / total_targets
        lines.append(f"- **Selectivity ratio (active/total):** {selectivity:.2%}\n")

    if top:
        lines.append("## Top Active Targets\n")
        lines.append("| Rank | Target | ChEMBL ID | Active Probability |")
        lines.append("|------|--------|-----------|-------------------|")
        for i, t in enumerate(top, 1):
            lines.append(f"| {i} | {t['target_name']} | {t['target_id']} | {t['active_prob']:.4f} |")
        lines.append("")
    else:
        lines.append("*No active targets predicted by Molecule Target Activity for this compound.*\n")

    return "\n".join(lines)


def gen_12_competitor_comparison(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Competitive Benchmarking: {asset['name']}\n"]
    lines.append(f"**Company:** {asset['company']}  ")
    lines.append(f"**FDA Approval Approval Probability:** {asset['FDA_approval_prob']}\n")

    lines.append("## FDA Approval Regulatory Assessment\n")
    if asset['FDA_approval_pred'] == '1':
        lines.append(f"> [!NOTE]\n> FDA Approval predicts this compound is **likely to receive regulatory approval** "
                     f"(probability: {asset['FDA_approval_prob']}).\n")
    elif asset['FDA_approval_pred'] == '0':
        lines.append(f"> [!WARNING]\n> FDA Approval predicts this compound is **unlikely to receive regulatory approval** "
                     f"(probability: {asset['FDA_approval_prob']}).\n")
    else:
        lines.append("*FDA Approval prediction not available (biologics/gene therapy).*\n")

    if molecule_toxicology:
        lines.append("## Safety Differentiation (Molecule Toxicology)\n")
        lines.append("| Safety Dimension | Probability | Decision |")
        lines.append("|-----------------|-------------|----------|")
        for organ in ['renal', 'cardio', 'hepa', 'gen']:
            if organ in molecule_toxicology:
                p = molecule_toxicology[organ]
                lines.append(f"| {organ.capitalize()} Toxicity | {p['probability']:.4f} | {decision_label(p['decision'])} |")
        lines.append("")

    top = get_top_targets(molecule_target_activity_hits, n=3)
    if top:
        lines.append("## Primary Target Positioning\n")
        for t in top:
            lines.append(f"- **{t['target_name']}** — Active probability: {t['active_prob']:.4f}")
        lines.append("")

    return "\n".join(lines)


def gen_13_selectivity_ratio(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Selectivity Profile: {asset['name']}\n"]
    all_hits = molecule_target_activity_hits if molecule_target_activity_hits else []

    active = [h for h in all_hits if h['activity'] == 1]
    inactive = [h for h in all_hits if h['activity'] == 0]

    lines.append("## Selectivity Summary\n")
    lines.append(f"- **Total targets evaluated:** {len(all_hits)}")
    lines.append(f"- **Active (above threshold):** {len(active)}")
    lines.append(f"- **Inactive:** {len(inactive)}")
    if len(all_hits) > 0:
        sel = len(active) / len(all_hits)
        lines.append(f"- **Selectivity Index (S-score analog):** {sel:.4f}")
        if sel < 0.1:
            lines.append(f"- **Interpretation:** Highly selective (S < 0.1)")
        elif sel < 0.3:
            lines.append(f"- **Interpretation:** Moderately selective (0.1 < S < 0.3)")
        else:
            lines.append(f"- **Interpretation:** Broad-spectrum / polypharmacology (S > 0.3)")
    lines.append("")

    if active:
        lines.append("## Active Target Distribution\n")
        lines.append("| Target | ChEMBL ID | Active Probability |")
        lines.append("|--------|-----------|-------------------|")
        active.sort(key=lambda x: x['active_prob'], reverse=True)
        for t in active[:15]:
            lines.append(f"| {t['target_name']} | {t['target_id']} | {t['active_prob']:.4f} |")
        lines.append("")

    return "\n".join(lines)


def gen_14_offtarget_profile(asset, molecule_toxicology, molecule_target_activity_hits, emp01):
    lines = [f"# Off-Target Liability Profile: {asset['name']}\n"]
    offtargets = get_offtargets(molecule_target_activity_hits, n=10)

    if offtargets:
        lines.append("## Predicted Off-Target Interactions\n")
        lines.append("These targets were predicted **inactive** but have non-negligible binding probability, "
                     "suggesting potential off-target liabilities:\n")
        lines.append("| Target | ChEMBL ID | Active Probability | Indications at Risk |")
        lines.append("|--------|-----------|-------------------|-------------------|")
        for t in offtargets:
            ind_short = '; '.join(t['indications'].split(';')[:3]) if t['indications'] else 'N/A'
            lines.append(f"| {t['target_name']} | {t['target_id']} | {t['active_prob']:.4f} | {ind_short} |")
        lines.append("")
    else:
        lines.append("*No significant off-target liabilities identified from Molecule Target Activity predictions.*\n")

    if molecule_toxicology:
        lines.append("## Organ-Level Off-Target Toxicity (Molecule Toxicology)\n")
        flagged = {k: v for k, v in molecule_toxicology.items() if v.get('decision') == 'flag'}
        abstained = {k: v for k, v in molecule_toxicology.items() if v.get('decision') == 'abstain'}

        if flagged:
            lines.append("### Flagged Toxicities\n")
            for organ, p in flagged.items():
                lines.append(f"- **{organ.capitalize()}:** {p['probability']:.2%} probability (high confidence flag)")
            lines.append("")

        if abstained:
            lines.append("### Uncertain Toxicities (Abstained)\n")
            for organ, p in abstained.items():
                lines.append(f"- **{organ.capitalize()}:** {p['probability']:.2%} probability (high uncertainty: {p['uncertainty']:.4f})")
            lines.append("")

    return "\n".join(lines)


# ─── Main ────────────────────────────────────────────────────────────────────

REPORT_GENERATORS = {
    '05_therapeutic_dose.md': gen_05_therapeutic_dose,
    '06_herg_cardiac.md': gen_06_herg_cardiac,
    '07_plasma_binding.md': gen_07_plasma_binding,
    '08_ld50_toxicity.md': gen_08_ld50_toxicity,
    '09_systems_biology.md': gen_09_systems_biology,
    '10_downstream_effects.md': gen_10_downstream_effects,
    '11_target_activity.md': gen_11_target_activity,
    '12_competitor_comparison.md': gen_12_competitor_comparison,
    '13_selectivity_ratio.md': gen_13_selectivity_ratio,
    '14_offtarget_profile.md': gen_14_offtarget_profile,
}


def main():
    print("Loading data sources...")
    target_map = load_target_map()
    print(f"  Target map: {len(target_map)} ChEMBL IDs mapped")

    molecule_target_activity = load_molecule_target_activity(target_map)
    print(f"  Molecule Target Activity: {len(molecule_target_activity)} unique SMILES loaded")

    molecule_toxicology = load_molecule_toxicology()
    print(f"  Molecule Toxicology: {len(molecule_toxicology)} compounds loaded")

    emp01 = load_emp01()
    print(f"  EMP-01: {'Loaded' if emp01 else 'Not found'}")

    assets = load_assets()
    print(f"  Assets: {len(assets)} drugs to process\n")

    os.makedirs(BASE_DIR, exist_ok=True)
    generated = 0
    skipped = 0

    # Build prefix lookup for InChI matching (CSV truncates InChI at internal commas)
    def find_by_inchi_prefix(lookup_dict, truncated_inchi):
        """Find a key in lookup_dict that starts with the truncated InChI prefix."""
        if not truncated_inchi or not truncated_inchi.startswith('InChI'):
            return None
        for key in lookup_dict:
            if key.startswith(truncated_inchi):
                return key
        return None

    for asset in assets:
        smi = asset['smiles']
        asset_dir = os.path.join(BASE_DIR, asset['name'].replace(' ', '_').replace('/', '_'))
        os.makedirs(asset_dir, exist_ok=True)

        # Try exact SMILES match first, then prefix InChI match
        molecule_toxicology_key = find_by_inchi_prefix(molecule_toxicology, asset['inchi']) if not molecule_toxicology.get(smi) else smi
        asset_molecule_toxicology = molecule_toxicology.get(smi) or (molecule_toxicology.get(molecule_toxicology_key, {}) if molecule_toxicology_key else {})
        molecule_target_activity_key = find_by_inchi_prefix(molecule_target_activity, asset['inchi']) if not molecule_target_activity.get(smi) else smi
        asset_molecule_target_activity = molecule_target_activity.get(smi) or (molecule_target_activity.get(molecule_target_activity_key, []) if molecule_target_activity_key else [])

        print(f"--- {asset['name']} ({asset['company']}) ---")
        print(f"    Molecule Target Activity hits: {len(asset_molecule_target_activity)} | Molecule Toxicology data: {'Yes' if asset_molecule_toxicology else 'No'}")

        for fname, gen_func in REPORT_GENERATORS.items():
            fpath = os.path.join(asset_dir, fname)
            if os.path.exists(fpath):
                skipped += 1
                continue

            content = gen_func(asset, asset_molecule_toxicology, asset_molecule_target_activity, emp01)
            with open(fpath, 'w') as f:
                f.write(content)
            generated += 1

        print(f"    Reports written to: {asset_dir}")

    print(f"\n{'='*60}")
    print(f"COMPLETE: {generated} reports generated, {skipped} skipped (already exist)")
    print(f"Output directory: {BASE_DIR}")


if __name__ == "__main__":
    main()
