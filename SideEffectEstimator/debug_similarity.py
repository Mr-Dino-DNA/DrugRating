import sys
import os
import psycopg2
from rdkit import Chem
from rdkit.Chem import AllChem, DataStructs
from dotenv import load_dotenv

def analyze_drug(smiles):
    print(f"Analyzing SMILES: {smiles}")
    
    # Validation
    mol = Chem.MolFromSmiles(smiles)
    if not mol:
        print("Invalid SMILES")
        return

    # Fingerprint
    fp = AllChem.GetMorganFingerprintAsBitVect(mol, 2, 2048)
    
    load_dotenv()
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        database=os.getenv('DB_NAME', 'side_effect_estimator'),
        user=os.getenv('DB_USER', 'michael'),
        password=os.getenv('DB_PASSWORD')
    )
    
    cur = conn.cursor()
    cur.execute("SELECT drug_name, smiles, fingerprint_morgan2048 FROM drugs WHERE fingerprint_morgan2048 IS NOT NULL")
    
    rows = cur.fetchall()
    print(f"Checking against {len(rows)} drugs in database...")
    
    best_sim = 0
    best_drug = None
    
    for name, db_smiles, fp_str in rows:
        db_fp = DataStructs.ExplicitBitVect(2048)
        # Assuming fp_str is '010101...' string from `bit` type column
        # Depending on how psycopg2 returns BIT type, might need handling
        
        # Psycopg2 usually returns BIT as string of 1s and 0s
        if fp_str:
            try:
                # Create proper bit vector
                # This is the potentially slow part in python loop, but okay for debug
                # Update: RDKit ExplicitBitVect.FromBitString(fp_str) exists? No.
                # Manual construction:
                for i, bit in enumerate(fp_str):
                    if bit == '1':
                        db_fp.SetBit(i)
                
                sim = DataStructs.TanimotoSimilarity(fp, db_fp)
                if sim > best_sim:
                    best_sim = sim
                    best_drug = name
            except Exception as e:
                print(f"Error processing {name}: {e}")
                break

    print(f"Most similar drug: {best_drug} with similarity {best_sim:.4f}")
    if best_sim < 0.7:
        print("Similarity is below default threshold (0.7).")
    
    conn.close()

if __name__ == "__main__":
    analyze_drug("CN1CCN(CC2=CC=C(C=C2)C(=O)NC2=CC=C(C)C(NC3=NC(=CS3)C3=CN=CC=C3)=C2)CC1")
