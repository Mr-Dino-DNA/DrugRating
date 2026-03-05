import xml.etree.ElementTree as ET
import psycopg2

def parse_drugbank_xml(xml_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    
    ns = {'db': 'http://www.drugbank.ca'}
    
    drugs = []
    for drug in root.findall('db:drug', ns):
        drug_id = drug.find('db:drugbank-id[@primary="true"]', ns).text
        name = drug.find('db:name', ns).text
        
        # Structure
        smiles = drug.find('.//db:property[db:kind="SMILES"]/db:value', ns)
        smiles = smiles.text if smiles is not None else None
        
        # Targets
        targets = []
        for target in drug.findall('.//db:target', ns):
            target_id = target.find('db:id', ns).text
            target_name = target.find('db:name', ns).text
            polypeptide = target.find('.//db:polypeptide', ns)
            uniprot_id = polypeptide.get('id') if polypeptide is not None else None
            
            # Actions (agonist, antagonist, etc.)
            actions = [a.text for a in target.findall('.//db:action', ns)]
            
            targets.append({
                'target_id': target_id,
                'target_name': target_name,
                'uniprot_id': uniprot_id,
                'actions': actions
            })
        
        # Dosages
        dosages = []
        for dosage in drug.findall('.//db:dosage', ns):
            form = dosage.find('db:form', ns)
            route = dosage.find('db:route', ns)
            strength = dosage.find('db:strength', ns)
            dosages.append({
                'form': form.text if form is not None else None,
                'route': route.text if route is not None else None,
                'strength': strength.text if strength is not None else None
            })
        
        drugs.append({
            'drug_id': drug_id,
            'name': name,
            'smiles': smiles,
            'targets': targets,
            'dosages': dosages
        })
    
    return drugs

### 2. **SIDER** (Side Effects Resource)
#*What you get:** Comprehensive side effect data

#**Access:**
#- Download: http://sideeffects.embl.de/download/
#- Files needed: `meddra_all_se.tsv`, `meddra_freq.tsv`

#**Format:**
#```
#drug_id    side_effect_name    meddra_concept_id    side_effect_type
#DB00001    Nausea             C0027497             ...