#!/usr/bin/env python3
"""
Bayesian 5-Domain Scoring Model for Drug Benchmarking.
Maps computational data (Molecule Target Activity, Molecule Toxicology, FDA Approval) to domain scores.
"""
import sys
import math

# Domain weights (PK gets massive boost, others scaled down)
DOMAIN_WEIGHTS = {
    'pk': 0.40,   # Massive FDA Approval weight
    'tox': 0.20,  # SideEffects + Molecule Toxicology
    'adme': 0.10,
    'tol': 0.10,
    'eff': 0.20,
}

PRIOR_LOG_ODDS = -2.59  # 7% base rate


def compute_bayesian_scores(asset, molecule_toxicology_data, molecule_target_activity_data, clinical_data=None, side_effects=None):
    """Compute 5-domain Bayesian scores from computational data."""
    biologic = asset['smiles'] in ('Monoclonal antibody', 'CAR-T', 'Lipid Nanoparticle', 'Antibody', 'Gene therapy')
    if biologic:
        return None

    # Base rate mapping by condition (Industry LOA)
    BASE_RATES = {
        'Neovascular Age-Related Macular Degeneration': 0.16,
        'Generalized Anxiety Disorder': 0.07,
        'Anxiety Generalized': 0.07,
        'Treatment Resistant Depression': 0.07,
        'Social Anxiety Disorder': 0.07,
        'Focal Epilepsy': 0.06,
        'Pulmonary Artery Hypertension': 0.10,
        'Chronic Kidney Disease Requiring Chronic Dialysis': 0.15,
        'Chronic Kidney Disease': 0.15,
        'Ataxia Telangiectasia': 0.05,
        'Wilson Disease': 0.06,
        'Large B-cell Lymphoma': 0.15,
        'Secondary Progressive Multiple Sclerosis': 0.06,
        'Retinitis Pigmentosa': 0.08,
        'Grade 2 and 3 Late Xerostomia Caused by Radiotherapy for Cancers of the Upper Aerodigestive Tract, Excluding the Parotid Glands': 0.10,
        'Alpha 1-Antitrypsin Deficiency': 0.12,
        'Thyroid Eye Disease': 0.10,
        'Amyotrophic Lateral Sclerosis': 0.07,
        'Overweight': 0.20,
        'Type 2 Diabetes': 0.20,
        'Obesity': 0.20,
        'Severe Asthma': 0.12,
        'Treatment-resistant Schizophrenia': 0.05,
    }
    
    # Default to 10% base rate if no matching clinical data condition found
    base_rate = 0.10
    
    if clinical_data:
        conditions = clinical_data.get('protocolSection', {}).get('conditionsModule', {}).get('conditions', [])
        for c in conditions:
            if c in BASE_RATES:
                base_rate = BASE_RATES[c]
                break

    # Convert probability to log-odds
    prior_log_odds = math.log(base_rate / (1.0 - base_rate))

    # Prep molecule_target_activity stats
    all_hits = molecule_target_activity_data if molecule_target_activity_data else []
    unique = list({h['target_id']: h for h in all_hits}.values())
    
    # NEW THRESHOLD: Molecule Target Activity targets must have > 0.70 probability to be considered 'active'
    active = [h for h in unique if float(h.get('active_prob', 0)) > 0.70]
    total = len(unique)
    active_count = len(active)
    selectivity = active_count / total if total > 0 else 0.5

    # FDA Approval prob
    try:
        sl_prob = float(asset['FDA_approval_prob'])
    except (ValueError, TypeError):
        sl_prob = 0.5

    # Molecule Toxicology stats
    molecule_toxicology_organs = []
    if molecule_toxicology_data:
        for organ in ['renal', 'cardio', 'hepa', 'gen']:
            if organ in molecule_toxicology_data:
                molecule_toxicology_organs.append(molecule_toxicology_data[organ])

    flagged_count = sum(1 for v in molecule_toxicology_organs if v.get('decision') == 'flag')
    avg_tox_prob = sum(v['probability'] for v in molecule_toxicology_organs) / len(molecule_toxicology_organs) if molecule_toxicology_organs else 0.5
    avg_uncertainty = sum(v['uncertainty'] for v in molecule_toxicology_organs) / len(molecule_toxicology_organs) if molecule_toxicology_organs else 0.5

    # Top target strength
    top_probs = sorted([float(h.get('active_prob', 0)) for h in active], reverse=True)[:5]
    avg_top_activity = sum(top_probs) / len(top_probs) if top_probs else 0
    max_target_activity = top_probs[0] if top_probs else 0

    # ─── Domain I: PK Feasibility (FDA Approval-based) ───
    # A 90% FDA Approval prob gives a massive +8.00 shift.
    # A 10% FDA Approval prob gives a severe -8.00 penalty.
    pk_score = (sl_prob - 0.5) * 20.0  # EXPANDED RANGE: -10.00 to +10.00
    pk_score = max(-10.00, min(10.00, pk_score))

    # ─── Domain II: Toxicology (Molecule Toxicology + SideEffectEstimator) ───
    # Combine Molecule Toxicology organ flags with SideEffectEstimator risk scores
    se_risk = 0.5
    se_count = 0
    if side_effects:
        se_risk = side_effects.get('risk_score', 0) / 10.0  # Normalize to 0-1
        se_count = len(side_effects.get('predictions', []))

    # Heavy penalties for high toxicity or high number of side effects
    tox_score = -0.50 * flagged_count - (0.02 * se_count) + (0.5 - ((avg_tox_prob + se_risk) / 2)) * 1.5
    tox_score = max(-1.50, min(1.00, tox_score))

    # ─── Domain III: ADME Profile (selectivity-based) ───
    # Moderate selectivity is ideal
    if selectivity == 0:
        adme_score = 0.00  # Unknown / No targets
    elif selectivity < 0.1:
        adme_score = 0.80  # Very selective - good ADME
    elif selectivity < 0.3:
        adme_score = 0.40  # Moderate
    elif selectivity < 0.5:
        adme_score = -0.30  # Broad
    else:
        adme_score = -0.80  # Very broad - ADME concern
    adme_score = max(-1.00, min(1.00, adme_score))

    # ─── Domain IV: Tolerability (uncertainty + tox margins) ───
    tol_score = (1.0 - avg_uncertainty) * 0.8 - flagged_count * 0.30
    tol_score = max(-1.00, min(0.80, tol_score))

    # ─── Domain V: Efficacy/MOA Plausibility (target activity) ───
    if max_target_activity > 0.95:
        eff_score = 1.00  # Efficacy Bonus for hitting a definitive intended target
    elif avg_top_activity > 0.80:
        eff_score = 0.50
    elif avg_top_activity > 0.50:
        eff_score = 0.20
    else:
        eff_score = -0.50
    eff_score = max(-1.00, min(1.20, eff_score))

    # ─── Compute contributions and total ───
    domains = [
        {'name': 'PK Feasibility', 'key': 'pk', 'roman': 'I', 'weight': DOMAIN_WEIGHTS['pk'],
         'score': round(pk_score, 3), 'color': 'var(--primary)',
         'rationale': f'Based on FDA Approval approval probability ({sl_prob:.4f})'},
        {'name': 'Toxicology', 'key': 'tox', 'roman': 'II', 'weight': DOMAIN_WEIGHTS['tox'],
         'score': round(tox_score, 3), 'color': 'var(--primary-light)',
         'rationale': f'{flagged_count} organ(s) flagged, {se_count} valid side effects (Risk {se_risk*10:.1f}/10)'},
        {'name': 'ADME Profile', 'key': 'adme', 'roman': 'III', 'weight': DOMAIN_WEIGHTS['adme'],
         'score': round(adme_score, 3), 'color': 'var(--text-secondary)',
         'rationale': f'Selectivity index {selectivity:.2%} ({active_count}/{total} targets > 0.70)'},
        {'name': 'Tolerability', 'key': 'tol', 'roman': 'IV', 'weight': DOMAIN_WEIGHTS['tol'],
         'score': round(tol_score, 3), 'color': 'var(--status-neutral)',
         'rationale': f'Avg Molecule Toxicology uncertainty {avg_uncertainty:.3f}, {flagged_count} flagged organ(s)'},
        {'name': 'Efficacy / MOA', 'key': 'eff', 'roman': 'V', 'weight': DOMAIN_WEIGHTS['eff'],
         'score': round(eff_score, 3), 'color': 'var(--accent)',
         'rationale': f'Max intended target affinity {max_target_activity:.4f}'},
    ]

    for d in domains:
        d['contribution'] = round(d['score'] * d['weight'], 4)

    total_adj = sum(d['contribution'] for d in domains)
    posterior = prior_log_odds + total_adj
    probability = 1.0 / (1.0 + math.exp(-posterior))

    # Grade based on ABSOLUTE final probability
    # Users expect an A to be a highly likely drug, not just "better than 5%"
    if probability >= 0.50:   # > 50% chance of approval
        grade = 'A'
    elif probability >= 0.30: # > 30%
        grade = 'B'
    elif probability >= 0.15: # > 15%
        grade = 'C'
    elif probability >= 0.05: # > 5%
        grade = 'D'
    else:                     # < 5%
        grade = 'F'

    grade_colors = {'A': 'var(--status-success)', 'B': 'var(--primary-light)', 'C': 'var(--status-warning)', 'D': 'var(--status-danger)', 'F': 'var(--status-neutral)'}

    return {
        'domains': domains,
        'total_adjustment': round(total_adj, 4),
        'prior': prior_log_odds,
        'posterior': round(posterior, 4),
        'probability': round(probability, 4),
        'probability_pct': f'{probability:.1%}',
        'grade': grade,
        'grade_color': grade_colors.get(grade, 'var(--yellow)'),
        'base_rate': base_rate,
        'multiplier': round(probability / base_rate, 2) if base_rate > 0 else 0,
    }


