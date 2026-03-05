import fitz
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

results = {}

for c in companies:
    base_name = c.split()[0]
    idx = all_text.find(base_name)
    if idx != -1:
        # Extract context around the first mention
        start = max(0, idx - 50)
        end = min(len(all_text), idx + 500)
        context = all_text[start:end].replace('\n', ' ')
        results[c] = context
    else:
        results[c] = "NOT FOUND"

print(json.dumps(results, indent=2))
