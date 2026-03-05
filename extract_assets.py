import csv
import json
import fitz
import re

def get_companies(filepath):
    companies = []
    with open(filepath, 'r') as f:
        for line in f:
            c = line.strip()
            if c:
                companies.append(c)
    return companies

def extract_text_from_pdf(pdf_path):
    try:
        doc = fitz.open(pdf_path)
        text = ""
        for page in doc:
            text += page.get_text("text") + "\n\n"
        return text
    except Exception as e:
        print(f"Error reading {pdf_path}: {e}")
        return ""

companies = get_companies("extracted_companies.txt")
pdf1_text = extract_text_from_pdf("Catalyst-Rich New Year-February 2026.pdf")
pdf2_text = extract_text_from_pdf("WB 1Q26 Catalyst Watch_WB PUBLISH.pdf")

all_text = pdf1_text + "\n\n" + pdf2_text

# Load CSV and map Company to Assets
company_assets_csv = {}
csv_file = "List of Pharmaceutical Companies & Their Assets - USA.csv"
try:
    with open(csv_file, 'r', encoding='utf-8-sig') as f:
        reader = csv.DictReader(f)
        for row in reader:
            company_col = row.get("Company Name", "").strip()
            asset = row.get("Asset", "").strip()
            if company_col and asset:
                # We do a loose match on company name
                for c in companies:
                    c_base = c.split()[0].lower()
                    if c_base in company_col.lower():
                        if c not in company_assets_csv:
                            company_assets_csv[c] = []
                        company_assets_csv[c].append(asset)
except Exception as e:
    print(f"Error reading CSV: {e}")

# Now find paragraphs mentioning the company and check which CSV asset is in it
found_assets = {}
missing_assets = []

paragraphs = [p.strip() for p in all_text.split('\n\n') if p.strip()]

for c in companies:
    c_base = c.split()[0].lower()
    c_paragraphs = []
    for p in paragraphs:
        if c_base in p.lower():
            c_paragraphs.append(p)
    
    asset_found = None
    if c in company_assets_csv:
        for asset in company_assets_csv[c]:
            # Loose match for the asset in paragraphs
            asset_base = asset.split()[0].lower() # simple first word of asset
            for p in c_paragraphs:
                if asset_base in p.lower() or asset.lower() in p.lower():
                    asset_found = asset
                    break
            if asset_found:
                break
    
    if asset_found:
        found_assets[c] = asset_found
    else:
        # We might not have found it in CSV, or no paragraph match
        # Let's try to heuristically find words like XXX-000
        possible_assets = []
        for p in c_paragraphs:
            words = re.findall(r'\b[A-Za-z]+-\d+\b|\b[A-Z]{2,}\d*\b', p)
            if words:
                 possible_assets.extend(words)
        
        if possible_assets:
            # just pick the most common or first that is not the company name
            for a in possible_assets:
                 if a.lower() != c_base and a.lower() not in ['buy', 'pt', 'phase', 'fda', 'ind']:
                     asset_found = a
                     break
        
        if asset_found:
             found_assets[c] = f"{asset_found} (Extracted from PDF, not matched in CSV)"
        else:
             found_assets[c] = "Not found"

for c, asset in found_assets.items():
    print(f"{c}: {asset}")

print("\nCompanies to Google:")
for c, asset in found_assets.items():
    if "Not found" in asset or "Extracted from PDF" in asset:
         print(f"- {c}: {asset}")
