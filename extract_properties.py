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
        text += page.get_text("text") + "\n\n"
    return text

companies = get_companies("extracted_companies.txt")
pdf1_text = extract_text_from_pdf("Catalyst-Rich New Year-February 2026.pdf")
pdf2_text = extract_text_from_pdf("WB 1Q26 Catalyst Watch_WB PUBLISH.pdf")

all_text = pdf1_text + "\n\n" + pdf2_text

# Let's simple split into pseudo-paragraphs (split by double newline)
paragraphs = [p.strip() for p in all_text.split('\n\n') if p.strip()]

company_mentions = {c: [] for c in companies}

for p in paragraphs:
    for c in companies:
        # Simplistic matching: try matching 'Company' or 'Company Inc'
        # To avoid being too strict, we'll try to match word boundaries for the first word at least
        first_word = c.split()[0]
        # Just use simple lowercaser content search for the base name
        base_name = c.lower().replace('.', '').replace(',', '')
        p_lower = p.lower()
        if base_name in p_lower:
            # Let's clean the paragraph formatting
            p_clean = " ".join(p.split())
            company_mentions[c].append(p_clean)

# Also let's output a summary for the LLM to read
for c, mentions in company_mentions.items():
    print(f"--- MATCHES FOR {c} ---")
    if mentions:
        for m in set(mentions):
            print(f"> {m}")
    else:
        print("> NO MATCHES FOUND")
    print("\n")
