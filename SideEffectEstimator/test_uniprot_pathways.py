
import requests
import json

url = "https://rest.uniprot.org/uniprotkb/accessions"
params = {
    "accessions": "P00533,P04150",
    "fields": "accession,cc_pathway,xref_reactome"
}
print(f"Fetching {url} with params...")
try:
    resp = requests.get(url, params=params, timeout=10)
    print(f"Status: {resp.status_code}")
    if resp.status_code == 200:
        data = resp.json()
        print(json.dumps(data, indent=2))
    else:
        print(resp.text[:500])
except Exception as e:
    print(f"Error: {e}")
