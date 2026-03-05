import sqlite3
import os

db_path = 'chembl_36/chembl_36_sqlite/chembl_36.db'

if not os.path.exists(db_path):
    print(f"Error: Database not found at {db_path}")
    exit(1)

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

tables = ['activities', 'molecule_dictionary', 'target_dictionary', 'assays', 'molecule_hierarchy']

for table in tables:
    print(f"\n--- Schema for {table} ---")
    try:
        cursor.execute(f"PRAGMA table_info({table})")
        columns = cursor.fetchall()
        for col in columns:
            print(f"{col[1]} ({col[2]})")
    except Exception as e:
        print(f"Error reading table {table}: {e}")

conn.close()
