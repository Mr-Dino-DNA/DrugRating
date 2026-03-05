import os
import glob
import markdown
import asyncio
from playwright.async_api import async_playwright

BASE_DIR = "/home/michael/FDA Approval"

async def convert_markdown_to_pdf(md_path, pdf_path, browser):
    """Convert a single Markdown file to PDF by wrapping it in styled HTML."""
    if not os.path.exists(md_path):
        print(f"File not found: {md_path}")
        return
        
    with open(md_path, "r", encoding="utf-8") as f:
        md_text = f.read()
        
    html_content = markdown.markdown(md_text, extensions=['tables', 'fenced_code'])
    
    # CSS wrapper for Markdown to match professional corporate styling
    styled_html = f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            :root {{
                --text-primary: #1F2937;
                --text-secondary: #4B5563;
                --bg-main: #FFFFFF;
                --bg-surface: #F9FAFB;
                --border-color: #E5E7EB;
                --primary: #0F3A66;      /* Medical Dark Blue */
                --primary-light: #2563EB;
                --accent: #E11D48;
            }}
            body {{
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
                background: var(--bg-main);
                color: var(--text-primary);
                line-height: 1.4;
                padding: 1rem 2rem;
                font-size: 10pt;
                -webkit-font-smoothing: antialiased;
            }}
            h1, h2, h3, h4 {{ font-weight: 700; color: var(--primary); margin-top: 1rem; margin-bottom: 0.5rem; }}
            h1 {{ border-bottom: 2px solid var(--border-color); padding-bottom: 0.25rem; font-size: 16pt; font-weight: 800; letter-spacing: -0.025em; }}
            h2 {{ font-size: 13pt; margin-top: 1.5rem; }}
            h3 {{ font-size: 11pt; color: var(--text-primary); }}
            p, li {{ color: var(--text-secondary); font-size: 9pt; margin-bottom: 0.5rem; }}
            table {{ width: 100%; border-collapse: collapse; margin: 1rem 0; background: var(--bg-main); border: 1px solid var(--border-color); border-radius: 4px; overflow: hidden; }}
            th, td {{ padding: 0.5rem 0.5rem; text-align: left; border-bottom: 1px solid var(--border-color); font-size: 8pt; }}
            th {{ background: var(--bg-surface); color: var(--text-secondary); font-weight: 600; text-transform: uppercase; }}
            tr:last-child td {{ border-bottom: none; }}
            code {{ background: var(--bg-surface); padding: 0.1rem 0.3rem; font-family: monospace; font-size: 0.9em; border: 1px solid var(--border-color); border-radius: 4px; color: var(--primary-light); }}
            ul, ol {{ margin-left: 1.5rem; margin-bottom: 0.5rem; }}
            li {{ margin-bottom: 0.2rem; }}
            @media print {{
                body {{ padding: 0 0.5cm; -webkit-print-color-adjust: exact; print-color-adjust: exact; font-size: 8pt; line-height: 1.3; }}
                h1 {{ font-size: 14pt; margin-top: 0; }}
                h2 {{ font-size: 12pt; page-break-after: avoid; }}
                h3 {{ font-size: 10pt; }}
                p, li {{ font-size: 8pt; margin-bottom: 0.3rem; }}
                table {{ page-break-inside: avoid; margin: 0.5rem 0; }}
                th, td {{ padding: 0.3rem 0.4rem; font-size: 7.5pt; }}
            }}
        </style>
    </head>
    <body>
        <div style="font-size: 11pt;">
            {html_content}
        </div>
    </body>
    </html>
    """
    
    tmp_html = md_path.replace(".md", "_temp.html")
    with open(tmp_html, "w", encoding="utf-8") as f:
        f.write(styled_html)
        
    page = await browser.new_page()
    await page.goto(f"file://{tmp_html}", wait_until="networkidle")
    await page.pdf(path=pdf_path, format="A4", margin={"top": "0.5in", "bottom": "0.5in", "left": "0.5in", "right": "0.5in"})
    await page.close()
    
    os.remove(tmp_html)
    print(f"Exported: {pdf_path}")

async def export_html_to_pdf(html_path, pdf_path, browser):
    """Convert a single HTML report to PDF."""
    if not os.path.exists(html_path):
        return
        
    page = await browser.new_page()
    # Wait until all JS charts map
    await page.goto(f"file://{html_path}", wait_until="networkidle")
    
    # Evaluate a small snippet to open all accordion tabs prior to print so nothing is hidden
    await page.evaluate('''
        document.querySelectorAll('.accordion-content').forEach(el => el.classList.add('active'));
    ''')
    
    # Wait a tiny bit extra for ChartJS animations
    await page.wait_for_timeout(1000)
    
    await page.pdf(path=pdf_path, format="A4")
    await page.close()
    print(f"Exported: {pdf_path}")
    
async def main():
    print("Launching Chromium for PDF Export...")
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        
        print("\\n--- Exporting Markdown Reports ---")
        md_target = os.path.join(BASE_DIR, "FDA Approval_Report.md")
        pdf_target = os.path.join(BASE_DIR, "FDA Approval_Report.pdf")
        await convert_markdown_to_pdf(md_target, pdf_target, browser)
        
        print("\\n--- Exporting Drug HTML Reports ---")
        reports = glob.glob(os.path.join(BASE_DIR, "Drug_Benchmarking", "*", "index.html"))
        for html_file in reports:
            pdf_file = html_file.replace("index.html", "Report.pdf")
            await export_html_to_pdf(html_file, pdf_file, browser)
            
        await browser.close()
        print("\\nAll PDFs generated successfully!")

if __name__ == "__main__":
    asyncio.run(main())
