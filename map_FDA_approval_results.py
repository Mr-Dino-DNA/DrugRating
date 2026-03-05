import json

def map_results():
    # Load JSON
    with open('star_lord_results_star_lord-instant.json', 'r') as f:
        data = json.load(f)
    
    # Create mapping of SMILES to (probability, prediction)
    smiles_to_pred = {}
    for result in data['results']['results']:
        smiles = result['smiles'].strip()
        smiles_to_pred[smiles] = (result['probability'], result['prediction'])

    mapped_lines = []
    with open('final_extracted_assets.txt', 'r') as f:
        lines = f.readlines()
        
    for i, line in enumerate(lines):
        line = line.strip()
        if not line:
            continue
            
        if i == 0:
            # Header
            mapped_lines.append(line + ",FDA Approval_Probability,FDA Approval_Prediction")
            continue
            
        # The line format is Company,Asset,InChI,SMILES
        # Since InChI can contain commas, we extract SMILES by taking the last part after comma
        parts = line.rsplit(',', 1)
        if len(parts) == 2:
            smiles = parts[1].strip()
            # Some rows don't have SMILES but have "CAR-T", "Monoclonal antibody", etc.
            # We match exactly if it's in the dict, otherwise check if we can find it
            if smiles in smiles_to_pred:
                prob, pred = smiles_to_pred[smiles]
                mapped_lines.append(f"{line},{prob},{pred}")
            else:
                # SMILES might have trailing spaces or something in the dict
                # Let's check if the SMILES ends with a space (as seen in some lines like line 18)
                mapped_lines.append(f"{line},,")
        else:
            mapped_lines.append(f"{line},,")

    with open('mapped_FDA_approval_assets.csv', 'w') as f:
        for m in mapped_lines:
            f.write(m + "\n")
            
    print("Done mapping!")

if __name__ == "__main__":
    map_results()
