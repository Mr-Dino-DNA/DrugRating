#!/usr/bin/env python3
"""
Database initialization script for Side Effect Estimator.
Creates the PostgreSQL schema from schema.sql file.
"""

import os
import sys
import psycopg2
from psycopg2 import sql
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

def get_db_connection():
    """Create database connection from environment variables."""
    try:
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            port=os.getenv('DB_PORT', '5432'),
            database=os.getenv('DB_NAME', 'side_effect_estimator'),
            user=os.getenv('DB_USER', 'postgres'),
            password=os.getenv('DB_PASSWORD')
        )
        return conn
    except psycopg2.Error as e:
        print(f"Error connecting to database: {e}")
        sys.exit(1)

def init_database():
    """Initialize database schema from schema.sql file."""
    # Get the directory where this script is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    schema_file = os.path.join(script_dir, 'schema.sql')
    
    if not os.path.exists(schema_file):
        print(f"Error: schema.sql not found at {schema_file}")
        sys.exit(1)
    
    print("Connecting to database...")
    conn = get_db_connection()
    
    try:
        with conn.cursor() as cur:
            print(f"Reading schema from {schema_file}...")
            with open(schema_file, 'r') as f:
                schema_sql = f.read()
            
            print("Executing schema creation...")
            cur.execute(schema_sql)
            conn.commit()
            
            print("✓ Database schema created successfully!")
            
            # Verify tables were created
            cur.execute("""
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_schema = 'public'
                ORDER BY table_name
            """)
            tables = cur.fetchall()
            
            print(f"\nCreated {len(tables)} tables:")
            for table in tables:
                print(f"  - {table[0]}")
                
    except psycopg2.Error as e:
        conn.rollback()
        print(f"Error creating schema: {e}")
        sys.exit(1)
    finally:
        conn.close()

if __name__ == '__main__':
    print("=" * 60)
    print("Side Effect Estimator - Database Initialization")
    print("=" * 60)
    init_database()
    print("\nDatabase initialization complete!")
