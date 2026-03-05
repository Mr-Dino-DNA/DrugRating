import pickle
import numpy as np
import warnings
from rdkit import Chem
from rdkit.Chem import AllChem

smiles = "CN1CCN(CC2=CC=C(C=C2)C(=O)NC2=CC=C(C)C(NC3=NC(=CS3)C3=CN=CC=C3)=C2)CC1" # Masitinib

print("Inspecting probabilities...")
model_path = 'ml/models/target_predictor.pkl'
names_path = 'ml/models/target_names.pkl'

with open(model_path, 'rb') as f:
    model = pickle.load(f)
with open(names_path, 'rb') as f:
    target_names = pickle.load(f)

# Compute fingerprint
mol = Chem.MolFromSmiles(smiles)
fp = AllChem.GetMorganFingerprintAsBitVect(mol, 2, 2048)
fp_binary = ''.join([str(int(x)) for x in fp])
X = np.array([[int(x) for x in fp_binary]], dtype=np.int8)

# Predict Proba
# MultiOutputClassifier predict_proba returns a list of (n_samples, 2) arrays
try:
    with warnings.catch_warnings():
        warnings.simplefilter("ignore")
        probs_list = model.predict_proba(X)
        
    print(f"Number of targets: {len(target_names)}")
    print(f"Number of prob arrays: {len(probs_list)}")
    
    # Store target -> prob map
    target_probs = {}
    for i, target in enumerate(target_names):
        # probs_list[i] is [ [prob_0, prob_1] ]
        # Sometimes if a class has only 0 or 1 in training, it might be different shape?
        # RF usually handles this.
        p_arr = probs_list[i]
        if p_arr.shape[1] == 2:
            prob_active = p_arr[0][1]
        else:
             # If only one class present in training split, probability is 1.0 or 0.0 deterministically?
             # Check classes_
             classes = model.estimators_[i].classes_
             if len(classes) == 1:
                # If only class 0 exists => prob 0
                prob_active = 0.0 if classes[0] == 0 else 1.0
             else:
                prob_active = 0.0 # Should not happen with RF usually
        
        target_probs[target] = prob_active

    # Check key targets
    check = ['Mast/stem cell growth factor receptor Kit', 'Platelet-derived growth factor receptor alpha']
    for c in check:
        if c in target_probs:
            print(f"Target: {c} | Probability: {target_probs[c]:.4f}")
        else:
            print(f"Target: {c} | NOT IN MODEL")

    # Print top 10 probabilities
    print("\nTop 10 Predictions:")
    sorted_targets = sorted(target_probs.items(), key=lambda x: x[1], reverse=True)
    for t, p in sorted_targets[:10]:
        print(f"{p:.4f}: {t}")

except Exception as e:
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()
