#!/usr/bin/env python3
"""
Professional PDF Report Generator for Side Effect Predictions.
Produces a detailed report with structural evidence, MCS highlighting,
mechanism/pathway explanations, and comprehensive side effect tables.
"""

import os
import sys
import json
import tempfile
from datetime import datetime
from collections import Counter

from fpdf import FPDF
from rdkit import Chem
from rdkit.Chem import Draw, rdFMCS, AllChem, Descriptors

# Add parent directory to path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


# ─────────────────────────────── PDF Layout ──────────────────────────────────

class ReportPDF(FPDF):
    """Custom FPDF subclass with header/footer and helper methods."""

    def __init__(self):
        super().__init__()
        self.set_auto_page_break(auto=True, margin=20)

    # ── header / footer ──────────────────────────────────────────────────────

    def header(self):
        self.set_font("Arial", "B", 10)
        self.set_text_color(100, 100, 100)
        self.cell(0, 6, "Side Effect Estimator  |  Computational Toxicology Report", 0, 1, "R")
        self.set_draw_color(0, 102, 204)
        self.set_line_width(0.5)
        self.line(10, 12, 200, 12)
        self.ln(4)

    def footer(self):
        self.set_y(-15)
        self.set_font("Arial", "I", 8)
        self.set_text_color(128, 128, 128)
        self.cell(0, 10, f"Page {self.page_no()} | Generated {datetime.now().strftime('%Y-%m-%d %H:%M')}", 0, 0, "C")

    # ── convenience helpers ──────────────────────────────────────────────────

    def section_title(self, num, title):
        """Blue section header."""
        self.set_font("Arial", "B", 14)
        self.set_text_color(0, 70, 150)
        self.cell(0, 10, f"{num}. {title}", 0, 1)
        self.set_draw_color(0, 102, 204)
        self.line(10, self.get_y(), 200, self.get_y())
        self.ln(3)
        self.set_text_color(0, 0, 0)

    def sub_title(self, title):
        self.set_font("Arial", "B", 11)
        self.set_text_color(50, 50, 50)
        self.cell(0, 7, title, 0, 1)
        self.ln(1)
        self.set_text_color(0, 0, 0)

    def body_text(self, text):
        self.set_font("Arial", "", 10)
        self.multi_cell(0, 5, text)
        self.ln(2)

    def bold_line(self, label, value):
        self.set_font("Arial", "B", 10)
        w = self.get_string_width(label) + 2
        self.cell(w, 6, label, 0, 0)
        self.set_font("Arial", "", 10)
        self.cell(0, 6, str(value), 0, 1)

    def add_image_centered(self, path, w=120):
        if os.path.exists(path):
            x = (210 - w) / 2
            self.image(path, x=x, w=w)
            self.ln(3)


# ─────────────────────────── Report Generator ────────────────────────────────

