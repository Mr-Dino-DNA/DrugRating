import glob, json, os

files = glob.glob("/home/michael/FDA Approval/Source_Docs/*Phase*.json")
res = {}
for f in files:
    try:
        data = json.load(open(f))
        conds = data.get("protocolSection", {}).get("conditionsModule", {}).get("conditions", [])
        name = os.path.basename(f)
        res[name] = conds
        print(f"{name}: {conds}")
    except Exception as e:
        print(f"Error reading {f}: {e}")
