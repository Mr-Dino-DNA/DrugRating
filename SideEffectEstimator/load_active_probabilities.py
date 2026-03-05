#!/usr/bin/env python3
"""
Load active probabilities into database.
"""

import os
import sys
import psycopg2
from dotenv import load_dotenv

# Add parent to path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from etl.parsers.active_probability_parser import ActiveProbabilityParser
from etl.loaders.database_loader import DatabaseLoader

def main():
    load_dotenv()
    
    csv_path = os.getenv('ACTIVE_PROBABILITY_CSV_PATH')
    if not csv_path or not os.path.exists(csv_path):
        print(f"Error: Active probability CSV not found at {csv_path}")
        print("Please set ACTIVE_PROBABILITY_CSV_PATH in .env")
        return 1
    
    # Connect to database
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        port=os.getenv('DB_PORT', '5432'),
        database=os.getenv('DB_NAME', 'side_effect_estimator'),
        user=os.getenv('DB_USER', 'michael'),
        password=os.getenv('DB_PASSWORD')
    )
    
    try:
        # Parse active probabilities
        parser = ActiveProbabilityParser(csv_path)
        probabilities = parser.parse()
        
        # Load into database
        loader = DatabaseLoader(conn)
        loader.load_active_probabilities(probabilities)
        
        print("\n✓ Active probabilities loaded successfully!")
        
        # Show statistics
        stats = loader.get_statistics()
        print(f"\nDatabase now contains:")
        print(f"  Active Probabilities: {stats.get('active_probabilities', 0):,}")
        
    finally:
        conn.close()
    
    return 0

if __name__ == '__main__':
    sys.exit(main())
