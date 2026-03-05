
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

with conn.cursor() as cur:
    print("Checking for 'e coli' or 'Escherichia' in side_effects table...")
    cur.execute("""
        SELECT side_effect_id, side_effect_name 
        FROM side_effects 
        WHERE side_effect_name ILIKE '%coli%' OR side_effect_name ILIKE '%Escherichia%'
    """)
    rows = cur.fetchall()
    print(f"Found {len(rows)} matches:")
    for row in rows:
        print(f"ID: {row[0]}, Name: {row[1]}")

    print("\nChecking for other potential organism contaminants (e.g., 'Staphylococcus')...")
    cur.execute("""
        SELECT side_effect_id, side_effect_name 
        FROM side_effects 
        WHERE side_effect_name ILIKE '%Staphylococcus%'
    """)
    rows = cur.fetchall()
    for row in rows:
        print(f"ID: {row[0]}, Name: {row[1]}")

conn.close()
