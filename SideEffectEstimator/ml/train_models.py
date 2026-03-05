import os
import psycopg2
import pickle
import numpy as np
import pandas as pd
from rdkit import Chem
from rdkit.Chem import AllChem
from sklearn.ensemble import RandomForestClassifier
from sklearn.multioutput import MultiOutputClassifier
from sklearn.model_selection import train_test_split
from dotenv import load_dotenv

# Ensure models directory exists
os.makedirs('ml/models', exist_ok=True)

def fetch_data():
    print("Fetching training data from database...")
    load_dotenv()
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        database=os.getenv('DB_NAME', 'side_effect_estimator'),
        user=os.getenv('DB_USER', 'michael'),
        password=os.getenv('DB_PASSWORD')
    )
    
    # Fetch drugs with fingerprints
    query_drugs = """
        SELECT drug_id, fingerprint_morgan2048 
        FROM drugs 
        WHERE fingerprint_morgan2048 IS NOT NULL
    """
    df_drugs = pd.read_sql(query_drugs, conn)
    
    # Process fingerprints
    # Fingerprints are stored as 'bit' strings (e.g. '00101...')
    # Convert to numpy array of 0/1
    print(f"Processing {len(df_drugs)} drug fingerprints...")
    
    # Helper to convert bit string to list of ints
    def bit_str_to_array(s):
        return np.array([int(c) for c in s], dtype=np.int8)
    
    # Apply conversion (this might be slow for 4000 drugs, but acceptable)
    X = np.stack(df_drugs['fingerprint_morgan2048'].apply(bit_str_to_array).values)
    drug_ids = df_drugs['drug_id'].values
    map_drug_idx = {did: i for i, did in enumerate(drug_ids)}
    
    # Fetch Targets (for Target Prediction Model)
    print("Fetching target interactions...")
    query_targets = """
        SELECT dt.drug_id, t.target_name 
        FROM drug_targets dt
        JOIN targets t ON dt.target_id = t.target_id
    """
    df_targets = pd.read_sql(query_targets, conn)
    
    # Filter targets by minimum frequency (Higher Detail)
    target_counts = df_targets['target_name'].value_counts()
    min_freq = 10  # Reduced from 20 to capture more niche targets
    top_targets = target_counts[target_counts >= min_freq].index.tolist()
    print(f"Training on {len(top_targets)} targets (min frequency: {min_freq})")
    
    # Check if key targets are included
    for key_target in ['Mast/stem cell growth factor receptor Kit', 'Platelet-derived growth factor receptor alpha']:
        if key_target in top_targets:
            print(f"✓ Included key target: {key_target}")
        else:
            freq = target_counts.get(key_target, 0)
            print(f"⚠ Missed key target: {key_target} (freq: {freq})")
    
    # Create Target Label Matrix (Multi-label)
    y_targets = np.zeros((len(drug_ids), len(top_targets)))
    
    for _, row in df_targets.iterrows():
        if row['drug_id'] in map_drug_idx and row['target_name'] in top_targets:
            idx = map_drug_idx[row['drug_id']]
            col = top_targets.index(row['target_name'])
            y_targets[idx, col] = 1
            
    conn.close()
    
    return X, y_targets, top_targets

def train_models():
    X, y_targets, target_names = fetch_data()
    
    if len(X) == 0:
        print("Error: No data found in database!")
        return

    print(f"Training Data Shape: X={X.shape}, y={y_targets.shape}")
    
    # Train/Test Split
    X_train, X_test, y_train, y_test = train_test_split(X, y_targets, test_size=0.2, random_state=42)
    
    # Train Random Forest (High Capacity)
    print(f"Training Random Forest (1000 trees) for Target Prediction on {len(target_names)} targets...")
    # Use native multi-output support of RandomForestClassifier (faster than MultiOutputClassifier)
    model = RandomForestClassifier(n_estimators=1000, n_jobs=-1, random_state=42)
    model.fit(X_train, y_train)
    
    # Evaluate
    score = model.score(X_test, y_test)
    print(f"Model Accuracy (Subset Accuracy): {score:.4f}")
    
    # Save Model and Metadata
    print("Saving models...")
    with open('ml/models/target_predictor.pkl', 'wb') as f:
        pickle.dump(model, f)
        
    with open('ml/models/target_names.pkl', 'wb') as f:
        pickle.dump(target_names, f)
        
    print("✓ Training complete!")

if __name__ == "__main__":
    train_models()
