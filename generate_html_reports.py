#!/usr/bin/env python3
"""
Generate Neo-Brutalist HTML Drug Benchmarking Reports
Reads from Molecule Target Activity, Molecule Toxicology, EMP-01, FDA Approval data and outputs
one self-contained index.html per drug in Drug_Benchmarking/<drug>/
"""
import os
import csv
import json
import sys
from datetime import datetime
from bayesian_scoring import compute_bayesian_scores, run_side_effect_prediction

# ─── Configuration ───────────────────────────────────────────────────────────
BASE_DIR = "/home/michael/FDA Approval/Drug_Benchmarking"
ASSETS_FILE = "/home/michael/FDA Approval/mapped_FDA_approval_assets.csv"
MOLECULE_TARGET_ACTIVITY_FILE = "/home/michael/FDA Approval/Source_Docs/FDA Approval_Molecule Target Activity_new.json"
MOLECULE_TOXICOLOGY_FILE = "/home/michael/FDA Approval/Source_Docs/FDA_approval_molecule_toxicology_results.json"
TARGET_MAP_FILE = "/home/michael/SciTech/molecule_target_activity_target_indications_mapping.csv"
LOGO_PATH = "../../v2/assets/GATC-Health-Today-Header-Logo-v2.png"

# ─── Data Loading (same as generate_reports.py) ─────────────────────────────

def load_target_map():
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
    molecule_target_activity = {}
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


def load_clinical_data(asset_name):
    # Mapping of drug asset name to its corresponding JSON file in Source_Docs
    asset_to_file = {
        'CYB003': 'CYB003Phase2.json',
        'CYB004': 'CYB004Phase2.json',
        'OLC': 'OLCPhase3.json',
        'fasedienol': 'VistagenPhase3.json',
        'Seralutinib': 'XOMAPhase2.json',
        'Axpaxli': 'OcularPhase2.json',
        'psilocybin': 'CompassPathwaysPhase2.json',
        'Azetukalner': 'XenonPhase2.json',
        'EMP-01': 'EMP-01Phase2.json',
        'Foralumab': 'ForalumabPhase2.json',
        'cema-cel': 'AllogenePhase3.json',
        'BEAM-302': 'BEAM-302Phase2.json',
        'Verekitug': 'VerekitugPhase2.json',
        'elegrobart': 'elegrobartPhase2.json',
        'petrelintide': 'petrelintidePhase2.json',
        'AAV2-hAQP1': 'AAV2-hAQP1Phase2.json',
        'Ibudilast': 'IbudilastPhase2.json',
        'ALXN1840': 'ALXN1840Phase2.json',
        'evenamide': 'evenamidePhase2.json',
        'OCU400': 'OCU400Phase2.json',
        'eDSP': 'eDSPPhase2.json',
        'lysergide': 'lysergidePhase2.json',
    }
    
    filename = asset_to_file.get(asset_name)
    if not filename:
        return None
        
    filepath = os.path.join("/home/michael/FDA Approval/Source_Docs", filename)
    if not os.path.exists(filepath):
        return None
        
    try:
        with open(filepath, 'r') as f:
            data = json.load(f)
            if isinstance(data, list):
                if len(data) > 0:
                    return data[0]
                else:
                    return None
            return data
    except Exception as e:
        print(f"Error loading {filepath}: {e}")
        return None


def load_assets():
    """Load assets with right-side parsing to handle unquoted commas in InChI/SMILES."""
    assets = []
    with open(ASSETS_FILE, 'r') as f:
        lines = f.readlines()
    
    # Skip header
    for line in lines[1:]:
        line = line.strip()
        if not line:
            continue
        parts = line.split(',')
        # Parse from the right: last field = prediction, second-to-last = probability
        # First field = company, second field = asset name
        # Everything in between = InChI + SMILES (which contain commas)
        company = parts[0].strip()
        asset_name = parts[1].strip()
        
        # Check if last fields are probability + prediction
        pred = parts[-1].strip()
        prob = parts[-2].strip() if len(parts) > 2 else ''
        
        # Determine if this row has FDA Approval data
        has_FDA_approval = False
        try:
            if prob:
                float(prob)
                has_FDA_approval = True
        except ValueError:
            has_FDA_approval = False
        
        if has_FDA_approval:
            FDA_approval_prob = prob
            FDA_approval_pred = pred
            # InChI + SMILES is everything between asset name and probability
            middle = ','.join(parts[2:-2])
        else:
            FDA_approval_prob = ''
            FDA_approval_pred = ''
            middle = ','.join(parts[2:])
        
        # Split middle into InChI and SMILES
        # SMILES is the last segment that doesn't start with 'InChI'
        # For biologics, both are the same word
        if middle.startswith('InChI'):
            # Find where SMILES starts (after InChI ends)
            # InChI format: InChI=1S/...  SMILES is the last comma-separated field
            # that doesn't look like part of InChI
            mid_parts = middle.split(',')
            # Walk backwards to find where SMILES starts
            smiles = mid_parts[-1].strip()
            inchi = ','.join(mid_parts[:-1]).strip()
        else:
            # Biologic: both fields are the same name
            mid_parts = middle.split(',')
            inchi = mid_parts[0].strip() if mid_parts else ''
            smiles = mid_parts[1].strip() if len(mid_parts) > 1 else inchi
        
        if asset_name and asset_name != 'Unknown':
            assets.append({
                'name': asset_name,
                'company': company,
                'smiles': smiles,
                'inchi': inchi,
                'FDA_approval_prob': FDA_approval_prob,
                'FDA_approval_pred': FDA_approval_pred,
            })
    return assets


def find_by_inchi_prefix(lookup_dict, truncated_inchi):
    if not truncated_inchi or not truncated_inchi.startswith('InChI'):
        return None
    for key in lookup_dict:
        if key.startswith(truncated_inchi):
            return key
    return None


# ─── Helper functions ────────────────────────────────────────────────────────

def decision_label(d):
    labels = {'flag': '🔴 Flag', 'abstain': '🟡 Abstain', 'clear': '🟢 Clear'}
    return labels.get(d, d)

def decision_color(d):
    colors = {'flag': 'var(--status-danger)', 'abstain': 'var(--status-warning)', 'clear': 'var(--status-success)'}
    return colors.get(d, 'var(--white)')

def organ_name(organ):
    names = {'renal': 'Renal / Urinary', 'cardio': 'Cardiovascular', 'hepa': 'Hepatic / GI', 'gen': 'Genotoxic / Reproductive'}
    return names.get(organ, organ.capitalize())

def prob_pct(p):
    return f"{p:.2%}"

def is_biologic(asset):
    return asset['smiles'] in ('Monoclonal antibody', 'CAR-T', 'Lipid Nanoparticle', 'Antibody', 'Gene therapy')

def get_FDA_approval_display(asset):
    if not asset['FDA_approval_prob']:
        return 'N/A (Biologic)', 'N/A', 'var(--text-secondary)'
    try:
        prob = float(asset['FDA_approval_prob'])
    except (ValueError, TypeError):
        return 'N/A', 'N/A', 'var(--text-secondary)'
    pred = 'Approved' if asset['FDA_approval_pred'] == '1' else 'Not Approved'
    color = 'var(--status-success)' if asset['FDA_approval_pred'] == '1' else 'var(--status-danger)'
    return f"{prob:.4f}", pred, color


