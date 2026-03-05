import json
import sys
sys.path.insert(0, '/home/michael/FDA Approval')
from generate_html_reports import load_assets

assets = load_assets()
for asset in assets:
    if asset['name'] in ['EMP-01', 'psilocybin', 'CYB003']:
        print(f"Drug: {asset['name']}")
        print(f"  Company: {asset['company']}")
        print(f"  SMILES: {asset['smiles']}")
        print(f"  InChI:  {asset['inchi']}\n")
