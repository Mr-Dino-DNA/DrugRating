import requests
import json
import os

base_url = "https://api.platform.opentargets.org/api/v4/graphql"

def get_ensembl_id(symbol):
    search_query = """
    query searchTarget($queryString: String!) {
      search(queryString: $queryString, entityNames: ["target"]) {
        hits {
          id
          name
        }
      }
    }
    """
    r_search = requests.post(base_url, json={"query": search_query, "variables": {"queryString": symbol}})
    data = r_search.json()
    hits = data.get("data", {}).get("search", {}).get("hits", [])
    if not hits:
        return None
    # Filter to exact or very close matches first
    for hit in hits:
        if hit["id"].startswith("ENSG"):
            return hit["id"]
    return hits[0]["id"] if hits else None

def get_pathways(ensembl_id):
    query = """
    query targetPathways($ensemblId: String!) {
      target(ensemblId: $ensemblId) {
        pathways {
          pathwayId
          pathway
          topLevelTerm
        }
      }
    }
    """
    r_pathways = requests.post(base_url, json={"query": query, "variables": {"ensemblId": ensembl_id}})
    target_data = r_pathways.json().get("data", {}).get("target", {})
    if not target_data or "pathways" not in target_data:
        return []
    return target_data["pathways"]

drugs_targets = {
    'Foralumab': ['CD3E'],
    'cema-cel': ['CD19'],
    'BEAM-302': ['SERPINA1'],
    'tovecimig': ['DLL4', 'VEGFA'],
    'Verekitug': ['TSLP'],
    'elegrobart': ['IGF1R'],
    'AAV2-hAQP1': ['AQP1'],
    'OCU400': ['NR2E3']
}

pathway_data = {}

for drug, symbols in drugs_targets.items():
    print(f"Fetching for {drug}...")
    drug_pathways = []
    seen = set()
    for symbol in symbols:
        ensembl_id = get_ensembl_id(symbol)
        if ensembl_id:
            pathways = get_pathways(ensembl_id)
            for p in pathways:
                if not p: continue
                pid = p['pathwayId']
                if pid not in seen:
                    seen.add(pid)
                    drug_pathways.append({
                        'target': symbol,
                        'pathwayId': pid,
                        'pathway': p.get('pathway', ''),
                        'topLevelTerm': p.get('topLevelTerm', '')
                    })
    pathway_data[drug] = drug_pathways

with open("antibody_pathways.json", "w") as f:
    json.dump(pathway_data, f, indent=2)

print("Saved to antibody_pathways.json")
