
import csv

filename = 'OnSIDES/csv/vocab_meddra_adverse_effect.csv'
print(f"Searching {filename}...")

try:
    with open(filename, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        header = next(reader)
        print(f"Header: {header}")
        
        found = False
        for row in reader:
            if any("Escherichia" in cell for cell in row):
                print(f"Match: {row}")
                found = True
        
        if not found:
            print("No matches for 'Escherichia' found in file content.")

except FileNotFoundError:
    print(f"File not found: {filename}")
except Exception as e:
    print(f"Error: {e}")
