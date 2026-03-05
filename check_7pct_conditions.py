import json
import sys
sys.path.insert(0, '/home/michael/FDA Approval')
from generate_html_reports import load_assets, load_clinical_data

assets = load_assets()
drugs_to_check = ['EMP-01', 'CYB003', 'CYB004', 'fasedienol', 'psilocybin', 'Ibudilast', 'lysergide']

for asset in assets:
    if asset['name'] in drugs_to_check:
        clinical_data = load_clinical_data(asset['name'])
        if clinical_data:
            conditions = clinical_data.get('protocolSection', {}).get('conditionsModule', {}).get('conditions', [])
            print(f"{asset['name']}: {conditions}")
        else:
            print(f"{asset['name']}: NO CLINICAL DATA FOUND")
