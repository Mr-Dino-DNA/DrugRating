import csv
import json

companies_to_assets = {
    "AtaiBeckley NV": "EMP-01",
    "Cybin Inc": "CYB004",
    "Tiziana Life Sciences Ltd": "foralumab",
    "Unicycive Therapeutics Inc": "OLC",
    "VistaGen Therapeutics Inc": "fasedienol",
    "XOMA Royalty Corp": "Seralutinib",
    "Allogene": "cema-cel",
    "Beam Therapeutics": "BEAM-302",
    "Compass Therapeutics": "tovecimig",
    "Ocular Therapeutix": "Axpaxli",
    "Upstream Bio": "verekitug",
    "Viridian Therapeutics": "elegrobart",
    "Xenon Pharmaceuticals": "azetukalner",
    "Zealand Pharma": "petrelintide",
    # The ones we couldn't easily grab from a single line in pdf text, let's leave blank to be searched in CSV
    "MeiraGTx Holdings plc": None,
    "Medicimolecule_inhibitor Inc": None,
    "Monopar Therapeutics Inc": None,
    "Newron Pharmaceuticals SpA": None,
    "Ocugen Inc": None,
    "Quince Therapeutics Inc": None
}

# Now we will read the CSV to find SMILES and InChI for these assets
csv_file = "List of Pharmaceutical Companies & Their Assets - USA.csv"

# Pre-load all assets from CSV
csv_data = []
try:
    with open(csv_file, 'r', encoding='utf-8-sig') as f:
        reader = csv.DictReader(f)
        for row in reader:
             csv_data.append(row)
except Exception as e:
    print(f"Error reading CSV: {e}")

final_output = []

for c, asset in companies_to_assets.items():
    c_base = c.split()[0].lower()
    
    found_in_csv = False
    best_row = None
    
    # Try finding by Company Name first
    company_rows = [r for r in csv_data if c_base in r.get("Company Name", "").lower()]
    
    if company_rows:
        if asset:
             # Match by asset
             asset_base = asset.lower().split()[0]
             for r in company_rows:
                 if asset_base in r.get("Asset", "").lower():
                     best_row = r
                     break
             # If asset not matched but company is, let's just pick the first asset for that company
             if not best_row:
                 best_row = company_rows[0]
        else:
             best_row = company_rows[0]
    else:
        # If company not found, try finding by asset name across all companies
        if asset:
             asset_base = asset.lower().split()[0]
             for r in csv_data:
                 if asset_base in r.get("Asset", "").lower():
                     best_row = r
                     break
    
    if best_row:
         actual_asset = best_row.get("Asset", asset if asset else "Unknown")
         final_output.append({"Company": c, "Asset": actual_asset, "Found in CSV": "Yes"})
    else:
         final_output.append({"Company": c, "Asset": asset if asset else "Unknown", "Found in CSV": "No"})

print("FINAL SUMMARY OF COMPANY ASSETS:")
print(json.dumps(final_output, indent=2))

with open("final_extracted_assets.txt", "w") as f:
     for item in final_output:
         status = "Found in CSV" if item['Found in CSV'] == "Yes" else "To Google (Missing from CSV)"
         f.write(f"{item['Company']} -> Asset: {item['Asset']} | Status: {status}\n")

print("\nWrote results to final_extracted_assets.txt!")
