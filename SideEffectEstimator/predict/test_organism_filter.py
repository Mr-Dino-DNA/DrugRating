import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from predict.side_effect_predictor import SideEffectPredictor

def test_organism_filter():
    print("Testing _is_valid_side_effect logic...")
    
    # We don't need a real DB connection just to test the filter,
    # but the predictor defaults to making one. 
    # Let's pass a dummy connection or just let it fail if DB is down.
    # Actually, if we just instantiate it without a DB, it will try to connect.
    # We can pass an object that evaluates to true.
    class DummyConn:
        def close(self): pass
    
    predictor = SideEffectPredictor(conn=DummyConn())
    
    test_cases = [
        ("Escherichia coli infection", False),
        ("E. coli sepsis", False),
        ("e.coli", False),
        ("Something ecoli related", False),
        ("Escherichia bacteraemia", False),
        ("Staphylococcus aureus infection", False),
        ("Candidiasis", True),
        ("Headache", True),
        ("Nausea", True),
        ("Colitis", True),
        ("Colitis ulcerative", True)
    ]
    
    all_passed = True
    for name, expected in test_cases:
        result = predictor._is_valid_side_effect(name)
        status = "PASS" if result == expected else "FAIL"
        if result != expected:
            all_passed = False
        print(f"[{status}] '{name}' -> Expected: {expected}, Got: {result}")
        
    if all_passed:
        print("\nAll tests passed successfully!")
        sys.exit(0)
    else:
        print("\nSome tests failed.")
        sys.exit(1)

if __name__ == "__main__":
    test_organism_filter()
