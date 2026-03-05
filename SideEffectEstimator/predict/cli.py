#!/usr/bin/env python3
"""
Command-line interface for Side Effect Predictor.
"""

import argparse
import sys
import json
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from predict.side_effect_predictor import SideEffectPredictor
from predict.report_generator import ReportGenerator


def format_detailed(result: dict):
    """Format results in detailed human-readable format."""
    print(f"\n{'='*80}")
    print("SIDE EFFECT PREDICTION REPORT")
    print(f"{'='*80}")
    print(f"\nInput SMILES: {result['smiles']}")
    print(f"Prediction Method: {result['method'].replace('_', ' ').title()}")
    print(f"\nOverall Risk Score: {result['overall_risk_score']:.1f}/10", end="")
    
    if result['overall_risk_score'] < 3:
        print(" (Low Risk)")
    elif result['overall_risk_score'] < 6:
        print(" (Moderate Risk)")
    else:
        print(" (High Risk)")
    
    print(f"Overall Confidence: {result['confidence']:.1%}")
    
    # Similar drugs
    if result['similar_drugs']:
        print(f"\n{'─'*80}")
        print(f"SIMILAR KNOWN DRUGS ({len(result['similar_drugs'])} found)")
        print(f"{'─'*80}")
        for i, drug in enumerate(result['similar_drugs'][:5], 1):
            print(f"{i}. {drug['drug_name']}")
            print(f"   Similarity: {drug['similarity']:.1%}")
            if i < len(result['similar_drugs'][:5]):
                print()
    
    # Predictions
    if result['predictions']:
        print(f"\n{'─'*80}")
        print(f"PREDICTED SIDE EFFECTS ({len(result['predictions'])} total)")
        print(f"{'─'*80}\n")
        
        # Group by severity
        by_severity = {}
        for pred in result['predictions']:
            severity = pred['severity']
            if severity not in by_severity:
                by_severity[severity] = []
            by_severity[severity].append(pred)
        
        # Print by severity
        for severity in ['severe', 'moderate', 'mild', 'unknown']:
            if severity in by_severity:
                preds = by_severity[severity]
                print(f"\n{severity.upper()} ({len(preds)} predictions):")
                print(f"{'─'*80}")
                
                for pred in preds[:10]:  # Limit per severity
                    print(f"\n• {pred['side_effect']}")
                    print(f"  Probability: {pred['probability']:.1%}  |  "
                          f"Confidence: {pred['confidence']:.1%}  |  "
                          f"Evidence: {pred['evidence_count']} drugs")
                    if pred.get('justification'):
                        print(f"  Justification: {pred['justification']}")
                    
                    if pred.get('pathways'):
                        print(f"  Pathways: {', '.join(pred['pathways'][:3])}")
                        
                    if pred.get('contributing_compounds'):
                        comps = [f"{c['name']} ({c['similarity']:.2f})" for c in pred['contributing_compounds'][:3]]
                        print(f"  Contributing Drugs: {', '.join(comps)}")

                    if pred.get('mechanism'):
                        print(f"  Mechanism: {pred['mechanism']}")
                
                if len(preds) > 10:
                    print(f"\n  ... and {len(preds) - 10} more {severity} side effects")
    else:
        print("\nNo side effects predicted (insufficient data)")
    
    print(f"\n{'='*80}\n")


def format_table(result: dict):
    """Format results in compact table format."""
    print(f"\nSMILES: {result['smiles']}")
    print(f"Risk Score: {result['overall_risk_score']:.1f}/10  |  "
          f"Confidence: {result['confidence']:.1%}  |  "
          f"Method: {result['method']}")
    
    if result['similar_drugs']:
        print(f"\nSimilar Drugs: {', '.join(d['drug_name'] for d in result['similar_drugs'][:3])}")
    
    if result['predictions']:
        print(f"\n{'Side Effect':<35} {'Probability':<12} {'Confidence':<12} {'Severity':<10}")
        print("─" * 80)
        
        for pred in result['predictions'][:20]:
            print(f"{pred['side_effect']:<35} "
                  f"{pred['probability']:<12.1%} "
                  f"{pred['confidence']:<12.1%} "
                  f"{pred['severity']:<10}")
    else:
        print("\nNo predictions available")


def format_json(result: dict):
    """Format results as JSON."""
    # Convert to JSON-serializable format
    output = {
        'smiles': result['smiles'],
        'method': result['method'],
        'overall_risk_score': round(result['overall_risk_score'], 2),
        'confidence': round(result['confidence'], 3),
        'similar_drugs': [
            {
                'drug_id': d['drug_id'],
                'drug_name': d['drug_name'],
                'similarity': round(d['similarity'], 3)
            }
            for d in result['similar_drugs']
        ],
        'predictions': [
            {
                'side_effect': p['side_effect'],
                'probability': round(p['probability'], 3),
                'confidence': round(p['confidence'], 3),
                'severity': p['severity'],
                'evidence_count': p['evidence_count'],
                'mechanism': p.get('mechanism', ''),
                'justification': p.get('justification', ''),
                'pathways': p.get('pathways', []),
                'contributing_compounds': p.get('contributing_compounds', [])
            }
            for p in result['predictions']
        ]
    }
    
    print(json.dumps(output, indent=2))


def main():
    parser = argparse.ArgumentParser(
        description='Predict side effects from molecular structures',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Predict from SMILES
  python predict/cli.py --smiles "CC(C)Cc1ccc(cc1)C(C)C(O)=O"
  
  # Predict from drug name
  python predict/cli.py --drug "Aspirin"
  
  # JSON output
  python predict/cli.py --smiles "..." --format json
  
  # Adjust thresholds
  python predict/cli.py --smiles "..." --similarity 0.8 --confidence 0.6
        """
    )
    
    # Input options
    input_group = parser.add_mutually_exclusive_group(required=True)
    input_group.add_argument('--smiles', type=str, help='SMILES string of molecule')
    input_group.add_argument('--drug', type=str, help='Name of known drug')
    
    # Output options
    parser.add_argument('--format', choices=['detailed', 'table', 'json'], 
                       default='detailed', help='Output format (default: detailed)')
    parser.add_argument('--report', type=str, help='Path to save PDF report (e.g. report.pdf)')
    
    # Prediction options
    parser.add_argument('--similarity', type=float, default=0.7,
                       help='Similarity threshold for drug matching (default: 0.7)')
    parser.add_argument('--confidence', type=float, default=0.5,
                       help='Minimum confidence for predictions (default: 0.5)')
    parser.add_argument('--max-similar', type=int, default=10,
                       help='Maximum similar drugs to consider (default: 10)')
    
    args = parser.parse_args()
    
    try:
        # Create predictor
        predictor = SideEffectPredictor(
            similarity_threshold=args.similarity,
            min_confidence=args.confidence
        )
        
        # Make prediction
        if args.smiles:
            result = predictor.predict_from_smiles(args.smiles, args.max_similar)
        else:
            result = predictor.predict_from_drug_name(args.drug)
        
        # Format output
        if args.format == 'json':
            format_json(result)
        elif args.format == 'table':
            format_table(result)
        else:
            format_detailed(result)
            
        # Generate report if requested
        if args.report:
            print(f"\nGenerating report at {args.report}...")
            generator = ReportGenerator()
            generator.generate_report(result, args.report)
            print("Report generation complete.")
        
        return 0
        
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        return 1
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        return 1


if __name__ == '__main__':
    sys.exit(main())