class ReportGenerator:
    """
    Generates a professional PDF report for a side-effect prediction.

    The report includes:
      1. Executive summary & risk score
      2. Query molecule properties
      3. Structural evidence (similar drugs + MCS highlighting)
      4. Target binding & mechanism analysis
      5. Pathway analysis (Reactome / KEGG)
      6. Full side-effect prediction table
      7. Data sources & methodology
    """

    def __init__(self):
        self.temp_dir = None

    # ── molecule rendering ───────────────────────────────────────────────────

    @staticmethod
    def _mol_image(mol, filename, size=(400, 300), highlight=None, legend=""):
        """Render a single molecule to PNG."""
        try:
            Draw.MolToFile(mol, filename, size=size,
                           highlightAtoms=highlight or [],
                           legend=legend)
            return filename if os.path.exists(filename) else None
        except Exception:
            return None

    @staticmethod
    def _grid_image(mols, filename, legends, highlights=None,
                    mols_per_row=2, size=(450, 350)):
        """Render a grid of molecules (e.g. query vs reference)."""
        try:
            img = Draw.MolsToGridImage(
                mols,
                molsPerRow=mols_per_row,
                subImgSize=size,
                highlightAtomLists=highlights,
                legends=legends,
            )
            img.save(filename)
            return filename if os.path.exists(filename) else None
        except Exception:
            return None

    @staticmethod
    def _compute_mcs(mol_a, mol_b):
        """Return (match_a, match_b) atom indices for the MCS."""
        try:
            mcs = rdFMCS.FindMCS(
                [mol_a, mol_b],
                timeout=10,
                matchValences=True,
                ringMatchesRingOnly=True,
                completeRingsOnly=True,
            )
            if mcs.numAtoms > 2:
                patt = Chem.MolFromSmarts(mcs.smartsString)
                return (list(mol_a.GetSubstructMatch(patt)),
                        list(mol_b.GetSubstructMatch(patt)),
                        mcs.numAtoms)
        except Exception:
            pass
        return [], [], 0

    # ── risk label ───────────────────────────────────────────────────────────

    @staticmethod
    def _risk_label(score):
        if score < 3:
            return "LOW"
        elif score < 6:
            return "MODERATE"
        return "HIGH"

    @staticmethod
    def _classify_side_effect(prob):
        """Classify a side effect probability into a human-readable risk tier."""
        if prob >= 0.7:
            return "Very Likely"
        elif prob >= 0.5:
            return "Likely"
        elif prob >= 0.3:
            return "Possible"
        elif prob >= 0.1:
            return "Unlikely"
        return "Rare"

    # ── main entry point ─────────────────────────────────────────────────────

    def generate_report(self, result: dict, output_path: str = "report.pdf"):
        """
        Build and save the complete PDF report.

        Parameters
        ----------
        result : dict
            The output from ``SideEffectPredictor.predict_from_smiles()``.
        output_path : str
            Where to save the PDF.
        """
        with tempfile.TemporaryDirectory() as td:
            self.temp_dir = td
            pdf = ReportPDF()

            self._page_cover(pdf, result)
            self._page_molecule(pdf, result)
            self._page_structural_evidence(pdf, result)
            self._page_mechanism_pathways(pdf, result)
            self._page_side_effects(pdf, result)
            self._page_methodology(pdf, result)

            pdf.output(output_path)
            print(f"\nReport saved to: {output_path}")

    # ────────────────────────── Page builders ─────────────────────────────────

    def _page_cover(self, pdf: ReportPDF, result: dict):
        """Page 1 – Executive summary."""
        pdf.add_page()
        pdf.set_font("Arial", "B", 22)
        pdf.set_text_color(0, 70, 150)
        pdf.cell(0, 15, "Side Effect Prediction Report", 0, 1, "C")
        pdf.set_text_color(0, 0, 0)
        pdf.ln(5)

        risk = result.get("overall_risk_score", 0)
        confidence = result.get("confidence", 0)
        method = result.get("method", "unknown").replace("_", " ").title()
        n_preds = len(result.get("predictions", []))
        n_similar = len(result.get("similar_drugs", []))

        # Count by source
        preds = result.get("predictions", [])
        n_target = sum(1 for p in preds if p.get('source') in ('target', 'hybrid'))
        n_sim = sum(1 for p in preds if p.get('source') == 'similarity')

        pdf.section_title("1", "Executive Summary")

        pdf.bold_line("Date:  ", datetime.now().strftime("%B %d, %Y"))
        pdf.bold_line("Prediction Method:  ", method)
        pdf.bold_line("Overall Risk Score:  ", f"{risk:.1f} / 10  ({self._risk_label(risk)})")
        pdf.bold_line("Overall Confidence:  ", f"{confidence:.1%}")
        pdf.bold_line("Similar Known Drugs:  ", str(n_similar))
        pdf.bold_line("Predicted Side Effects:  ", f"{n_preds} Total")
        # Sub-bullets for breakdown
        pdf.set_font("Arial", "", 10)
        pdf.cell(50, 6, "", 0, 0) # Indent
        pdf.cell(0, 6, f"- {n_target} Target-Driven (Primary)", 0, 1)
        pdf.cell(50, 6, "", 0, 0) # Indent
        pdf.cell(0, 6, f"- {n_sim} Similarity-Inferred (Supportive)", 0, 1)
        pdf.ln(1)
        pdf.ln(3)

        # Summary narrative
        smiles = result.get("smiles", "")
        top_preds = result.get("predictions", [])[:5]
        top_names = ", ".join(p["side_effect"] for p in top_preds)

        if n_similar > 0:
            top_drug = result["similar_drugs"][0]
            narrative = (
                f'The query molecule (SMILES: {smiles[:60]}{"..." if len(smiles) > 60 else ""}) '
                f'was identified as structurally similar to {n_similar} known drug(s) in DrugBank, '
                f'with the closest match being "{top_drug["drug_name"]}" '
                f'(Tanimoto similarity: {top_drug["similarity"]:.1%}). '
                f'Based on the known safety profiles of these reference compounds, '
                f'{n_preds} potential side effects were predicted. '
                f'The highest-probability predictions include: {top_names}.'
            )
        else:
            narrative = (
                f'No structurally similar drugs were identified in DrugBank above the '
                f'similarity threshold. The prediction was instead performed using '
                f'target-binding probability analysis with {n_preds} side effects predicted. '
                f'Top predictions: {top_names}.'
            )

        pdf.body_text(narrative)

    def _page_molecule(self, pdf: ReportPDF, result: dict):
        """Page 2 – Query molecule properties and 2D depiction."""
        pdf.add_page()
        pdf.section_title("2", "Query Molecule Analysis")

        smiles = result.get("smiles", "")
        mol = Chem.MolFromSmiles(smiles) if smiles else None

        if mol is None:
            pdf.body_text("Could not parse the query SMILES.")
            return

        # Draw query molecule (large)
        img = os.path.join(self.temp_dir, "query.png")
        self._mol_image(mol, img, size=(500, 400), legend="Query Molecule")
        pdf.add_image_centered(img, w=90)

        # Molecular properties
        pdf.sub_title("Physicochemical Properties")
        pdf.bold_line("SMILES:  ", smiles)
        pdf.bold_line("Molecular Formula:  ", Chem.rdMolDescriptors.CalcMolFormula(mol))
        pdf.bold_line("Molecular Weight:  ", f"{Descriptors.MolWt(mol):.2f} g/mol")
        pdf.bold_line("LogP (Wildman-Crippen):  ", f"{Descriptors.MolLogP(mol):.2f}")
        pdf.bold_line("H-Bond Donors:  ", str(Descriptors.NumHDonors(mol)))
        pdf.bold_line("H-Bond Acceptors:  ", str(Descriptors.NumHAcceptors(mol)))
        pdf.bold_line("Rotatable Bonds:  ", str(Descriptors.NumRotatableBonds(mol)))
        pdf.bold_line("TPSA:  ", f"{Descriptors.TPSA(mol):.1f} A^2")

    def _page_structural_evidence(self, pdf: ReportPDF, result: dict):
        """Page 3 – Similar drugs with highlighted MCS."""
        pdf.add_page()
        pdf.section_title("3", "Structural Evidence (DrugBank Similarity)")

        similar = result.get("similar_drugs", [])
        smiles = result.get("smiles", "")
        query_mol = Chem.MolFromSmiles(smiles) if smiles else None

        if not similar or query_mol is None:
            pdf.body_text(
                "No structurally similar drugs were found in DrugBank above the "
                "similarity threshold. Side-effect predictions for this molecule "
                "were generated using the target-binding probability method instead. "
                "See Section 4 for target and pathway evidence."
            )
            return

        pdf.body_text(
            f"{len(similar)} structurally similar drug(s) were identified in DrugBank. "
            "The Maximum Common Substructure (MCS) between the query and each reference "
            "drug is highlighted in blue below. Shared substructures suggest conserved "
            "pharmacological activity and therefore similar safety profiles."
        )

        for i, drug in enumerate(similar[:3]):
            ref_smiles = drug.get("smiles")
            ref_mol = Chem.MolFromSmiles(ref_smiles) if ref_smiles else None
            if ref_mol is None:
                continue

            # MCS
            match_q, match_r, n_atoms = self._compute_mcs(query_mol, ref_mol)

            # Grid image
            fname = os.path.join(self.temp_dir, f"mcs_{i}.png")
            self._grid_image(
                [query_mol, ref_mol],
                fname,
                legends=[
                    "Query Molecule",
                    f'{drug["drug_name"]}  (Sim: {drug["similarity"]:.0%})',
                ],
                highlights=[match_q, match_r],
                size=(450, 350),
            )

            pdf.sub_title(
                f'{drug["drug_name"]}  '
                f'(Tanimoto Similarity: {drug["similarity"]:.1%})'
            )
            pdf.add_image_centered(fname, w=160)

            pdf.body_text(
                f'The query molecule shares a common substructure of {n_atoms} atoms '
                f'with {drug["drug_name"]} (DrugBank ID: {drug["drug_id"]}). '
                f'This structural overlap (highlighted above) suggests the two '
                f'compounds may interact with similar biological targets and '
                f'therefore exhibit overlapping side-effect profiles. '
                f'{drug["drug_name"]} is a known pharmaceutical with documented '
                f'adverse reactions in SIDER and FDA label databases.'
            )

            # Check page space
            if pdf.get_y() > 230:
                pdf.add_page()

    def _page_mechanism_pathways(self, pdf: ReportPDF, result: dict):
        """Page 4 – Mechanism and pathway analysis using target binding data."""
        pdf.add_page()
        pdf.section_title("4", "Mechanism of Action & Pathway Analysis")

        # Use target_analysis (active probability predictions) for mechanism data
        # This always has rich target/pathway info even when similarity was the primary method
        target_preds = result.get("target_analysis", [])
        primary_preds = result.get("predictions", [])
        
        # Combine: use target_analysis for mechanism/pathway; primary for contributing drugs
        preds = target_preds if target_preds else primary_preds
        
        if not preds and not primary_preds:
            pdf.body_text("No predictions available for mechanism analysis.")
            return

        # ── Mechanism narrative ──────────────────────────────────────────────
        pdf.sub_title("4.1  Predicted Target Interactions")

        # Collect unique mechanisms from target analysis
        mechanisms = set()
        for p in preds:
            m = p.get("mechanism", "")
            if m and m not in ("Unknown mechanism", "Present in 1 similar drugs"):
                mechanisms.add(m)
        
        if mechanisms:
            pdf.body_text(
                "The following biological targets were identified as potential "
                "binding partners based on computational target prediction models. "
                "Interaction with these targets may explain the predicted adverse effects:"
            )
            for m in list(mechanisms)[:5]:
                pdf.body_text(f"  >> {m}")
        else:
            # Fallback: describe similarity-based mechanism
            similar = result.get("similar_drugs", [])
            if similar:
                drug_names = ", ".join(d["drug_name"] for d in similar[:3])
                pdf.body_text(
                    f"The mechanism of action was inferred from structural similarity "
                    f"to known drugs ({drug_names}). Side effects are predicted based on "
                    f"the known adverse-event profiles of these reference compounds."
                )
            else:
                pdf.body_text(
                    "Mechanism inferred from target-binding probability analysis."
                )

        pdf.ln(2)

        # ── Justification examples ───────────────────────────────────────────
        pdf.sub_title("4.2  Evidence & Justification")

        shown = set()
        # Gather justifications from both sources
        all_justifications = []
        for p in preds:
            j = p.get("justification", "")
            if j and j not in shown:
                all_justifications.append(j)
                shown.add(j)
        # Also from primary preds
        for p in primary_preds[:15]:
            j = p.get("justification", "")
            if j and j not in shown:
                all_justifications.append(j)
                shown.add(j)

        if all_justifications:
            for j in all_justifications[:6]:
                pdf.body_text(f"  - {j}")
        else:
            pdf.body_text(
                "Justification is derived from structural similarity to known "
                "drugs and/or predicted target-binding probabilities."
            )

        pdf.ln(2)

        # ── Pathway analysis ────────────────────────────────────────────────
        pdf.sub_title("4.3  Biological Pathway Involvement")

        all_pathways = []
        for p in preds:
            all_pathways.extend(p.get("pathways", []))

        if all_pathways:
            counts = Counter(all_pathways)
            top_pathways = counts.most_common(15)

            pdf.body_text(
                f"{len(set(all_pathways))} unique biological pathways (Reactome / KEGG) "
                "were linked to the predicted targets. Disruption of these pathways "
                "may underlie the predicted adverse effects:"
            )

            # Pathway table
            pdf.set_font("Arial", "B", 9)
            pdf.set_fill_color(0, 70, 150)
            pdf.set_text_color(255, 255, 255)
            pdf.cell(130, 7, "Pathway (Reactome / KEGG)", 1, 0, "C", True)
            pdf.cell(40, 7, "# Linked Side Effects", 1, 0, "C", True)
            pdf.ln()
            pdf.set_text_color(0, 0, 0)
            pdf.set_font("Arial", "", 9)
            for idx, (pname, cnt) in enumerate(top_pathways):
                if idx % 2 == 0:
                    pdf.set_fill_color(240, 245, 255)
                else:
                    pdf.set_fill_color(255, 255, 255)
                if len(pname) > 60:
                    pname = pname[:57] + "..."
                pdf.cell(130, 6, pname, 1, 0, "L", True)
                pdf.cell(40, 6, str(cnt), 1, 0, "C", True)
                pdf.ln()
        else:
            pdf.body_text(
                "No Reactome or KEGG pathways were directly linked in the "
                "target analysis. Pathway data depends on the availability of "
                "UniProt annotations for predicted targets."
            )

        # ── Contributing drugs ───────────────────────────────────────────────
        pdf.ln(3)
        pdf.sub_title("4.4  Contributing Reference Compounds")

        compounds = {}
        for p in primary_preds:
            for c in p.get("contributing_compounds", []):
                name = c.get("name", "Unknown")
                sim = c.get("similarity", 0)
                if name not in compounds or sim > compounds[name]:
                    compounds[name] = sim
        
        # Also include similar_drugs
        for d in result.get("similar_drugs", []):
            name = d.get("drug_name", "Unknown")
            sim = d.get("similarity", 0)
            if name not in compounds or sim > compounds[name]:
                compounds[name] = sim

        if compounds:
            pdf.body_text(
                "The following known drugs contributed evidence to the predictions. "
                "Each compound was identified as structurally similar to the query "
                "molecule and has documented side effects in the training databases."
            )
            pdf.set_font("Arial", "B", 9)
            pdf.set_fill_color(0, 70, 150)
            pdf.set_text_color(255, 255, 255)
            pdf.cell(100, 7, "Drug Name", 1, 0, "C", True)
            pdf.cell(50, 7, "Tanimoto Similarity", 1, 0, "C", True)
            pdf.ln()
            pdf.set_text_color(0, 0, 0)
            pdf.set_font("Arial", "", 9)
            for name, sim in sorted(compounds.items(), key=lambda x: -x[1])[:10]:
                pdf.cell(100, 6, name[:45], 1)
                pdf.cell(50, 6, f"{sim:.1%}", 1, 0, "C")
                pdf.ln()
        else:
            pdf.body_text(
                "Predictions were derived from target-binding probability analysis "
                "rather than direct drug similarity."
            )

    def _page_side_effects(self, pdf: ReportPDF, result: dict):
        """Page 5+ – Full side-effect table (Split by source)."""
        pdf.add_page()
        pdf.section_title("5", "Predicted Side Effects (By Source)")

        preds = result.get("predictions", [])
        if not preds:
            pdf.body_text("No side effects were predicted.")
            return

        # Split predictions
        primary = [p for p in preds if p.get('source') in ('target', 'hybrid')]
        secondary = [p for p in preds if p.get('source') == 'similarity']

        pdf.body_text(
            f"Predictions are categorized by their evidence source to prioritize "
            f"mechanistic validation over pure structural similarity."
        )
        pdf.ln(3)

        # Helper to render a table
        def render_table(title, p_list, limit=None):
            if not p_list:
                return
            
            nonlocal pdf
            pdf.sub_title(title)
            
            # Table header
            col_w = [55, 15, 15, 80, 25]  
            headers = ["Side Effect", "Prob.", "Conf.", "Evidence (Drugs & Targets)", "Risk"]

            pdf.set_font("Arial", "B", 8)
            pdf.set_fill_color(0, 70, 150)
            pdf.set_text_color(255, 255, 255)
            for h, w in zip(headers, col_w):
                pdf.cell(w, 7, h, 1, 0, "C", True)
            pdf.ln()
            pdf.set_text_color(0, 0, 0)

            # Table rows
            pdf.set_font("Arial", "", 7)
            
            display_list = p_list[:limit] if limit else p_list
            
            for idx, pred in enumerate(display_list):
                # Alternate row color
                if idx % 2 == 0:
                    pdf.set_fill_color(240, 245, 255)
                else:
                    pdf.set_fill_color(255, 255, 255)

                se = pred["side_effect"]
                if len(se) > 30:
                    se = se[:27] + "..."

                prob = pred["probability"]
                conf = pred["confidence"]
                likelihood = self._classify_side_effect(prob)
                
                # Construct rich Evidence string
                drugs_str = ""
                contribs = pred.get("contributing_compounds", [])
                if contribs:
                    d_list = [f"{c['name']} ({c['similarity']:.0%})" for c in contribs[:2]]
                    drugs_str = "Drugs: " + ", ".join(d_list)
                
                mech = pred.get("mechanism", "")
                targets_str = ""
                if "Binding to " in mech:
                    try:
                        t_part = mech.split("Binding to ")[1].split("(Pathway")[0].strip()
                        if len(t_part) > 60:
                            t_part = t_part[:57] + "..."
                        targets_str = "Targets: " + t_part
                    except:
                        pass
                
                if drugs_str and targets_str:
                    ev_str = f"{drugs_str}; {targets_str}"
                elif drugs_str:
                    ev_str = drugs_str
                elif targets_str:
                    ev_str = targets_str
                else:
                    ev_str = "Inferred from structure/targets"

                if len(ev_str) > 95:
                    ev_str = ev_str[:92] + "..."

                pdf.cell(col_w[0], 6, se, 1, 0, "L", True)
                pdf.cell(col_w[1], 6, f"{prob:.0%}", 1, 0, "C", True)
                pdf.cell(col_w[2], 6, f"{conf:.0%}", 1, 0, "C", True)
                pdf.cell(col_w[3], 6, ev_str, 1, 0, "L", True)
                pdf.cell(col_w[4], 6, likelihood, 1, 0, "C", True)
                pdf.ln()

                # Page break if needed
                if pdf.get_y() > 260:
                    pdf.add_page()
                    pdf.set_font("Arial", "B", 8)
                    pdf.set_fill_color(0, 70, 150)
                    pdf.set_text_color(255, 255, 255)
                    for h, w in zip(headers, col_w):
                        pdf.cell(w, 7, h, 1, 0, "C", True)
                    pdf.ln()
                    pdf.set_text_color(0, 0, 0)
                    pdf.set_font("Arial", "", 7)
            
            pdf.ln(5)

        # Render sections
        if primary:
            render_table("5.1  Primary: Target-Driven & Confirmed (High Confidence)", primary, limit=100)
        else:
            pdf.body_text("No target-driven side effects were identified.")
            pdf.ln(3)

        if secondary:
            # Check if we need new page for secondary
            if pdf.get_y() > 200: 
                pdf.add_page()
            render_table("5.2  Supportive: Inferred from Drug Similarity (Lower Confidence)", secondary, limit=50)

        if len(preds) > 40:
            pdf.ln(3)
            pdf.body_text(
                f"... and {len(preds) - 40} additional lower-probability "
                f"side effects (omitted for brevity)."
            )

        # ── Per-side-effect detail cards ─────────────────────────────────────
        pdf.add_page()
        pdf.sub_title("5.1  Detailed Evidence for Top Side Effects")

        for pred in preds[:10]:
            se = pred["side_effect"]
            prob = pred["probability"]
            conf = pred["confidence"]
            ev = pred.get("evidence_count", 0)
            mech = pred.get("mechanism", "")
            just = pred.get("justification", "")
            pathways = pred.get("pathways", [])
            contribs = pred.get("contributing_compounds", [])
            likelihood = self._classify_side_effect(prob)

            pdf.set_font("Arial", "B", 10)
            pdf.set_text_color(0, 70, 150)
            pdf.cell(0, 7, f"{se}", 0, 1)
            pdf.set_text_color(0, 0, 0)
            pdf.set_font("Arial", "", 9)

            detail = f"Probability: {prob:.1%}  |  Confidence: {conf:.1%}  |  Likelihood: {likelihood}  |  Evidence: {ev} drug(s)"
            pdf.cell(0, 5, detail, 0, 1)

            if just:
                pdf.cell(0, 5, f"Justification: {just}", 0, 1)
            if mech:
                mech_short = mech[:100] + "..." if len(mech) > 100 else mech
                pdf.cell(0, 5, f"Mechanism: {mech_short}", 0, 1)
            if pathways:
                pw_str = ", ".join(pathways[:3])
                if len(pathways) > 3:
                    pw_str += f" (+{len(pathways) - 3} more)"
                pdf.cell(0, 5, f"Pathways: {pw_str}", 0, 1)
            if contribs:
                c_str = ", ".join(
                    f'{c["name"]} ({c["similarity"]:.0%})'
                    for c in contribs[:3]
                )
                pdf.cell(0, 5, f"Supporting Drugs: {c_str}", 0, 1)

            pdf.ln(3)
            if pdf.get_y() > 250:
                pdf.add_page()

    def _page_methodology(self, pdf: ReportPDF, result: dict):
        """Final page – data sources and methodology."""
        pdf.add_page()
        pdf.section_title("6", "Methodology & Data Sources")

        pdf.sub_title("6.1  Prediction Pipeline")
        pdf.body_text(
            "Predictions are generated using a multi-layered computational pipeline:\n\n"
            "1. MOLECULAR FINGERPRINTING: The query molecule is encoded as a "
            "2048-bit Morgan (circular) fingerprint with radius 2.\n\n"
            "2. STRUCTURAL SIMILARITY SEARCH: The fingerprint is compared against "
            "all drugs in DrugBank using Tanimoto similarity. Drugs above the "
            "similarity threshold are identified as structural analogs.\n\n"
            "3. SIDE-EFFECT AGGREGATION: Known side effects of similar drugs are "
            "aggregated, weighted by structural similarity and frequency data.\n\n"
            "4. TARGET-BINDING ANALYSIS (fallback): When no similar drugs are found, "
            "pre-computed target-binding probabilities are used to link the query "
            "molecule to biological targets, which are then mapped to known side "
            "effects via the target-side-effect knowledge graph.\n\n"
            "5. PATHWAY MAPPING: Predicted targets are mapped to Reactome and KEGG "
            "biological pathways via UniProt annotations."
        )

        pdf.sub_title("6.2  Data Sources")

        sources = [
            ["DrugBank 2023", "Drug structures, targets, pharmacology", "~4,500 drugs"],
            ["SIDER 4.1", "Drug-side-effect associations (MedDRA)", "~116K links"],
            ["OnSIDES", "FDA label-derived side effects", "~86K links"],
            ["ChEMBL 36", "Bioactivity & binding affinity data", "~2.4M activities"],
            ["UniProt", "Target pathway annotations (Reactome/KEGG)", "~4K targets"],
        ]

        pdf.set_font("Arial", "B", 9)
        pdf.cell(45, 7, "Source", 1)
        pdf.cell(95, 7, "Data Provided", 1)
        pdf.cell(40, 7, "Scale", 1)
        pdf.ln()
        pdf.set_font("Arial", "", 9)
        for src in sources:
            pdf.cell(45, 6, src[0], 1)
            pdf.cell(95, 6, src[1], 1)
            pdf.cell(40, 6, src[2], 1)
            pdf.ln()

        pdf.ln(5)
        pdf.sub_title("6.3  Limitations")
        pdf.body_text(
            "- Predictions are based on structural similarity and known drug data; "
            "they are NOT clinical evidence and should not replace pharmacovigilance.\n"
            "- The model may miss idiosyncratic or immune-mediated reactions that are "
            "not captured by structural similarity.\n"
            "- Side-effect severity data is limited; probabilities reflect frequency "
            "among reference compounds, not clinical severity.\n"
            "- Novel scaffolds with no structural analogs in DrugBank will rely on "
            "target-binding predictions, which carry lower confidence."
        )

        pdf.ln(3)
        pdf.set_font("Arial", "I", 8)
        pdf.set_text_color(100, 100, 100)
        pdf.multi_cell(
            0, 4,
            "This report was generated automatically by the Side Effect Estimator "
            "computational pipeline. All predictions are for research purposes only "
            "and have not been validated in clinical trials.",
        )