def run_side_effect_prediction(smiles):
    """Run SideEffectEstimator for a SMILES string. Returns dict or None."""
    biologic_types = ('Monoclonal antibody', 'CAR-T', 'Lipid Nanoparticle', 'Antibody', 'Gene therapy')
    if smiles in biologic_types:
        return None

    try:
        sys.path.insert(0, '/home/michael/SideEffectEstimator')
        from predict.side_effect_predictor import SideEffectPredictor
        predictor = SideEffectPredictor()
        result = predictor.predict_from_smiles(smiles)
        
        # Take up to 20 predictions, but ONLY if probability is > 0.05
        all_preds = result.get('predictions', [])
        filtered_preds = [p for p in all_preds if float(p.get('probability', 0)) >= 0.05]
        top_preds = filtered_preds[:20]
        
        # Re-calc a pseudo risk score based on filtered items if it originally returned 20
        risk_score = result.get('overall_risk_score', 0)
        if len(filtered_preds) < len(all_preds):
            risk_score = min(10.0, risk_score * (len(filtered_preds) / max(1, len(all_preds))))

        return {
            'method': result.get('method', 'unknown'),
            'risk_score': risk_score,
            'confidence': result.get('confidence', 0),
            'similar_drugs': result.get('similar_drugs', [])[:5],
            'predictions': top_preds,
        }
    except Exception as e:
        print(f"    ⚠️ Side Effect prediction failed: {e}")
        return None
