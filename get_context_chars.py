import fitz
import re
import csv
import json

def get_companies(filepath):
    companies = []
    with open(filepath, 'r') as f:
        for line in f:
            c = line.strip()
            if c:
                companies.append(c)
    return companies

def extract_text_from_pdf(pdf_path):
    doc = fitz.open(pdf_path)
    text = ""
    for page in doc:
        text += page.get_text("text") + " "
    return text

companies = get_companies("extracted_companies.txt")
pdf1_text = extract_text_from_pdf("Catalyst-Rich New Year-February 2026.pdf")
pdf2_text = extract_text_from_pdf("WB 1Q26 Catalyst Watch_WB PUBLISH.pdf")

all_text = pdf1_text + " " + pdf2_text
all_text = " ".join(all_text.split())

results = []

for c in companies:
    base_name = c.split()[0]
    
    # Let's find index of base_name in all_text
    matches = [m.start() for m in re.finditer(re.escape(base_name), all_text, re.IGNORECASE)]
    
    best_context = "NOT FOUND"
    for idx in matches:
        # Avoid things in the table of contents if possible
        start = max(0, idx - 50)
        end = min(len(all_text), idx + 300)
        context = all_text[start:end]
        
        if "Covered Companies Mentioned" not in context and "Catalyst-Rich New Year We have identified" not in context:
            best_context = all_text[idx:min(len(all_text), idx + 400)]
            break
            
    if best_context == "NOT FOUND" and matches:
         best_context = all_text[matches[0]:min(len(all_text), matches[0] + 400)]
    
    # Try to find an asset name in this context (e.g. UPPERCASE-NUMBER, UPPERCASE)
    asset = "Unknown"
    # let's look for common drug name patterns or just bold text if we had it, but we don't.
    # We will just print the context and also write it to a file.
    results.append(f"COMPANY: {c}\nCONTEXT: {best_context}\n")

with open("company_contexts.txt", "w") as f:
    f.write("\n\n".join(results))
