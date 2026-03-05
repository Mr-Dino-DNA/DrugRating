
import xml.etree.ElementTree as ET

tree = ET.parse('/home/michael/SideEffectEstimator/DrugBank2023.xml')
root = tree.getroot()
ns = {'db': 'http://www.drugbank.ca'}

for drug in root.findall('db:drug', ns)[:5]:
    name = drug.find('db:name', ns).text
    print(f"Drug: {name}")
    ext_ids = drug.findall('db:external-identifiers/db:external-identifier', ns)
    for ext_id in ext_ids:
        res = ext_id.find('db:resource', ns).text
        ident = ext_id.find('db:identifier', ns).text
        print(f"  - {res}: {ident}")
