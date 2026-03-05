#!/usr/bin/env python3
"""
Quick setup verification script.
Checks that all prerequisites are met before running ETL.
"""

import os
import sys
from pathlib import Path


def check_python_version():
    """Check Python version."""
    version = sys.version_info
    if version.major < 3 or (version.major == 3 and version.minor < 8):
        return False, f"Python 3.8+ required, found {version.major}.{version.minor}"
    return True, f"Python {version.major}.{version.minor}.{version.micro}"


def check_dependencies():
    """Check if required Python packages are installed."""
    required = ['psycopg2', 'rdkit', 'pandas', 'lxml', 'dotenv', 'tqdm']
    missing = []
    
    for package in required:
        try:
            if package == 'dotenv':
                __import__('dotenv')
            else:
                __import__(package)
        except ImportError:
            missing.append(package)
    
    if missing:
        return False, f"Missing packages: {', '.join(missing)}"
    return True, "All packages installed"


def check_postgresql():
    """Check if PostgreSQL is accessible."""
    try:
        import psycopg2
        from dotenv import load_dotenv
        load_dotenv()
        
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            port=os.getenv('DB_PORT', '5432'),
            database=os.getenv('DB_NAME', 'side_effect_estimator'),
            user=os.getenv('DB_USER', 'postgres'),
            password=os.getenv('DB_PASSWORD'),
            connect_timeout=3
        )
        conn.close()
        return True, "Database connection successful"
    except Exception as e:
        return False, f"Database connection failed: {str(e)}"


def check_env_file():
    """Check if .env file exists and has required variables."""
    if not os.path.exists('.env'):
        return False, ".env file not found (copy from .env.example)"
    
    from dotenv import load_dotenv
    load_dotenv()
    
    required_vars = ['DB_PASSWORD', 'DRUGBANK_XML_PATH', 'SIDER_MEDDRA_ALL_SE_PATH']
    missing = []
    
    for var in required_vars:
        if not os.getenv(var):
            missing.append(var)
    
    if missing:
        return False, f"Missing variables: {', '.join(missing)}"
    return True, "All required variables set"


def check_data_files():
    """Check if data files exist."""
    from dotenv import load_dotenv
    load_dotenv()
    
    files = {
        'DrugBank XML': os.getenv('DRUGBANK_XML_PATH'),
        'SIDER MedDRA': os.getenv('SIDER_MEDDRA_ALL_SE_PATH')
    }
    
    missing = []
    for name, path in files.items():
        if not path or not os.path.exists(path):
            missing.append(f"{name}: {path}")
    
    if missing:
        return False, f"Missing files:\n    " + "\n    ".join(missing)
    return True, "All data files found"


def check_database_schema():
    """Check if database schema is initialized."""
    try:
        import psycopg2
        from dotenv import load_dotenv
        load_dotenv()
        
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST', 'localhost'),
            port=os.getenv('DB_PORT', '5432'),
            database=os.getenv('DB_NAME', 'side_effect_estimator'),
            user=os.getenv('DB_USER', 'postgres'),
            password=os.getenv('DB_PASSWORD')
        )
        
        with conn.cursor() as cur:
            cur.execute("""
                SELECT COUNT(*) FROM information_schema.tables 
                WHERE table_schema = 'public' 
                AND table_name IN ('drugs', 'targets', 'side_effects')
            """)
            count = cur.fetchone()[0]
        
        conn.close()
        
        if count < 3:
            return False, "Schema not initialized (run database/init_db.py)"
        return True, "Database schema initialized"
    except Exception as e:
        return False, f"Cannot check schema: {str(e)}"


def main():
    """Run all checks."""
    print("=" * 70)
    print("Side Effect Estimator - Setup Verification")
    print("=" * 70)
    
    checks = [
        ("Python Version", check_python_version),
        ("Environment File", check_env_file),
        ("Python Dependencies", check_dependencies),
        ("PostgreSQL Connection", check_postgresql),
        ("Database Schema", check_database_schema),
        ("Data Files", check_data_files),
    ]
    
    all_passed = True
    
    for name, check_func in checks:
        print(f"\n{name}...", end=" ")
        try:
            passed, message = check_func()
            if passed:
                print(f"✓ {message}")
            else:
                print(f"✗ {message}")
                all_passed = False
        except Exception as e:
            print(f"✗ Error: {e}")
            all_passed = False
    
    print("\n" + "=" * 70)
    if all_passed:
        print("✓ All checks passed! You're ready to run the ETL pipeline.")
        print("\nNext steps:")
        print("  1. Run: python etl/run_etl.py")
        print("  2. Wait for completion (may take 30-60 minutes)")
        print("  3. Verify data loaded successfully")
    else:
        print("✗ Some checks failed. Please fix the issues above.")
        print("\nCommon fixes:")
        print("  - Install dependencies: pip install -r requirements.txt")
        print("  - Copy .env file: cp .env.example .env")
        print("  - Initialize database: python database/init_db.py")
        print("  - Update file paths in .env")
    print("=" * 70)
    
    return 0 if all_passed else 1


if __name__ == '__main__':
    sys.exit(main())
