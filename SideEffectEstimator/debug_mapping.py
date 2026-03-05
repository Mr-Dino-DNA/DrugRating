from etl.loaders.database_loader import DatabaseLoader
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

conn = psycopg2.connect(
    host=os.getenv('DB_HOST', 'localhost'),
    database=os.getenv('DB_NAME', 'side_effect_estimator'),
    user=os.getenv('DB_USER', 'michael'),
    password=os.getenv('DB_PASSWORD')
)

target_names = [
    'Mast/stem cell growth factor receptor Kit',
    'Platelet-derived growth factor receptor beta',
    'Platelet-derived growth factor receptor alpha',
    'Tyrosine-protein kinase ABL1'
]

print(f"Querying for {len(target_names)} targets: {target_names}")

placeholders = ',' .join(['%s'] * len(target_names))
query = f"""
    SELECT t.target_name, COUNT(*)
    FROM target_side_effects tse
    JOIN targets t ON tse.target_id = t.target_id
    JOIN side_effects se ON tse.side_effect_id = se.side_effect_id
    WHERE t.target_name IN ({placeholders})
    GROUP BY t.target_name
"""

with conn.cursor() as cur:
    cur.execute(query, tuple(target_names))
    rows = cur.fetchall()
    print("\nResults:")
    for row in rows:
        print(f"Target: {row[0]} | Count: {row[1]}")

    if not rows:
        print("No matches found via Join.")
        
        # Check targets exist
        check_q = f"SELECT target_name FROM targets WHERE target_name IN ({placeholders})"
        cur.execute(check_q, tuple(target_names))
        found = [r[0] for r in cur.fetchall()]
        print(f"\nTargets found in DB: {found}")
        
        # Check TSE manual
        print("\nChecking TSE directly for 'Mast/stem cell growth factor receptor Kit'...")
        cur.execute("SELECT COUNT(*) FROM target_side_effects tse JOIN targets t ON tse.target_id = t.target_id WHERE t.target_name = 'Mast/stem cell growth factor receptor Kit'")
        print(f"Direct Count: {cur.fetchone()[0]}")

conn.close()
