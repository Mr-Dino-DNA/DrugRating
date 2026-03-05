from predict.side_effect_predictor import SideEffectPredictor
from rdkit import Chem
from rdkit.Chem import AllChem
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

smiles = "CN1CCN(CC2=CC=C(C=C2)C(=O)NC2=CC=C(C)C(NC3=NC(=CS3)C3=CN=CC=C3)=C2)CC1" # Masitinib

print("==================================================")
print("FINAL MASITINIB VERIFICATION (High Detail)")
print("==================================================")

predictor = SideEffectPredictor(min_confidence=0.1) # Ensure low threshold

# 1. Prediction
print("\n[1] Running ML Prediction...")
mol = Chem.MolFromSmiles(smiles)
fp = AllChem.GetMorganFingerprintAsBitVect(mol, 2, 2048)

# Force ML prediction
predictions = predictor._predict_from_ml_model(smiles, fp)
print(f"Found {len(predictions)} predicted side effects via ML path.")

# Extract targets
targets = set()
for p in predictions:
    mech = p.get('mechanism', '')
    if "Predicted binding to:" in mech:
        t_list = mech.replace("Predicted binding to:", "").split(",")
        for t in t_list:
            targets.add(t.strip())

print(f"\n[2] Predicted Targets ({len(targets)} total):")
sorted_targets = sorted(list(targets))
for t in sorted_targets[:20]: # Show top 20
    print(f"- {t}")
if len(sorted_targets) > 20:
    print(f"... and {len(sorted_targets)-20} more.")

check_targets = ['Mast/stem cell growth factor receptor Kit', 'Platelet-derived growth factor receptor alpha', 'Platelet-derived growth factor receptor beta']
print("\n[3] Validation of Key Kinases:")
for ct in check_targets:
    if any(ct in t for t in targets) or ct in targets:
        print(f"✅ Successfully predicted {ct}")
    else:
        print(f"❌ Failed to predict {ct}")

# 4. Check DB for Ground Truth (did ChEMBL have it?)
print("\n[4] Checking Database for Known Masitinib Targets (Ground Truth)...")
conn = psycopg2.connect(
    host=os.getenv('DB_HOST', 'localhost'),
    database=os.getenv('DB_NAME', 'side_effect_estimator'),
    user=os.getenv('DB_USER', 'michael'),
    password=os.getenv('DB_PASSWORD')
)
with conn.cursor() as cur:
    cur.execute("""
        SELECT t.target_name, dt.binding_affinity_value, dt.binding_affinity_type, dt.source
        FROM drugs d
        JOIN drug_targets dt ON d.drug_id = dt.drug_id
        JOIN targets t ON dt.target_id = t.target_id
        WHERE d.drug_name = 'Masitinib'
        ORDER BY dt.source, dt.binding_affinity_value ASC
    """)
    rows = cur.fetchall()
    if rows:
        print(f"Found {len(rows)} known targets in DB:")
        for r in rows:
            val = f"{r[1]} {r[2]}" if r[1] else "Active"
            print(f"- {r[0]} ({val}) [{r[3]}]")
    else:
        print("Masitinib not found in DB with targets (It might be under a different name or ID).")

conn.close()
