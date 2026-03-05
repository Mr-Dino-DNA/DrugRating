#!/usr/bin/env python3
"""
FDA FAERS (Drug Adverse Event) Download Script Generator

This script fetches the FDA's download manifest and generates a wget script
to download all drug adverse event files.

The FDA splits FAERS data into quarterly files, each further split into parts.
This script handles that complexity by parsing the official manifest.

Usage:
    python download_fda_faers.py              # Generate wget script
    python download_fda_faers.py --preview    # Preview URLs without generating script
    python download_fda_faers.py --years 2020 2021 2022  # Only specific years
"""

import requests
import json
import argparse
from pathlib import Path
from datetime import datetime


def fetch_fda_manifest():
    """Fetch the FDA download manifest JSON."""
    url = "https://api.fda.gov/download.json"
    print(f"Fetching FDA manifest from {url}...")
    response = requests.get(url, timeout=30)
    response.raise_for_status()
    return response.json()


def extract_drug_event_urls(manifest, years=None):
    """
    Extract all drug adverse event download URLs from the manifest.
    
    Args:
        manifest: The FDA download manifest JSON
        years: Optional list of years to filter (e.g., [2020, 2021, 2022])
    
    Returns:
        List of dicts with 'url', 'display_name', 'size_mb', 'records'
    """
    drug_events = manifest.get("results", {}).get("drug", {}).get("event", {})
    
    if not drug_events:
        raise ValueError("Could not find drug/event data in manifest")
    
    partitions = drug_events.get("partitions", [])
    export_date = drug_events.get("export_date", "unknown")
    total_records = drug_events.get("total_records", 0)
    
    print(f"\nFDA FAERS Data Summary:")
    print(f"  Export date: {export_date}")
    print(f"  Total records: {total_records:,}")
    print(f"  Total partitions: {len(partitions)}")
    
    urls = []
    for partition in partitions:
        url = partition.get("file", "")
        display_name = partition.get("display_name", "")
        size_mb = float(partition.get("size_mb", 0))
        records = partition.get("records", 0)
        
        # Filter by year if specified
        if years:
            # Extract year from display name (e.g., "2020 Q3 (part 1 of 10)")
            # or from URL (e.g., .../2020q3/...)
            year_found = None
            for year in years:
                if str(year) in display_name or f"/{year}q" in url:
                    year_found = year
                    break
            if not year_found:
                continue
        
        urls.append({
            "url": url,
            "display_name": display_name,
            "size_mb": size_mb,
            "records": records
        })
    
    return urls, export_date


def generate_wget_script(urls, output_dir="FDA_FAERS", script_name="download_fda_faers.sh"):
    """
    Generate a bash script to download all files using wget.
    
    Args:
        urls: List of URL dicts from extract_drug_event_urls
        output_dir: Directory to download files into
        script_name: Name of the output bash script
    """
    total_size = sum(u["size_mb"] for u in urls)
    total_records = sum(u["records"] for u in urls)
    
    script_content = f'''#!/bin/bash
# FDA FAERS Drug Adverse Event Download Script
# Generated: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
#
# Total files: {len(urls)}
# Total size: {total_size:.2f} MB ({total_size/1024:.2f} GB)
# Total records: {total_records:,}
#
# Usage:
#   chmod +x {script_name}
#   ./{script_name}
#
# Or to resume interrupted downloads:
#   ./{script_name}  (wget -c handles resume)

set -e

# Create output directory
OUTPUT_DIR="{output_dir}"
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo "=========================================="
echo "FDA FAERS Download - {len(urls)} files"
echo "Total size: ~{total_size/1024:.2f} GB"
echo "=========================================="
echo ""

# Download all files with resume support (-c) and progress bar
'''
    
    # Add wget commands for each file
    for i, url_info in enumerate(urls, 1):
        url = url_info["url"]
        display = url_info["display_name"]
        size = url_info["size_mb"]
        
        script_content += f'''
echo "[{i}/{len(urls)}] Downloading: {display} ({size:.1f} MB)"
wget -c -q --show-progress "{url}"
'''
    
    script_content += f'''
echo ""
echo "=========================================="
echo "Download complete!"
echo "Files saved to: $OUTPUT_DIR"
echo "=========================================="

# Optionally extract all files
read -p "Extract all zip files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Extracting files..."
    for f in *.zip; do
        echo "Extracting $f..."
        unzip -o -q "$f"
    done
    echo "Extraction complete!"
fi
'''
    
    # Write the script
    script_path = Path(script_name)
    script_path.write_text(script_content)
    script_path.chmod(0o755)  # Make executable
    
    print(f"\n✅ Generated: {script_name}")
    print(f"   Files: {len(urls)}")
    print(f"   Total size: {total_size:.2f} MB ({total_size/1024:.2f} GB)")
    print(f"   Total records: {total_records:,}")
    print(f"\nTo download, run:")
    print(f"   ./{script_name}")
    
    return script_path


def generate_urls_file(urls, filename="fda_faers_urls.txt"):
    """Generate a simple text file with all URLs (for use with wget -i)."""
    with open(filename, "w") as f:
        for url_info in urls:
            f.write(url_info["url"] + "\n")
    
    print(f"\n✅ Generated: {filename}")
    print(f"   Use with: wget -c -i {filename} -P FDA_FAERS")
    
    return filename


def main():
    parser = argparse.ArgumentParser(
        description="Generate wget script to download FDA FAERS data"
    )
    parser.add_argument(
        "--preview", 
        action="store_true",
        help="Preview URLs without generating script"
    )
    parser.add_argument(
        "--years",
        nargs="+",
        type=int,
        help="Only download specific years (e.g., --years 2020 2021 2022)"
    )
    parser.add_argument(
        "--output-dir",
        default="FDA_FAERS",
        help="Directory to download files into (default: FDA_FAERS)"
    )
    parser.add_argument(
        "--urls-only",
        action="store_true",
        help="Generate only a URL list file (for wget -i)"
    )
    
    args = parser.parse_args()
    
    # Fetch manifest
    manifest = fetch_fda_manifest()
    
    # Extract URLs
    urls, export_date = extract_drug_event_urls(manifest, years=args.years)
    
    if not urls:
        print("No URLs found matching criteria!")
        return
    
    # Preview mode
    if args.preview:
        print(f"\nFound {len(urls)} files to download:\n")
        total_size = 0
        for url_info in urls[:20]:  # Show first 20
            print(f"  {url_info['display_name']}: {url_info['size_mb']:.1f} MB")
            total_size += url_info["size_mb"]
        if len(urls) > 20:
            remaining = sum(u["size_mb"] for u in urls[20:])
            print(f"  ... and {len(urls) - 20} more files ({remaining:.1f} MB)")
            total_size += remaining
        print(f"\nTotal: {total_size:.2f} MB ({total_size/1024:.2f} GB)")
        return
    
    # Generate output
    if args.urls_only:
        generate_urls_file(urls)
    else:
        generate_wget_script(urls, output_dir=args.output_dir)
        generate_urls_file(urls)  # Also generate URL list for flexibility


if __name__ == "__main__":
    main()