# ─── HTML Template ───────────────────────────────────────────────────────────

CSS = """
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap');

* { margin: 0; padding: 0; box-sizing: border-box; }

:root {
    --text-primary: #1A1D20;
    --text-secondary: #5F6B7A;
    --text-muted: #8A97A8;
    
    --bg-main: #F0F4F8;          /* Light Blue Background */
    --bg-surface: #FFFFFF;
    --bg-alt: #E3EBF3;           /* Soft blue accent */
    
    --border-light: #EBEDF0;
    --border-medium: #D1D5DB;
    --border-strong: #9CA3AF;
    
    /* Elegant Color Palette */
    --primary: #1E3A5F;          /* Professional Navy Blue */
    --primary-light: #3D6493;
    --accent: #2E86CA;           /* Brighter Clean Blue */
    --accent-light: #E6F0FA;
    
    /* Semantic Status Colors mapped from old tokens */
    --status-success: #059669;   /* Elegant Green */
    --status-warning: #D97706;   /* Amber */
    --status-danger: #DC2626;    /* Crimson */
    --status-neutral: #6B7280;   /* Cool Gray */
    
    /* Refined Shadows */
    --shadow-subtle: 0 2px 8px rgba(10, 37, 64, 0.04);
    --shadow-float: 0 8px 24px rgba(10, 37, 64, 0.06);
    --shadow-deep: 0 12px 32px rgba(10, 37, 64, 0.08);
    
    --radius-sm: 4px;
    --radius-md: 8px;
    --radius-lg: 16px;
    --radius-xl: 24px;
}

body {
    font-family: 'Roboto', -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif;
    font-size: 15px;
    background: var(--bg-main);
    color: var(--text-primary);
    line-height: 1.6;
    -webkit-font-smoothing: antialiased;
    letter-spacing: 0.01em;
}

h1, h2, h3, h4, h5 {
    font-family: 'Outfit', sans-serif;
    color: var(--primary);
    line-height: 1.2;
}

.container { 
    max-width: 1040px; 
    margin: 0 auto; 
    padding: 3rem 2rem; 
}

/* Document Header */
.header {
    background: var(--bg-surface);
    padding: 3.5rem 4rem;
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-float);
    margin-bottom: 3rem;
    border: 1px solid var(--border-light);
    position: relative;
    overflow: hidden;
}

.header::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--primary), var(--accent));
}

.logo-container {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    margin-bottom: 2.5rem;
    border-bottom: 1px solid var(--border-light);
    padding-bottom: 2rem;
}

.logo { max-width: 240px; height: auto; }

h1 { 
    font-size: 2.75rem; 
    font-weight: 700; 
    letter-spacing: -0.03em;
    margin-bottom: 0.75rem; 
}

h2 { 
    font-size: 1.75rem; 
    font-weight: 500; 
    color: var(--text-secondary);
    margin-bottom: 1rem; 
}

h3 { font-size: 1.4rem; font-weight: 600; margin-bottom: 1rem; }
h4 { 
    font-size: 1.05rem; 
    font-weight: 600; 
    color: var(--primary-light); 
    margin-bottom: 0.5rem; 
    text-transform: uppercase; 
    letter-spacing: 0.08em; 
}

p, li {
    font-weight: 300;
    color: var(--text-secondary);
    margin-bottom: 1.25rem;
}

/* Content Sections */
.section {
    padding: 4rem 0;
}

.section-title {
    text-align: center;
    margin-bottom: 3.5rem;
    padding-bottom: 1.5rem;
}

.section-title h2 {
    font-size: 2.25rem;
    font-weight: 600;
    color: var(--primary);
    position: relative;
    display: inline-block;
}

.section-title h2::after {
    content: '';
    position: absolute;
    bottom: -15px;
    left: 50%;
    transform: translateX(-50%);
    width: 60px;
    height: 3px;
    background: var(--accent);
    border-radius: 2px;
}

/* Brutal Box replacement -> Premium Card */
.brutal-box {
    background: var(--bg-surface);
    border-radius: var(--radius-lg);
    padding: 3rem;
    box-shadow: var(--shadow-subtle);
    border: 1px solid var(--border-light);
    margin-bottom: 3rem;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.brutal-box:hover {
    box-shadow: var(--shadow-float);
    transform: translateY(-2px);
}

/* Stats Metrics Grid */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1.5rem;
    margin: 2.5rem 0;
}

.stat-box {
    background: var(--bg-surface);
    border-radius: var(--radius-md);
    padding: 2.5rem 1.5rem;
    text-align: center;
    border: 1px solid var(--border-light);
    box-shadow: var(--shadow-subtle);
}

.stat-number { 
    font-family: 'Outfit', sans-serif;
    font-size: 3rem; 
    font-weight: 300; 
    color: var(--accent); 
    line-height: 1; 
    margin-bottom: 0.5rem; 
}
.stat-label { 
    font-size: 0.85rem; 
    font-weight: 500; 
    color: var(--text-muted); 
    text-transform: uppercase; 
    letter-spacing: 0.1em; 
}

/* Elegant Tables */
.data-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin: 2.5rem 0;
    background: var(--bg-surface);
    border-radius: var(--radius-md);
    border: 1px solid var(--border-light);
    overflow: hidden;
}

.data-table th, .data-table td {
    padding: 1.25rem 1.5rem;
    font-size: 0.95rem;
    text-align: left;
    border-bottom: 1px solid var(--border-light);
}

.data-table th {
    background: var(--bg-alt);
    color: var(--primary);
    font-family: 'Outfit', sans-serif;
    font-weight: 500;
    font-size: 0.9rem;
    letter-spacing: 0.05em;
    text-transform: uppercase;
}

.data-table tr:last-child td { border-bottom: none; }
.data-table tr:hover td { background: var(--bg-main); }

/* Accordion Component */
.accordion-item {
    border: 1px solid var(--border-light);
    border-radius: var(--radius-md);
    margin-bottom: 1.25rem;
    background: var(--bg-surface);
    box-shadow: var(--shadow-subtle);
    overflow: hidden;
}

.accordion-header {
    padding: 1.5rem 2rem;
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: var(--bg-surface);
    border-left: 4px solid transparent;
    transition: all 0.2s ease;
}

.accordion-header:hover { 
    background: var(--bg-alt); 
    border-left-color: var(--accent);
}

.accordion-header h3 { 
    margin-bottom: 0; 
    font-size: 1.25rem; 
    font-weight: 500;
}

.accordion-score { 
    font-family: 'Outfit', sans-serif;
    font-size: 1.35rem; 
    font-weight: 600; 
}

.accordion-content {
    padding: 2rem;
    background: var(--bg-main);
    border-top: 1px solid var(--border-light);
    display: none;
}

.accordion-content.active { display: block; }

/* Toxicity Risk Bar */
.tox-bar-container {
    width: 100%;
    height: 8px;
    border-radius: 4px;
    background: var(--border-light);
    position: relative;
    margin: 1rem 0 2rem;
    overflow: hidden;
}

.tox-bar-fill {
    height: 100%;
    border-radius: 4px;
    transition: width 1s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Insight Cards Grid */
.insights-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2rem;
    margin: 3rem 0;
}

.insight-card {
    background: var(--bg-surface);
    border-radius: var(--radius-md);
    padding: 2.5rem 2rem;
    border: 1px solid var(--border-light);
    box-shadow: var(--shadow-subtle);
}

.insight-card h4 { 
    margin-bottom: 1.5rem; 
    color: var(--primary);
}

.insight-card ul { list-style: none; padding-left: 0; }
.insight-card li { 
    padding: 0.5rem 0 0.5rem 1.5rem; 
    position: relative; 
    font-size: 0.95rem;
    line-height: 1.5;
}
.insight-card li::before { 
    content: '→'; 
    color: var(--accent); 
    position: absolute; 
    left: 0; 
    font-family: 'Outfit';
    font-weight: 600;
}

/* Pill Badges */
.badge {
    display: inline-block;
    padding: 0.35rem 0.85rem;
    border-radius: 20px;
    font-family: 'Outfit', sans-serif;
    font-weight: 500;
    font-size: 0.8rem;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    background: var(--bg-alt);
    color: var(--primary);
    border: 1px solid var(--border-light);
}

/* Chart Container */
.chart-container {
    background: var(--bg-surface);
    border-radius: var(--radius-lg);
    padding: 3rem;
    margin: 3rem 0;
    border: 1px solid var(--border-light);
    box-shadow: var(--shadow-subtle);
}

.chart-wrapper { max-width: 650px; margin: 0 auto; }

/* Elegant Footer */
footer {
    padding: 4rem 2rem;
    margin-top: 5rem;
    text-align: center;
    border-top: 1px solid var(--border-light);
}

footer p {
    font-size: 0.85rem;
    color: var(--text-muted);
}

/* Print Styles for PDF */
@media print {
    body { 
        background: var(--bg-surface) !important; 
        -webkit-print-color-adjust: exact !important; 
        print-color-adjust: exact !important;
        font-size: 8pt;
        line-height: 1.3;
    }
    .container { max-width: 100%; padding: 0 0.5cm; margin: 0; }
    
    .header, .brutal-box, .chart-container, .accordion-item, .stat-box {
        box-shadow: none !important;
        border: 1px solid #E5E7EB !important;
        page-break-inside: avoid;
        padding: 0.75rem !important;
        margin-bottom: 0.75rem !important;
        border-radius: 4px !important;
    }
    
    .header { 
        padding: 1rem !important; 
        margin-bottom: 1rem !important; 
    }
    
    .section { 
        padding: 0.5rem 0; 
        margin: 0;
    }
    
    .section-title { 
        margin-bottom: 0.5rem; 
        padding-bottom: 0; 
    }
    .section-title h2 { 
        font-size: 12pt; 
        margin-bottom: 0;
    }
    .section-title h2::after { 
        display: none; 
    }
    
    h1 { font-size: 16pt; color: #0A2540; margin-bottom: 0.2rem; }
    h2 { font-size: 13pt; color: #2A496E; margin-bottom: 0.2rem; }
    h3 { font-size: 11pt; margin-bottom: 0.2rem; }
    h4 { font-size: 9pt; margin-bottom: 0.1rem; }
    
    p, li { 
        font-size: 8pt; 
        margin-bottom: 0.3rem; 
        line-height: 1.3; 
    }
    
    .stats-grid { 
        gap: 0.5rem; 
        margin: 0.5rem 0; 
        grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
    }
    .stat-box { padding: 0.5rem; }
    .stat-number { font-size: 14pt; margin-bottom: 0; }
    .stat-label { font-size: 7pt; }
    
    .insights-grid { gap: 0.5rem; margin: 0.5rem 0; }
    .insight-card { padding: 0.75rem; }
    
    .chart-container { padding: 0.5rem !important; margin: 0.5rem 0 !important; }
    
    .data-table { margin: 0.5rem 0; }
    .data-table th, .data-table td { padding: 0.3rem 0.4rem; font-size: 8pt; }
    
    .accordion-item { margin-bottom: 0.5rem; }
    .accordion-header { padding: 0.5rem 0.75rem; }
    .accordion-header h3 { font-size: 10pt; }
    .accordion-score { font-size: 11pt; }
    .accordion-content { display: block !important; padding: 0.5rem 0.75rem; }
    
    .tox-bar-container { margin: 0.5rem 0 0.5rem; height: 6px; }
    
    /* Remove unnecessary UI elements for print */
    footer, .logo { display: none !important; }
}
"""


