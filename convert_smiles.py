import csv
from rdkit import Chem

def convert_smiles_to_inchi():
    input_file = "extracted_smiles.txt"
    output_file = "extracted_inchi.txt"
    
    inchis = []
    
    with open(input_file, 'r') as f:
        smiles_list = [line.strip() for line in f if line.strip()]
        
    for smiles in smiles_list:
        try:
            mol = Chem.MolFromSmiles(smiles)
            if mol:
                inchi = Chem.MolToInchi(mol)
                if inchi:
                    inchis.append(inchi)
                else:
                    inchis.append("FAILED_CONVERSION")
            else:
                inchis.append("INVALID_SMILES")
        except Exception as e:
            inchis.append(f"ERROR: {e}")
            
    with open(output_file, 'w') as f:
        for inchi in inchis:
            f.write(inchi + "\n")
            
    print(f"Successfully converted {len(inchis)} SMILES to InChI.")
    print(f"Results saved to {output_file}")

if __name__ == "__main__":
    convert_smiles_to_inchi()
