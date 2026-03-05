import re

companies = []
with open("extracted_companies.txt", "r") as f:
    for line in f:
        c = line.strip()
        if c: companies.append(c)

with open("Catalyst-Rich New Year-February 2026.pdf", "rb") as f:
    pass # we already extracted text to mentions.txt, let's just use mentors.txt text directly

with open("mentions.txt", "r") as f:
    text = f.read()

# Let's split by "--- MATCHES FOR"
sections = text.split("--- MATCHES FOR ")
for sec in sections[1:]:
    lines = sec.split('\n')
    company = lines[0].strip().replace("---", "").strip()
    
    # Ignore the huge table of contents block which usually starts with "Healthcare & Biotechnology Industry Update"
    best_paragraph = ""
    for p in sec.split('> '):
        p = p.strip()
        if not p or "Healthcare & Biotechnology Industry Update" in p or "Catalyst-Rich New Year" in p:
            continue
        # Check if the company name or base name is in the paragraph
        c_base = company.split()[0].lower()
        if c_base in p.lower():
            best_paragraph = p
            break
            
    if best_paragraph:
        print(f"\n======================\nCOMPANY: {company}")
        print(best_paragraph[:600] + "...")