def generate_html(asset, molecule_toxicology_data, molecule_target_activity_data, clinical_data=None, bayesian_scores=None, side_effects=None, pathway_data=None):
    """Generate a complete self-contained HTML report for one drug."""
    name = asset['name']
    company = asset['company']
    prob_str, pred_str, pred_color = get_FDA_approval_display(asset)
    biologic = is_biologic(asset)

    # ─── Compute stats ───
    all_hits = molecule_target_activity_data if molecule_target_activity_data else []
    unique_targets = list({h['target_id']: h for h in all_hits}.values())
    active_targets = [h for h in unique_targets if float(h.get('active_prob', 0)) > 0.70]
    inactive_targets = [h for h in unique_targets if float(h.get('active_prob', 0)) <= 0.70]
    total_count = len(unique_targets)
    active_count = len(active_targets)
    selectivity = active_count / total_count if total_count > 0 else 0

    # Top targets
    top_active = sorted(active_targets, key=lambda x: x['active_prob'], reverse=True)[:15]
    # Off-targets
    offtargets = sorted(
        [h for h in inactive_targets if h['active_prob'] > 0.05],
        key=lambda x: x['active_prob'], reverse=True
    )[:10]

    # Selectivity interpretation
    if selectivity < 0.1:
        sel_interp = "Highly Selective (S < 0.1)"
        sel_color = "var(--status-success)"
    elif selectivity < 0.3:
        sel_interp = "Moderately Selective (0.1 < S < 0.3)"
        sel_color = "var(--status-warning)"
    else:
        sel_interp = "Broad-Spectrum / Polypharmacology (S > 0.3)"
        sel_color = "var(--status-danger)"

    # Molecule Toxicology organs
    molecule_toxicology_organs = []
    if molecule_toxicology_data:
        for organ in ['renal', 'cardio', 'hepa', 'gen']:
            if organ in molecule_toxicology_data:
                p = molecule_toxicology_data[organ]
                molecule_toxicology_organs.append({
                    'organ': organ,
                    'name': organ_name(organ),
                    'prob': p['probability'],
                    'uncertainty': p['uncertainty'],
                    'decision': p['decision'],
                    'label': decision_label(p['decision']),
                    'color': decision_color(p['decision']),
                })

    worst_organ = max(molecule_toxicology_organs, key=lambda x: x['prob']) if molecule_toxicology_organs else None
    flagged = [v for v in molecule_toxicology_organs if v['decision'] == 'flag']

    # ─── Build HTML ───
    html = []
    html.append(f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{name} — Drug Benchmarking Report | GATC Health</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    <style>
{CSS}
    </style>
</head>
<body>

    <!-- HEADER -->
    <div class="header">
        <div class="container">
            <div class="logo-container">
                <img src="{LOGO_PATH}" alt="GATC Health Today" class="logo">
                <div class="badge" style="background: var(--cyan); color: var(--black);">Drug Benchmarking Report</div>
            </div>
            <h1>{name.upper()}</h1>
            <p style="font-size: 1.15rem; color: var(--white); margin-top: 0.8rem; line-height: 1.7;">
                <strong>Company:</strong> {company}<br>
                <strong>FDA Approval Prediction:</strong> <span style="color: {pred_color}; font-weight: 900;">{pred_str}</span>
                {f' ({prob_str})' if asset["FDA_approval_prob"] else ''}
            </p>
        </div>
    </div>

    <!-- NAV -->
    <nav class="container">
        <ul>
            <li><a href="#overview" class="active">Overview</a></li>
            <li><a href="#bayesian">Bayesian Score</a></li>
            <li><a href="#toxicity">Toxicity</a></li>
            <li><a href="#targets">Target Activity</a></li>
            <li><a href="#selectivity">Selectivity</a></li>
            <li><a href="#offtarget">Off-Target</a></li>
            <li><a href="#sideeffects">Side Effects</a></li>
""")

    if clinical_data:
        html.append('            <li><a href="#clinical">Clinical Trial</a></li>\n')

    html.append("""        </ul>
    </nav>

    <main class="container">
""")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 1: OVERVIEW
    # ═══════════════════════════════════════════════════════════════════════
    html.append(f"""
        <section id="overview" class="section">
            <div class="section-title"><h2>OVERVIEW</h2></div>

            <div class="stats-grid">
                <div class="stat-box" style="background: {pred_color};">
                    <div class="stat-number">{pred_str}</div>
                    <div class="stat-label">FDA Approval Prediction</div>
                </div>
                <div class="stat-box" style="background: var(--cyan);">
                    <div class="stat-number">{prob_str}</div>
                    <div class="stat-label">Approval Probability</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">{total_count}</div>
                    <div class="stat-label">Targets Screened</div>
                </div>
                <div class="stat-box" style="background: {sel_color};">
                    <div class="stat-number">{selectivity:.1%}</div>
                    <div class="stat-label">Selectivity Index</div>
                </div>
            </div>
""")

    if biologic:
        html.append(f"""
            <div class="brutal-box" style="background: var(--yellow);">
                <h3>⚠️ Biologic / Gene Therapy</h3>
                <p style="font-size: 1.1rem;">{name} is classified as a <strong>{asset['smiles']}</strong>. 
                FDA Approval and Molecule Toxicology computational predictions are not applicable. 
                Molecule Target Activity target activity predictions may also be limited.</p>
            </div>
""")
    else:
        html.append(f"""
            <div class="brutal-box" style="background: var(--cyan);">
                <h3>Interpretation</h3>
                <p style="font-size: 1.1rem;">
                    {name} was screened against <strong>{total_count} biological targets</strong> via Molecule Target Activity, 
                    with <strong>{active_count} predicted active</strong> ({selectivity:.1%} selectivity). 
                    {f"Molecule Toxicology flagged <strong>{len(flagged)} organ system(s)</strong> for toxicity concern." if flagged else "No organ systems were flagged by Molecule Toxicology."}
                    {f"FDA Approval assigns an approval probability of <strong>{prob_str}</strong>." if asset['FDA_approval_prob'] else ""}
                </p>
            </div>
""")

    html.append("        </section>\n")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 1.5: BAYESIAN 5-DOMAIN SCORING
    # ═══════════════════════════════════════════════════════════════════════
    if bayesian_scores:
        bs = bayesian_scores
        html.append(f"""
        <section id="bayesian" class="section">
            <div class="section-title"><h2>BAYESIAN 5-DOMAIN SCORING</h2></div>

            <div class="stats-grid">
                <div class="stat-box" style="background: {bs['grade_color']};">
                    <div class="stat-number">Grade {bs['grade']}</div>
                    <div class="stat-label">Composite Grade</div>
                </div>
                <div class="stat-box" style="background: var(--cyan);">
                    <div class="stat-number">{bs['probability_pct']}</div>
                    <div class="stat-label">Bayesian P(Success)</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">{bs['multiplier']}×</div>
                    <div class="stat-label">vs 7% Base Rate</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">{bs['total_adjustment']:+.4f}</div>
                    <div class="stat-label">Total Log-Odds Adj.</div>
                </div>
            </div>

            <div class="brutal-box" style="background: var(--white);">
                <h3 style="margin-bottom: 2rem; text-align: center;">DOMAIN CONTRIBUTIONS</h3>
""")
        domain_bg_colors = ['var(--yellow)', 'var(--cyan)', 'var(--pink)', 'var(--lime)', 'var(--orange)']
        for i, d in enumerate(bs['domains']):
            is_pos = d['contribution'] >= 0
            bar_w = max(5, abs(d['contribution']) * 800)
            arrow = '↗ Positive' if is_pos else '↘ Negative'
            val_color = 'var(--black)' if is_pos else 'var(--pink)'
            html.append(f"""
                <div style="display: flex; align-items: center; margin-bottom: 1.5rem; gap: 1rem; padding: 1rem; background: {domain_bg_colors[i]}; border: 4px solid var(--black); box-shadow: 4px 4px 0 #000;">
                    <div style="flex: 0 0 180px;">
                        <div style="font-weight: 900; font-size: 1.1rem;">{d['roman']}. {d['name'].upper()}</div>
                        <div style="font-size: 0.9rem; font-weight: 500;">Weight: {d['weight']:.0%}</div>
                    </div>
                    <div style="flex: 0 0 120px; text-align: center;">
                        <div style="font-size: 0.9rem; font-weight: 700;">Score: {d['score']:+.3f}</div>
                        <div style="font-size: 1.5rem; font-weight: 900; color: {val_color};">{d['contribution']:+.4f}</div>
                    </div>
                    <div style="flex: 1; display: flex; align-items: center; gap: 0.5rem;">
                        <div style="height: 12px; background: {'var(--black)' if is_pos else 'var(--pink)'}; border: 3px solid var(--black); width: {bar_w:.0f}px; max-width: 100%;"></div>
                        <span style="font-size: 0.9rem; font-weight: 700;">{arrow}</span>
                    </div>
                </div>
""")
        # Prior → Adj → Posterior
        html.append(f"""
                <div style="border-top: 5px solid var(--black); margin: 2rem 0; padding-top: 2rem;">
                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem;">
                        <div style="text-align: center; padding: 1rem; background: var(--black); color: var(--white); border: 4px solid var(--black);">
                            <div style="font-size: 0.9rem; font-weight: 700;">PRIOR</div>
                            <div style="font-size: 1.8rem; font-weight: 900;">{bs['prior']}</div>
                            <div style="font-size: 0.9rem;">(7% base rate)</div>
                        </div>
                        <div style="text-align: center; padding: 1rem; background: var(--white); border: 4px solid var(--black);">
                            <div style="font-size: 0.9rem; font-weight: 700;">ADJUSTMENT</div>
                            <div style="font-size: 1.8rem; font-weight: 900; color: var(--orange);">{bs['total_adjustment']:+.4f}</div>
                            <div style="font-size: 0.9rem;">Net contribution</div>
                        </div>
                        <div style="text-align: center; padding: 1rem; background: {bs['grade_color']}; border: 4px solid var(--black);">
                            <div style="font-size: 0.9rem; font-weight: 700;">POSTERIOR</div>
                            <div style="font-size: 1.8rem; font-weight: 900;">{bs['posterior']}</div>
                            <div style="font-size: 0.9rem;">({bs['probability_pct']} probability)</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="accordion">
""")
        for i, d in enumerate(bs['domains'], 1):
            html.append(f"""
                <div class="accordion-item">
                    <div class="accordion-header" onclick="toggleAccordion({i})" style="background: {domain_bg_colors[i-1]};">
                        <div>
                            <h3>{d['roman']}. {d['name'].upper()} (Weight: {d['weight']:.0%})</h3>
                            <p style="font-family: Arial; font-weight: 500; margin: 0;">Score: {d['score']:+.3f} → Contribution: {d['contribution']:+.4f}</p>
                        </div>
                        <div class="accordion-score">{d['contribution']:+.4f}</div>
                    </div>
                    <div class="accordion-content" id="accordion-{i}">
                        <h4>Assessment</h4>
                        <p>{d['rationale']}</p>
                    </div>
                </div>
""")
        html.append("""
            </div>
        </section>
""")
    else:
        html.append("""
        <section id="bayesian" class="section">
            <div class="section-title"><h2>BAYESIAN 5-DOMAIN SCORING</h2></div>
            <div class="brutal-box" style="background: var(--yellow);">
                <h3>Not Available</h3>
                <p>Bayesian domain scoring requires small-molecule computational data (Molecule Target Activity, Molecule Toxicology, FDA Approval). This compound is classified as a biologic/gene therapy.</p>
            </div>
        </section>
""")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 1.6: SIDE EFFECTS
    # ═══════════════════════════════════════════════════════════════════════
    html.append("""
        <section id="sideeffects" class="section">
            <div class="section-title"><h2>PREDICTED SIDE EFFECTS</h2></div>
""")
    if side_effects and side_effects.get('predictions'):
        se = side_effects
        risk = se['risk_score']
        risk_color = 'var(--lime)' if risk < 3 else ('var(--yellow)' if risk < 6 else 'var(--pink)')
        html.append(f"""
            <div class="stats-grid">
                <div class="stat-box" style="background: {risk_color};">
                    <div class="stat-number">{risk:.1f}/10</div>
                    <div class="stat-label">Overall Risk Score</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">{len(se['predictions'])}</div>
                    <div class="stat-label">Predicted Side Effects</div>
                </div>
                <div class="stat-box" style="background: var(--cyan);">
                    <div class="stat-number">{se['method'].replace('_', ' ').title()}</div>
                    <div class="stat-label">Prediction Method</div>
                </div>
            </div>
""")
        # Similar drugs
        if se.get('similar_drugs'):
            html.append('            <div class="brutal-box" style="background: var(--cyan);">\n                <h3>Similar Known Drugs</h3>\n                <table class="data-table"><thead><tr><th>Drug</th><th>Similarity</th></tr></thead><tbody>\n')
            for sd in se['similar_drugs'][:5]:
                html.append(f'                    <tr><td><strong>{sd["drug_name"]}</strong></td><td>{sd["similarity"]:.2f}</td></tr>\n')
            html.append('                </tbody></table>\n            </div>\n')

        # Top side effects table
        html.append(f"""
            <div class="brutal-box">
                <h3>Top {min(15, len(se['predictions']))} Predicted Side Effects</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Side Effect</th>
                            <th>Probability</th>
                            <th>Severity</th>
                            <th>Mechanism</th>
                        </tr>
                    </thead>
                    <tbody>
""")
        for i, p in enumerate(se['predictions'][:15], 1):
            sev = p.get('severity', 'unknown')
            sev_color = 'var(--pink)' if sev == 'severe' else ('var(--orange)' if sev == 'moderate' else 'var(--white)')
            mech = p.get('mechanism', '')[:80]
            html.append(f"""                        <tr>
                            <td style="font-weight: 900;">{i}</td>
                            <td><strong>{p['side_effect']}</strong></td>
                            <td style="font-weight: 900;">{p['probability']:.3f}</td>
                            <td style="background: {sev_color}; font-weight: 700;">{sev.capitalize()}</td>
                            <td style="font-size: 0.85rem;">{mech}</td>
                        </tr>
""")
        html.append("                    </tbody>\n                </table>\n            </div>\n")

        # Severity chart
        sevs = {'mild': 0, 'moderate': 0, 'severe': 0, 'unknown': 0}
        for p in se['predictions']:
            s = p.get('severity', 'unknown')
            sevs[s] = sevs.get(s, 0) + 1
        html.append(f"""
            <div class="chart-container">
                <h3 style="text-align: center; margin-bottom: 1rem;">Side Effect Severity Distribution</h3>
                <div class="chart-wrapper">
                    <canvas id="sevChart"></canvas>
                </div>
            </div>
            <script>
                new Chart(document.getElementById('sevChart').getContext('2d'), {{
                    type: 'doughnut',
                    data: {{
                        labels: ['Mild', 'Moderate', 'Severe', 'Unknown'],
                        datasets: [{{
                            data: [{sevs['mild']}, {sevs['moderate']}, {sevs['severe']}, {sevs['unknown']}],
                            backgroundColor: ['#AAFF00', '#FF6B00', '#FF006E', '#FFD600'],
                            borderColor: '#000',
                            borderWidth: 4
                        }}]
                    }},
                    options: {{
                        plugins: {{ legend: {{ labels: {{ font: {{ size: 14, weight: 'bold' }} }} }} }}
                    }}
                }});
            </script>
""")
    else:
        html.append("""
            <div class="brutal-box" style="background: var(--yellow);">
                <h3>Not Available</h3>
                <p>Side effect predictions require a valid SMILES string and access to the SideEffectEstimator database. This compound may be a biologic or had no predictable side effects.</p>
            </div>
""")
    html.append("        </section>\n")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 2: TOXICITY PROFILE
    # ═══════════════════════════════════════════════════════════════════════
    html.append("""
        <section id="toxicity" class="section">
            <div class="section-title"><h2>TOXICITY PROFILE</h2></div>
""")

    if molecule_toxicology_organs:
        # Table
        html.append("""
            <div class="brutal-box">
                <h3>Molecule Toxicology Multi-Organ Toxicity Predictions</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Organ System</th>
                            <th>Probability</th>
                            <th>Uncertainty</th>
                            <th>Decision</th>
                        </tr>
                    </thead>
                    <tbody>
""")
        for v in molecule_toxicology_organs:
            html.append(f"""                        <tr>
                            <td><strong>{v['name']}</strong></td>
                            <td>{v['prob']:.4f}</td>
                            <td>{v['uncertainty']:.4f}</td>
                            <td style="background: {v['color']}; font-weight: 900;">{v['label']}</td>
                        </tr>
""")
        html.append("                    </tbody>\n                </table>\n            </div>\n")

        # Visual bars
        html.append('            <div class="brutal-box">\n                <h3>Toxicity Risk Visualization</h3>\n')
        for v in molecule_toxicology_organs:
            bar_color = 'var(--pink)' if v['decision'] == 'flag' else ('var(--yellow)' if v['decision'] == 'abstain' else 'var(--lime)')
            width = max(5, v['prob'] * 100)
            html.append(f"""                <div style="margin-bottom: 0.5rem;">
                    <div style="display: flex; justify-content: space-between; font-weight: 900; font-size: 0.95rem;">
                        <span>{v['name']}</span>
                        <span>{v['prob']:.2%}</span>
                    </div>
                    <div class="tox-bar-container">
                        <div class="tox-bar-fill" style="width: {width:.0f}%; background: {bar_color};"></div>
                    </div>
                </div>
""")
        html.append("            </div>\n")

        # Primary concern + flagged
        if worst_organ:
            html.append(f"""
            <div class="brutal-box" style="background: {'var(--pink)' if worst_organ['decision'] == 'flag' else 'var(--yellow)'};">
                <h3>Primary Toxicity Concern</h3>
                <p style="font-size: 1.15rem;">The highest predicted toxicity risk is 
                <strong>{worst_organ['name']}</strong> at <strong>{worst_organ['prob']:.2%}</strong> probability.</p>
""")
            if flagged:
                organs_str = ', '.join(f['name'] for f in flagged)
                html.append(f'                <p style="font-weight: 900;">⚠️ Flagged organs: {organs_str}</p>\n')
            html.append("            </div>\n")

        # Radar chart
        labels = [v['name'] for v in molecule_toxicology_organs]
        probs = [round(v['prob'], 4) for v in molecule_toxicology_organs]
        uncertainties = [round(v['uncertainty'], 4) for v in molecule_toxicology_organs]
        html.append(f"""
            <div class="chart-container">
                <h3 style="text-align: center; margin-bottom: 1rem;">Toxicity Radar</h3>
                <div class="chart-wrapper">
                    <canvas id="toxRadar"></canvas>
                </div>
            </div>
            <script>
                new Chart(document.getElementById('toxRadar').getContext('2d'), {{
                    type: 'radar',
                    data: {{
                        labels: {json.dumps(labels)},
                        datasets: [
                            {{
                                label: 'Toxicity Probability',
                                data: {json.dumps(probs)},
                                borderColor: '#DC2626', /* var(--status-danger) */
                                backgroundColor: 'rgba(220, 38, 38, 0.1)',
                                borderWidth: 2,
                                pointRadius: 4,
                                pointBackgroundColor: '#DC2626',
                                pointBorderColor: '#FFF'
                            }},
                            {{
                                label: 'Uncertainty',
                                data: {json.dumps(uncertainties)},
                                borderColor: '#D97706', /* var(--status-warning) */
                                backgroundColor: 'transparent',
                                borderWidth: 2,
                                pointRadius: 3,
                                pointBackgroundColor: '#D97706',
                                pointBorderColor: '#FFF',
                                borderDash: [4, 4]
                            }}
                        ]
                    }},
                    options: {{
                        scales: {{
                            r: {{
                                beginAtZero: true,
                                max: 1,
                                ticks: {{ stepSize: 0.2, font: {{ family: 'Outfit', size: 10 }}, color: '#8A97A8', backdropColor: 'transparent' }},
                                pointLabels: {{ font: {{ family: 'Outfit', size: 12, weight: '500' }}, color: '#5F6B7A' }},
                                grid: {{ color: '#EBEDF0' }},
                                angleLines: {{ color: '#EBEDF0' }}
                            }}
                        }},
                        plugins: {{
                            legend: {{ labels: {{ font: {{ family: 'Roboto', size: 13 }}, color: '#1A1D20', usePointStyle: true, padding: 20 }} }}
                        }}
                    }}
                }});
            </script>
""")
    else:
        html.append("""
            <div class="brutal-box" style="border-left: 4px solid var(--status-warning);">
                <h3 style="color: var(--status-warning);">No Molecule Toxicology Data Available</h3>
                <p>Computational toxicity predictions are not available for this compound. 
                This is typical for biologics, gene therapies, and compounds not in the Molecule Toxicology screening library.</p>
            </div>
""")

    html.append("        </section>\n")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 3: TARGET ACTIVITY
    # ═══════════════════════════════════════════════════════════════════════
    html.append("""
        <section id="targets" class="section">
            <div class="section-title"><h2>TARGET ACTIVITY</h2></div>
""")

    if top_active:
        html.append(f"""
            <div class="brutal-box" style="border-top: 4px solid var(--primary-light);">
                <h3 style="margin-bottom: 2rem;">Overview</h3>
                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="stat-number" style="color: var(--primary);">{total_count}</div>
                        <div class="stat-label">Total Targets</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number" style="color: var(--status-success);">{active_count}</div>
                        <div class="stat-label">Active Targets</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number" style="color: {sel_color};">{selectivity:.2%}</div>
                        <div class="stat-label">{sel_interp.split('(')[0].strip()}</div>
                    </div>
                </div>
            </div>

            <div class="brutal-box">
                <h3>Top {len(top_active)} Active Targets</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Target</th>
                            <th>ChEMBL ID</th>
                            <th>Active Probability</th>
                            <th>Indications</th>
                        </tr>
                    </thead>
                    <tbody>
""")
        for i, t in enumerate(top_active, 1):
            ind = '; '.join(t['indications'].split(';')[:3]) if t['indications'] else '—'
            html.append(f"""                        <tr>
                            <td style="font-weight: 900;">{i}</td>
                            <td><strong>{t['target_name']}</strong></td>
                            <td>{t['target_id']}</td>
                            <td style="font-weight: 900;">{t['active_prob']:.4f}</td>
                            <td style="font-size: 0.85rem;">{ind}</td>
                        </tr>
""")
        html.append("                    </tbody>\n                </table>\n            </div>\n")

        # Bar chart for top targets
        top10_labels = [t['target_name'][:20] for t in top_active[:10]]
        top10_probs = [round(t['active_prob'], 4) for t in top_active[:10]]
        html.append(f"""
            <div class="chart-container">
                <h3 style="text-align: center; margin-bottom: 1.5rem; color: var(--primary);">Top Target Activity Probabilities</h3>
                <div style="max-width: 800px; margin: 0 auto;">
                    <canvas id="targetBar"></canvas>
                </div>
            </div>
            <script>
                new Chart(document.getElementById('targetBar').getContext('2d'), {{
                    type: 'bar',
                    data: {{
                        labels: {json.dumps(top10_labels)},
                        datasets: [{{
                            label: 'Active Probability',
                            data: {json.dumps(top10_probs)},
                            backgroundColor: '#0077B6', /* var(--accent) */
                            borderRadius: 4,
                            barThickness: 'flex',
                            maxBarThickness: 40
                        }}]
                    }},
                    options: {{
                        indexAxis: 'y',
                        scales: {{
                            x: {{
                                beginAtZero: true,
                                max: 1,
                                ticks: {{ font: {{ family: 'Roboto', size: 11 }}, color: '#8A97A8' }},
                                grid: {{ color: '#EBEDF0', drawBorder: false }}
                            }},
                            y: {{
                                ticks: {{ font: {{ family: 'Outfit', size: 13, weight: '500' }}, color: '#1A1D20' }},
                                grid: {{ display: false, drawBorder: false }}
                            }}
                        }},
                        plugins: {{
                            legend: {{ display: false }}
                        }}
                    }}
                }});
            </script>
""")
    elif pathway_data:
        html.append("""
            <div class="brutal-box" style="border-top: 4px solid var(--accent);">
                <h3>Reactome Pathway Analysis</h3>
                <p>Due to the size and nature of this biologic/antibody, Molecule Target Activity target predictions are unavailable.</p>
                <p>The following significant pathways are associated with this drug's primary target(s):</p>
                <table class="data-table" style="margin-top: 1rem;">
                    <thead>
                        <tr>
                            <th>Target</th>
                            <th>Pathway ID</th>
                            <th>Pathway Name</th>
                            <th>Top Level Term</th>
                        </tr>
                    </thead>
                    <tbody>
""")
        for p in pathway_data:
            html.append(f"""
                        <tr>
                            <td><strong>{p.get('target', 'N/A')}</strong></td>
                            <td>{p.get('pathwayId', 'N/A')}</td>
                            <td>{p.get('pathway', 'N/A')}</td>
                            <td>{p.get('topLevelTerm', 'N/A')}</td>
                        </tr>
""")
        html.append("""
                    </tbody>
                </table>
            </div>
""")
    else:
        html.append("""
            <div class="brutal-box" style="background: var(--yellow);">
                <h3>No Active Targets Predicted</h3>
                <p>Molecule Target Activity did not predict any active targets for this compound. 
                This may indicate the compound was not in the screening library or is a biologic.</p>
            </div>
""")

    html.append("        </section>\n")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 4: SELECTIVITY
    # ═══════════════════════════════════════════════════════════════════════
    if total_count > 0:
        html.append(f"""
        <section id="selectivity" class="section">
            <div class="section-title"><h2>SELECTIVITY ANALYSIS</h2></div>

            <div class="brutal-box">
                <h3>Selectivity Profile</h3>
                <div class="stats-grid">
                    <div class="stat-box" style="background: var(--lime);">
                        <div class="stat-number">{active_count}</div>
                        <div class="stat-label">Active</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number">{len(inactive_targets)}</div>
                        <div class="stat-label">Inactive</div>
                    </div>
                    <div class="stat-box" style="background: {sel_color};">
                        <div class="stat-number">{selectivity:.4f}</div>
                        <div class="stat-label">S-Score Analog</div>
                    </div>
                </div>

                <div class="brutal-box" style="background: {sel_color}; margin-top: 1rem;">
                    <h4>Interpretation</h4>
                    <p style="font-size: 1.1rem; margin-bottom: 0;"><strong>{sel_interp}</strong></p>
                </div>
            </div>

            <div class="chart-container">
                <h3 style="text-align: center; margin-bottom: 1rem;">Active vs Inactive Targets</h3>
                <div class="chart-wrapper">
                    <canvas id="selectivityPie"></canvas>
                </div>
            </div>
            <script>
                new Chart(document.getElementById('selectivityPie').getContext('2d'), {{
                    type: 'doughnut',
                    data: {{
                        labels: ['Active', 'Inactive'],
                        datasets: [{{
                            data: [{active_count}, {len(inactive_targets)}],
                            backgroundColor: ['#AAFF00', '#FF006E'],
                            borderColor: '#000',
                            borderWidth: 4
                        }}]
                    }},
                    options: {{
                        plugins: {{
                            legend: {{ labels: {{ font: {{ size: 14, weight: 'bold' }} }} }}
                        }}
                    }}
                }});
            </script>
        </section>
""")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 5: OFF-TARGET PROFILE
    # ═══════════════════════════════════════════════════════════════════════
    html.append("""
        <section id="offtarget" class="section">
            <div class="section-title"><h2>OFF-TARGET PROFILE</h2></div>
""")

    if offtargets:
        html.append(f"""
            <div class="brutal-box">
                <h3>Predicted Off-Target Interactions</h3>
                <p>Targets predicted <strong>inactive</strong> but with non-negligible binding probability, 
                suggesting potential off-target liabilities:</p>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Target</th>
                            <th>ChEMBL ID</th>
                            <th>Active Probability</th>
                            <th>Indications at Risk</th>
                        </tr>
                    </thead>
                    <tbody>
""")
        for t in offtargets:
            ind = '; '.join(t['indications'].split(';')[:3]) if t['indications'] else '—'
            html.append(f"""                        <tr>
                            <td><strong>{t['target_name']}</strong></td>
                            <td>{t['target_id']}</td>
                            <td>{t['active_prob']:.4f}</td>
                            <td style="font-size: 0.85rem;">{ind}</td>
                        </tr>
""")
        html.append("                    </tbody>\n                </table>\n            </div>\n")
    else:
        html.append("""
            <div class="brutal-box" style="background: var(--lime);">
                <h3>No Significant Off-Target Liabilities</h3>
                <p>No off-target liabilities were identified from Molecule Target Activity predictions.</p>
            </div>
""")

    # Molecule Toxicology organ-level off-target
    if molecule_toxicology_data:
        flagged_v = {k: v for k, v in molecule_toxicology_data.items() if v.get('decision') == 'flag'}
        abstained_v = {k: v for k, v in molecule_toxicology_data.items() if v.get('decision') == 'abstain'}

        if flagged_v or abstained_v:
            html.append('            <div class="brutal-box" style="border-left: 4px solid var(--status-danger);">\n                <h3 style="color: var(--status-danger);">Organ-Level Off-Target Toxicity</h3>\n')
            if flagged_v:
                html.append('                <h4 style="margin-top: 1.5rem; color: var(--text-primary);">Flagged (High Confidence)</h4>\n                <ul>\n')
                for organ, p in flagged_v.items():
                    html.append(f'                    <li><strong>{organ.capitalize()}:</strong> <span style="color: var(--status-danger)">{p["probability"]:.2%} probability</span></li>\n')
                html.append('                </ul>\n')
            if abstained_v:
                html.append('                <h4 style="margin-top: 1.5rem; color: var(--text-primary);">Uncertain (Abstained)</h4>\n                <ul>\n')
                for organ, p in abstained_v.items():
                    html.append(f'                    <li><strong>{organ.capitalize()}:</strong> {p["probability"]:.2%} probability (uncertainty: {p["uncertainty"]:.4f})</li>\n')
                html.append('                </ul>\n')
            html.append('            </div>\n')

    html.append("        </section>\n")

    # ═══════════════════════════════════════════════════════════════════════
    # SECTION 6: CLINICAL TRIAL
    # ═══════════════════════════════════════════════════════════════════════
    if clinical_data:
        ps = clinical_data.get('protocolSection', {})
        ident = ps.get('identificationModule', {})
        desc = ps.get('descriptionModule', {})
        design = ps.get('designModule', {})
        status = ps.get('statusModule', {})
        outcomes = ps.get('outcomesModule', {})
        
        status_text = status.get('overallStatus', 'N/A')
        status_color = 'var(--status-success)' if 'ACTIVE' in status_text or 'RECRUITING' in status_text else ('var(--accent)' if 'COMPLETED' in status_text else 'var(--status-warning)')

        html.append(f"""
        <section id="clinical" class="section">
            <div class="section-title"><h2>CLINICAL TRIAL DATA</h2></div>

            <div class="brutal-box" style="border-top: 4px solid var(--accent);">
                <h3 style="margin-bottom: 2rem; color: var(--primary);">{ident.get('briefTitle', name)}</h3>
                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="stat-number" style="font-size: 2rem; color: var(--primary);">{ident.get('nctId', 'N/A')}</div>
                        <div class="stat-label">NCT ID</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number" style="font-size: 2rem; color: var(--text-secondary);">{', '.join(design.get('phases', ['N/A'])).replace('PHASE', 'Phase ')}</div>
                        <div class="stat-label">Phase</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number" style="font-size: 2rem; color: var(--primary-light);">{design.get('enrollmentInfo', {}).get('count', 'N/A')}</div>
                        <div class="stat-label">Enrollment</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number" style="font-size: 1.5rem; color: {status_color}; text-transform: capitalize;">{status_text.replace('_', ' ').lower()}</div>
                        <div class="stat-label">Status</div>
                    </div>
                </div>
            </div>

            <div class="brutal-box">
                <h3>Study Summary</h3>
                <p style="font-size: 1.05rem; line-height: 1.7;">{desc.get('briefSummary', 'No summary available.')}</p>
            </div>
""")
        primary_outcomes = outcomes.get('primaryOutcomes', [])
        if primary_outcomes:
            html.append("""
            <div class="brutal-box" style="border-left: 4px solid var(--primary-light);">
                <h3 style="color: var(--primary-light);">Primary Outcomes</h3>
                <ul style="list-style-type: none; padding-left: 0; margin-top: 1.5rem;">
""")
            for outcome in primary_outcomes:
                measure = outcome.get('measure', 'N/A')
                timeframe = outcome.get('timeFrame', 'N/A')
                html.append(f"""
                    <li style="margin-bottom: 1.5rem; padding-bottom: 1.5rem; border-bottom: 1px solid var(--border-light);">
                        <strong style="color: var(--text-primary); font-size: 1.05rem;">{measure}</strong><br>
                        <span style="font-size: 0.95rem; color: var(--text-muted); display: inline-block; margin-top: 0.5rem;">Time Frame: {timeframe}</span>
                    </li>
""")
            html.append("""
                </ul>
            </div>
""")

        html.append("        </section>\n")

    # ═══════════════════════════════════════════════════════════════════════
    # FOOTER
    # ═══════════════════════════════════════════════════════════════════════
    now = datetime.now().strftime('%B %d, %Y')
    html.append(f"""
    </main>

    <footer>
        <div class="container">
            <p style="font-family: 'Outfit', sans-serif; font-size: 1.25rem; font-weight: 500; margin-bottom: 1rem; color: var(--bg-surface);">
                © 2026 <strong style="color: var(--accent); font-weight: 700;">GATC Health Today</strong> | Analyst Report
            </p>
            <p style="font-size: 1.05rem; margin-top: 0.5rem; color: var(--border-strong);">{name} — {company}</p>
            <p style="margin-top: 2rem; font-size: 0.9rem; font-weight: 400; color: var(--text-muted);">
                Data Integration: FDA Approval (Approval Probability) · Molecule Target Activity (Target Affinity) · Molecule Toxicology (Toxicity Models)
            </p>
            <p style="margin-top: 0.5rem; font-size: 0.85rem; color: var(--text-muted); opacity: 0.7;">
                Generated {now} | For authorized research purposes only
            </p>
        </div>
    </footer>

    <script>
        // Toggle accordion
        function toggleAccordion(num) {{
            const content = document.getElementById('accordion-' + num);
            content.classList.toggle('active');
        }}
        // Smooth scroll for nav links
        document.querySelectorAll('nav a[href^="#"]').forEach(a => {{
            a.addEventListener('click', e => {{
                e.preventDefault();
                const target = document.querySelector(a.getAttribute('href'));
                if (target) target.scrollIntoView({{ behavior: 'smooth', block: 'start' }});
            }});
        }});
    </script>
</body>
</html>
""")

    return ''.join(html)


# ─── Main ────────────────────────────────────────────────────────────────────

def main():
    print("=" * 60)
    print("GENERATING HTML DRUG BENCHMARKING REPORTS")
    print("=" * 60)

    print("\nLoading data sources...")
    target_map = load_target_map()
    print(f"  Target map: {len(target_map)} ChEMBL IDs")

    molecule_target_activity = load_molecule_target_activity(target_map)
    print(f"  Molecule Target Activity: {len(molecule_target_activity)} keys loaded")

    molecule_toxicology = load_molecule_toxicology()
    print(f"  Molecule Toxicology: {len(molecule_toxicology)} compounds loaded")

    assets = load_assets()
    print(f"  Assets: {len(assets)} drugs to process")

    pathway_data_all = {}
    pathway_file = "antibody_pathways.json"
    if os.path.exists(pathway_file):
        with open(pathway_file, 'r') as f:
            pathway_data_all = json.load(f)
        print(f"  Pathways: {len(pathway_data_all)} antibody records loaded\n")
    else:
        print("  Pathways: None loaded\n")

    generated = 0
    for asset in assets:
        smi = asset['smiles']
        folder_name = asset['name'].replace(' ', '_').replace('/', '_')

        # Handle weird folder name for VistaGen
        if asset['name'].startswith('InChI='):
            folder_name = asset['name'][:80].replace('/', '_')

        asset_dir = os.path.join(BASE_DIR, folder_name)
        if not os.path.exists(asset_dir):
            # Try to find the folder
            for d in os.listdir(BASE_DIR):
                if d.startswith(asset['name'][:20].replace('/', '_').replace(' ', '_')):
                    asset_dir = os.path.join(BASE_DIR, d)
                    break

        os.makedirs(asset_dir, exist_ok=True)

        # Match data
        molecule_toxicology_key = find_by_inchi_prefix(molecule_toxicology, asset['inchi']) if not molecule_toxicology.get(smi) else smi
        asset_molecule_toxicology = molecule_toxicology.get(smi) or (molecule_toxicology.get(molecule_toxicology_key, {}) if molecule_toxicology_key else {})
        molecule_target_activity_key = find_by_inchi_prefix(molecule_target_activity, asset['inchi']) if not molecule_target_activity.get(smi) else smi
        asset_molecule_target_activity = molecule_target_activity.get(smi) or (molecule_target_activity.get(molecule_target_activity_key, []) if molecule_target_activity_key else [])

        print(f"--- {asset['name']} ({asset['company']}) ---")
        print(f"    Molecule Target Activity hits: {len(asset_molecule_target_activity)} | Molecule Toxicology data: {'Yes' if asset_molecule_toxicology else 'No'}")

        # Run side effect prediction
        side_effects = run_side_effect_prediction(smi)
        if side_effects:
            print(f"    Side Effects: {len(side_effects['predictions'])} predicted, risk {side_effects['risk_score']:.1f}/10")

        # Clinical Data
        clinical_data = load_clinical_data(asset['name'])
        if clinical_data:
            print(f"    Clinical Trial Data: Found")

        # Compute Bayesian scores
        bayesian_scores = compute_bayesian_scores(asset, asset_molecule_toxicology, asset_molecule_target_activity, clinical_data, side_effects)
        if bayesian_scores:
            print(f"    Bayesian: Grade {bayesian_scores['grade']} ({bayesian_scores['probability_pct']}) [Base: {bayesian_scores['base_rate']:.0%}]")

        asset_pathways = pathway_data_all.get(asset['name'])
        html_content = generate_html(asset, asset_molecule_toxicology, asset_molecule_target_activity, clinical_data, bayesian_scores, side_effects, asset_pathways)

        fpath = os.path.join(asset_dir, 'index.html')
        with open(fpath, 'w') as f:
            f.write(html_content)

        size_kb = len(html_content) / 1024
        print(f"    → {fpath} ({size_kb:.1f} KB)")
        generated += 1

    print(f"\n{'=' * 60}")
    print(f"COMPLETE: {generated} HTML reports generated")
    print(f"Output directory: {BASE_DIR}")
    print(f"{'=' * 60}")


if __name__ == "__main__":
    main()
