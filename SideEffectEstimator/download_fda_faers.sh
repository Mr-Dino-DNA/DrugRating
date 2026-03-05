#!/bin/bash
# FDA FAERS Drug Adverse Event Download Script
# Generated: 2026-02-09 12:35:12
#
# Total files: 1710
# Total size: 106512.54 MB (104.02 GB)
# Total records: 20,006,989
#
# Usage:
#   chmod +x download_fda_faers.sh
#   ./download_fda_faers.sh
#
# Or to resume interrupted downloads:
#   ./download_fda_faers.sh  (wget -c handles resume)

set -e

# Create output directory
OUTPUT_DIR="FDA_FAERS"
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

echo "=========================================="
echo "FDA FAERS Download - 1710 files"
echo "Total size: ~104.02 GB"
echo "=========================================="
echo ""

# Download all files with resume support (-c) and progress bar

echo "[1/1710] Downloading: 2004 Q3 (part 1 of 5) (54.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q3/drug-event-0001-of-0005.json.zip"

echo "[2/1710] Downloading: 2004 Q3 (part 2 of 5) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q3/drug-event-0002-of-0005.json.zip"

echo "[3/1710] Downloading: 2004 Q3 (part 3 of 5) (21.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q3/drug-event-0003-of-0005.json.zip"

echo "[4/1710] Downloading: 2004 Q3 (part 4 of 5) (110.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q3/drug-event-0004-of-0005.json.zip"

echo "[5/1710] Downloading: 2004 Q3 (part 5 of 5) (62.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q3/drug-event-0005-of-0005.json.zip"

echo "[6/1710] Downloading: 2020 Q3 (part 1 of 29) (132.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0001-of-0029.json.zip"

echo "[7/1710] Downloading: 2020 Q3 (part 2 of 29) (140.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0002-of-0029.json.zip"

echo "[8/1710] Downloading: 2020 Q3 (part 3 of 29) (47.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0003-of-0029.json.zip"

echo "[9/1710] Downloading: 2020 Q3 (part 4 of 29) (20.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0004-of-0029.json.zip"

echo "[10/1710] Downloading: 2020 Q3 (part 5 of 29) (7.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0005-of-0029.json.zip"

echo "[11/1710] Downloading: 2020 Q3 (part 6 of 29) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0006-of-0029.json.zip"

echo "[12/1710] Downloading: 2020 Q3 (part 7 of 29) (6.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0007-of-0029.json.zip"

echo "[13/1710] Downloading: 2020 Q3 (part 8 of 29) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0008-of-0029.json.zip"

echo "[14/1710] Downloading: 2020 Q3 (part 9 of 29) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0009-of-0029.json.zip"

echo "[15/1710] Downloading: 2020 Q3 (part 10 of 29) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0010-of-0029.json.zip"

echo "[16/1710] Downloading: 2020 Q3 (part 11 of 29) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0011-of-0029.json.zip"

echo "[17/1710] Downloading: 2020 Q3 (part 12 of 29) (5.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0012-of-0029.json.zip"

echo "[18/1710] Downloading: 2020 Q3 (part 13 of 29) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0013-of-0029.json.zip"

echo "[19/1710] Downloading: 2020 Q3 (part 14 of 29) (9.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0014-of-0029.json.zip"

echo "[20/1710] Downloading: 2020 Q3 (part 15 of 29) (14.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0015-of-0029.json.zip"

echo "[21/1710] Downloading: 2020 Q3 (part 16 of 29) (18.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0016-of-0029.json.zip"

echo "[22/1710] Downloading: 2020 Q3 (part 17 of 29) (27.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0017-of-0029.json.zip"

echo "[23/1710] Downloading: 2020 Q3 (part 18 of 29) (41.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0018-of-0029.json.zip"

echo "[24/1710] Downloading: 2020 Q3 (part 19 of 29) (55.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0019-of-0029.json.zip"

echo "[25/1710] Downloading: 2020 Q3 (part 20 of 29) (109.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0020-of-0029.json.zip"

echo "[26/1710] Downloading: 2020 Q3 (part 21 of 29) (139.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0021-of-0029.json.zip"

echo "[27/1710] Downloading: 2020 Q3 (part 22 of 29) (136.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0022-of-0029.json.zip"

echo "[28/1710] Downloading: 2020 Q3 (part 23 of 29) (137.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0023-of-0029.json.zip"

echo "[29/1710] Downloading: 2020 Q3 (part 24 of 29) (140.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0024-of-0029.json.zip"

echo "[30/1710] Downloading: 2020 Q3 (part 25 of 29) (133.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0025-of-0029.json.zip"

echo "[31/1710] Downloading: 2020 Q3 (part 26 of 29) (145.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0026-of-0029.json.zip"

echo "[32/1710] Downloading: 2020 Q3 (part 27 of 29) (136.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0027-of-0029.json.zip"

echo "[33/1710] Downloading: 2020 Q3 (part 28 of 29) (145.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0028-of-0029.json.zip"

echo "[34/1710] Downloading: 2020 Q3 (part 29 of 29) (40.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q3/drug-event-0029-of-0029.json.zip"

echo "[35/1710] Downloading: 2010 Q4 (part 1 of 10) (77.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0001-of-0010.json.zip"

echo "[36/1710] Downloading: 2010 Q4 (part 2 of 10) (31.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0002-of-0010.json.zip"

echo "[37/1710] Downloading: 2010 Q4 (part 3 of 10) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0003-of-0010.json.zip"

echo "[38/1710] Downloading: 2010 Q4 (part 4 of 10) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0004-of-0010.json.zip"

echo "[39/1710] Downloading: 2010 Q4 (part 5 of 10) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0005-of-0010.json.zip"

echo "[40/1710] Downloading: 2010 Q4 (part 6 of 10) (30.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0006-of-0010.json.zip"

echo "[41/1710] Downloading: 2010 Q4 (part 7 of 10) (88.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0007-of-0010.json.zip"

echo "[42/1710] Downloading: 2010 Q4 (part 8 of 10) (118.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0008-of-0010.json.zip"

echo "[43/1710] Downloading: 2010 Q4 (part 9 of 10) (113.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0009-of-0010.json.zip"

echo "[44/1710] Downloading: 2010 Q4 (part 10 of 10) (42.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q4/drug-event-0010-of-0010.json.zip"

echo "[45/1710] Downloading: 2005 Q2 (part 1 of 5) (60.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q2/drug-event-0001-of-0005.json.zip"

echo "[46/1710] Downloading: 2005 Q2 (part 2 of 5) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q2/drug-event-0002-of-0005.json.zip"

echo "[47/1710] Downloading: 2005 Q2 (part 3 of 5) (21.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q2/drug-event-0003-of-0005.json.zip"

echo "[48/1710] Downloading: 2005 Q2 (part 4 of 5) (113.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q2/drug-event-0004-of-0005.json.zip"

echo "[49/1710] Downloading: 2005 Q2 (part 5 of 5) (83.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q2/drug-event-0005-of-0005.json.zip"

echo "[50/1710] Downloading: 2013 Q2 (part 1 of 14) (73.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0001-of-0014.json.zip"

echo "[51/1710] Downloading: 2013 Q2 (part 2 of 14) (38.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0002-of-0014.json.zip"

echo "[52/1710] Downloading: 2013 Q2 (part 3 of 14) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0003-of-0014.json.zip"

echo "[53/1710] Downloading: 2013 Q2 (part 4 of 14) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0004-of-0014.json.zip"

echo "[54/1710] Downloading: 2013 Q2 (part 5 of 14) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0005-of-0014.json.zip"

echo "[55/1710] Downloading: 2013 Q2 (part 6 of 14) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0006-of-0014.json.zip"

echo "[56/1710] Downloading: 2013 Q2 (part 7 of 14) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0007-of-0014.json.zip"

echo "[57/1710] Downloading: 2013 Q2 (part 8 of 14) (5.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0008-of-0014.json.zip"

echo "[58/1710] Downloading: 2013 Q2 (part 9 of 14) (11.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0009-of-0014.json.zip"

echo "[59/1710] Downloading: 2013 Q2 (part 10 of 14) (34.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0010-of-0014.json.zip"

echo "[60/1710] Downloading: 2013 Q2 (part 11 of 14) (70.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0011-of-0014.json.zip"

echo "[61/1710] Downloading: 2013 Q2 (part 12 of 14) (105.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0012-of-0014.json.zip"

echo "[62/1710] Downloading: 2013 Q2 (part 13 of 14) (105.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0013-of-0014.json.zip"

echo "[63/1710] Downloading: 2013 Q2 (part 14 of 14) (73.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q2/drug-event-0014-of-0014.json.zip"

echo "[64/1710] Downloading: 2008 Q4 (part 1 of 7) (78.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q4/drug-event-0001-of-0007.json.zip"

echo "[65/1710] Downloading: 2008 Q4 (part 2 of 7) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q4/drug-event-0002-of-0007.json.zip"

echo "[66/1710] Downloading: 2008 Q4 (part 3 of 7) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q4/drug-event-0003-of-0007.json.zip"

echo "[67/1710] Downloading: 2008 Q4 (part 4 of 7) (20.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q4/drug-event-0004-of-0007.json.zip"

echo "[68/1710] Downloading: 2008 Q4 (part 5 of 7) (89.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q4/drug-event-0005-of-0007.json.zip"

echo "[69/1710] Downloading: 2008 Q4 (part 6 of 7) (124.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q4/drug-event-0006-of-0007.json.zip"

echo "[70/1710] Downloading: 2008 Q4 (part 7 of 7) (53.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q4/drug-event-0007-of-0007.json.zip"

echo "[71/1710] Downloading: 2014 Q1 (part 1 of 20) (139.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0001-of-0020.json.zip"

echo "[72/1710] Downloading: 2014 Q1 (part 2 of 20) (14.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0002-of-0020.json.zip"

echo "[73/1710] Downloading: 2014 Q1 (part 3 of 20) (31.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0003-of-0020.json.zip"

echo "[74/1710] Downloading: 2014 Q1 (part 4 of 20) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0004-of-0020.json.zip"

echo "[75/1710] Downloading: 2014 Q1 (part 5 of 20) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0005-of-0020.json.zip"

echo "[76/1710] Downloading: 2014 Q1 (part 6 of 20) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0006-of-0020.json.zip"

echo "[77/1710] Downloading: 2014 Q1 (part 7 of 20) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0007-of-0020.json.zip"

echo "[78/1710] Downloading: 2014 Q1 (part 8 of 20) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0008-of-0020.json.zip"

echo "[79/1710] Downloading: 2014 Q1 (part 9 of 20) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0009-of-0020.json.zip"

echo "[80/1710] Downloading: 2014 Q1 (part 10 of 20) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0010-of-0020.json.zip"

echo "[81/1710] Downloading: 2014 Q1 (part 11 of 20) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0011-of-0020.json.zip"

echo "[82/1710] Downloading: 2014 Q1 (part 12 of 20) (9.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0012-of-0020.json.zip"

echo "[83/1710] Downloading: 2014 Q1 (part 13 of 20) (13.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0013-of-0020.json.zip"

echo "[84/1710] Downloading: 2014 Q1 (part 14 of 20) (32.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0014-of-0020.json.zip"

echo "[85/1710] Downloading: 2014 Q1 (part 15 of 20) (55.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0015-of-0020.json.zip"

echo "[86/1710] Downloading: 2014 Q1 (part 16 of 20) (100.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0016-of-0020.json.zip"

echo "[87/1710] Downloading: 2014 Q1 (part 17 of 20) (143.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0017-of-0020.json.zip"

echo "[88/1710] Downloading: 2014 Q1 (part 18 of 20) (129.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0018-of-0020.json.zip"

echo "[89/1710] Downloading: 2014 Q1 (part 19 of 20) (132.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0019-of-0020.json.zip"

echo "[90/1710] Downloading: 2014 Q1 (part 20 of 20) (81.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q1/drug-event-0020-of-0020.json.zip"

echo "[91/1710] Downloading: 2025 Q4 (part 1 of 33) (113.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0001-of-0033.json.zip"

echo "[92/1710] Downloading: 2025 Q4 (part 2 of 33) (108.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0002-of-0033.json.zip"

echo "[93/1710] Downloading: 2025 Q4 (part 3 of 33) (101.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0003-of-0033.json.zip"

echo "[94/1710] Downloading: 2025 Q4 (part 4 of 33) (99.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0004-of-0033.json.zip"

echo "[95/1710] Downloading: 2025 Q4 (part 5 of 33) (120.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0005-of-0033.json.zip"

echo "[96/1710] Downloading: 2025 Q4 (part 6 of 33) (102.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0006-of-0033.json.zip"

echo "[97/1710] Downloading: 2025 Q4 (part 7 of 33) (107.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0007-of-0033.json.zip"

echo "[98/1710] Downloading: 2025 Q4 (part 8 of 33) (119.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0008-of-0033.json.zip"

echo "[99/1710] Downloading: 2025 Q4 (part 9 of 33) (112.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0009-of-0033.json.zip"

echo "[100/1710] Downloading: 2025 Q4 (part 10 of 33) (102.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0010-of-0033.json.zip"

echo "[101/1710] Downloading: 2025 Q4 (part 11 of 33) (103.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0011-of-0033.json.zip"

echo "[102/1710] Downloading: 2025 Q4 (part 12 of 33) (120.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0012-of-0033.json.zip"

echo "[103/1710] Downloading: 2025 Q4 (part 13 of 33) (94.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0013-of-0033.json.zip"

echo "[104/1710] Downloading: 2025 Q4 (part 14 of 33) (105.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0014-of-0033.json.zip"

echo "[105/1710] Downloading: 2025 Q4 (part 15 of 33) (101.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0015-of-0033.json.zip"

echo "[106/1710] Downloading: 2025 Q4 (part 16 of 33) (105.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0016-of-0033.json.zip"

echo "[107/1710] Downloading: 2025 Q4 (part 17 of 33) (91.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0017-of-0033.json.zip"

echo "[108/1710] Downloading: 2025 Q4 (part 18 of 33) (116.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0018-of-0033.json.zip"

echo "[109/1710] Downloading: 2025 Q4 (part 19 of 33) (121.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0019-of-0033.json.zip"

echo "[110/1710] Downloading: 2025 Q4 (part 20 of 33) (128.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0020-of-0033.json.zip"

echo "[111/1710] Downloading: 2025 Q4 (part 21 of 33) (119.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0021-of-0033.json.zip"

echo "[112/1710] Downloading: 2025 Q4 (part 22 of 33) (112.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0022-of-0033.json.zip"

echo "[113/1710] Downloading: 2025 Q4 (part 23 of 33) (132.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0023-of-0033.json.zip"

echo "[114/1710] Downloading: 2025 Q4 (part 24 of 33) (117.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0024-of-0033.json.zip"

echo "[115/1710] Downloading: 2025 Q4 (part 25 of 33) (106.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0025-of-0033.json.zip"

echo "[116/1710] Downloading: 2025 Q4 (part 26 of 33) (114.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0026-of-0033.json.zip"

echo "[117/1710] Downloading: 2025 Q4 (part 27 of 33) (102.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0027-of-0033.json.zip"

echo "[118/1710] Downloading: 2025 Q4 (part 28 of 33) (116.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0028-of-0033.json.zip"

echo "[119/1710] Downloading: 2025 Q4 (part 29 of 33) (132.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0029-of-0033.json.zip"

echo "[120/1710] Downloading: 2025 Q4 (part 30 of 33) (107.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0030-of-0033.json.zip"

echo "[121/1710] Downloading: 2025 Q4 (part 31 of 33) (104.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0031-of-0033.json.zip"

echo "[122/1710] Downloading: 2025 Q4 (part 32 of 33) (116.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0032-of-0033.json.zip"

echo "[123/1710] Downloading: 2025 Q4 (part 33 of 33) (10.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q4/drug-event-0033-of-0033.json.zip"

echo "[124/1710] Downloading: 2018 Q4 (part 1 of 28) (18.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0001-of-0028.json.zip"

echo "[125/1710] Downloading: 2018 Q4 (part 2 of 28) (16.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0002-of-0028.json.zip"

echo "[126/1710] Downloading: 2018 Q4 (part 3 of 28) (11.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0003-of-0028.json.zip"

echo "[127/1710] Downloading: 2018 Q4 (part 4 of 28) (14.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0004-of-0028.json.zip"

echo "[128/1710] Downloading: 2018 Q4 (part 5 of 28) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0005-of-0028.json.zip"

echo "[129/1710] Downloading: 2018 Q4 (part 6 of 28) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0006-of-0028.json.zip"

echo "[130/1710] Downloading: 2018 Q4 (part 7 of 28) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0007-of-0028.json.zip"

echo "[131/1710] Downloading: 2018 Q4 (part 8 of 28) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0008-of-0028.json.zip"

echo "[132/1710] Downloading: 2018 Q4 (part 9 of 28) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0009-of-0028.json.zip"

echo "[133/1710] Downloading: 2018 Q4 (part 10 of 28) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0010-of-0028.json.zip"

echo "[134/1710] Downloading: 2018 Q4 (part 11 of 28) (6.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0011-of-0028.json.zip"

echo "[135/1710] Downloading: 2018 Q4 (part 12 of 28) (12.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0012-of-0028.json.zip"

echo "[136/1710] Downloading: 2018 Q4 (part 13 of 28) (12.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0013-of-0028.json.zip"

echo "[137/1710] Downloading: 2018 Q4 (part 14 of 28) (17.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0014-of-0028.json.zip"

echo "[138/1710] Downloading: 2018 Q4 (part 15 of 28) (51.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0015-of-0028.json.zip"

echo "[139/1710] Downloading: 2018 Q4 (part 16 of 28) (48.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0016-of-0028.json.zip"

echo "[140/1710] Downloading: 2018 Q4 (part 17 of 28) (80.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0017-of-0028.json.zip"

echo "[141/1710] Downloading: 2018 Q4 (part 18 of 28) (120.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0018-of-0028.json.zip"

echo "[142/1710] Downloading: 2018 Q4 (part 19 of 28) (123.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0019-of-0028.json.zip"

echo "[143/1710] Downloading: 2018 Q4 (part 20 of 28) (122.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0020-of-0028.json.zip"

echo "[144/1710] Downloading: 2018 Q4 (part 21 of 28) (114.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0021-of-0028.json.zip"

echo "[145/1710] Downloading: 2018 Q4 (part 22 of 28) (113.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0022-of-0028.json.zip"

echo "[146/1710] Downloading: 2018 Q4 (part 23 of 28) (119.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0023-of-0028.json.zip"

echo "[147/1710] Downloading: 2018 Q4 (part 24 of 28) (120.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0024-of-0028.json.zip"

echo "[148/1710] Downloading: 2018 Q4 (part 25 of 28) (122.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0025-of-0028.json.zip"

echo "[149/1710] Downloading: 2018 Q4 (part 26 of 28) (122.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0026-of-0028.json.zip"

echo "[150/1710] Downloading: 2018 Q4 (part 27 of 28) (121.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0027-of-0028.json.zip"

echo "[151/1710] Downloading: 2018 Q4 (part 28 of 28) (87.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q4/drug-event-0028-of-0028.json.zip"

echo "[152/1710] Downloading: 2013 Q1 (part 1 of 18) (86.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0001-of-0018.json.zip"

echo "[153/1710] Downloading: 2013 Q1 (part 2 of 18) (50.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0002-of-0018.json.zip"

echo "[154/1710] Downloading: 2013 Q1 (part 3 of 18) (7.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0003-of-0018.json.zip"

echo "[155/1710] Downloading: 2013 Q1 (part 4 of 18) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0004-of-0018.json.zip"

echo "[156/1710] Downloading: 2013 Q1 (part 5 of 18) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0005-of-0018.json.zip"

echo "[157/1710] Downloading: 2013 Q1 (part 6 of 18) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0006-of-0018.json.zip"

echo "[158/1710] Downloading: 2013 Q1 (part 7 of 18) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0007-of-0018.json.zip"

echo "[159/1710] Downloading: 2013 Q1 (part 8 of 18) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0008-of-0018.json.zip"

echo "[160/1710] Downloading: 2013 Q1 (part 9 of 18) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0009-of-0018.json.zip"

echo "[161/1710] Downloading: 2013 Q1 (part 10 of 18) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0010-of-0018.json.zip"

echo "[162/1710] Downloading: 2013 Q1 (part 11 of 18) (8.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0011-of-0018.json.zip"

echo "[163/1710] Downloading: 2013 Q1 (part 12 of 18) (15.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0012-of-0018.json.zip"

echo "[164/1710] Downloading: 2013 Q1 (part 13 of 18) (40.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0013-of-0018.json.zip"

echo "[165/1710] Downloading: 2013 Q1 (part 14 of 18) (81.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0014-of-0018.json.zip"

echo "[166/1710] Downloading: 2013 Q1 (part 15 of 18) (121.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0015-of-0018.json.zip"

echo "[167/1710] Downloading: 2013 Q1 (part 16 of 18) (108.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0016-of-0018.json.zip"

echo "[168/1710] Downloading: 2013 Q1 (part 17 of 18) (122.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0017-of-0018.json.zip"

echo "[169/1710] Downloading: 2013 Q1 (part 18 of 18) (28.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q1/drug-event-0018-of-0018.json.zip"

echo "[170/1710] Downloading: 2009 Q4 (part 1 of 8) (80.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0001-of-0008.json.zip"

echo "[171/1710] Downloading: 2009 Q4 (part 2 of 8) (10.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0002-of-0008.json.zip"

echo "[172/1710] Downloading: 2009 Q4 (part 3 of 8) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0003-of-0008.json.zip"

echo "[173/1710] Downloading: 2009 Q4 (part 4 of 8) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0004-of-0008.json.zip"

echo "[174/1710] Downloading: 2009 Q4 (part 5 of 8) (30.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0005-of-0008.json.zip"

echo "[175/1710] Downloading: 2009 Q4 (part 6 of 8) (100.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0006-of-0008.json.zip"

echo "[176/1710] Downloading: 2009 Q4 (part 7 of 8) (118.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0007-of-0008.json.zip"

echo "[177/1710] Downloading: 2009 Q4 (part 8 of 8) (67.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q4/drug-event-0008-of-0008.json.zip"

echo "[178/1710] Downloading: 2011 Q3 (part 1 of 12) (96.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0001-of-0012.json.zip"

echo "[179/1710] Downloading: 2011 Q3 (part 2 of 12) (60.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0002-of-0012.json.zip"

echo "[180/1710] Downloading: 2011 Q3 (part 3 of 12) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0003-of-0012.json.zip"

echo "[181/1710] Downloading: 2011 Q3 (part 4 of 12) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0004-of-0012.json.zip"

echo "[182/1710] Downloading: 2011 Q3 (part 5 of 12) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0005-of-0012.json.zip"

echo "[183/1710] Downloading: 2011 Q3 (part 6 of 12) (6.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0006-of-0012.json.zip"

echo "[184/1710] Downloading: 2011 Q3 (part 7 of 12) (24.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0007-of-0012.json.zip"

echo "[185/1710] Downloading: 2011 Q3 (part 8 of 12) (66.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0008-of-0012.json.zip"

echo "[186/1710] Downloading: 2011 Q3 (part 9 of 12) (145.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0009-of-0012.json.zip"

echo "[187/1710] Downloading: 2011 Q3 (part 10 of 12) (135.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0010-of-0012.json.zip"

echo "[188/1710] Downloading: 2011 Q3 (part 11 of 12) (128.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0011-of-0012.json.zip"

echo "[189/1710] Downloading: 2011 Q3 (part 12 of 12) (60.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q3/drug-event-0012-of-0012.json.zip"

echo "[190/1710] Downloading: 2009 Q2 (part 1 of 8) (76.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0001-of-0008.json.zip"

echo "[191/1710] Downloading: 2009 Q2 (part 2 of 8) (20.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0002-of-0008.json.zip"

echo "[192/1710] Downloading: 2009 Q2 (part 3 of 8) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0003-of-0008.json.zip"

echo "[193/1710] Downloading: 2009 Q2 (part 4 of 8) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0004-of-0008.json.zip"

echo "[194/1710] Downloading: 2009 Q2 (part 5 of 8) (32.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0005-of-0008.json.zip"

echo "[195/1710] Downloading: 2009 Q2 (part 6 of 8) (86.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0006-of-0008.json.zip"

echo "[196/1710] Downloading: 2009 Q2 (part 7 of 8) (107.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0007-of-0008.json.zip"

echo "[197/1710] Downloading: 2009 Q2 (part 8 of 8) (105.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q2/drug-event-0008-of-0008.json.zip"

echo "[198/1710] Downloading: 2023 Q3 (part 1 of 30) (163.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0001-of-0030.json.zip"

echo "[199/1710] Downloading: 2023 Q3 (part 2 of 30) (79.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0002-of-0030.json.zip"

echo "[200/1710] Downloading: 2023 Q3 (part 3 of 30) (10.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0003-of-0030.json.zip"

echo "[201/1710] Downloading: 2023 Q3 (part 4 of 30) (92.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0004-of-0030.json.zip"

echo "[202/1710] Downloading: 2023 Q3 (part 5 of 30) (120.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0005-of-0030.json.zip"

echo "[203/1710] Downloading: 2023 Q3 (part 6 of 30) (12.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0006-of-0030.json.zip"

echo "[204/1710] Downloading: 2023 Q3 (part 7 of 30) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0007-of-0030.json.zip"

echo "[205/1710] Downloading: 2023 Q3 (part 8 of 30) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0008-of-0030.json.zip"

echo "[206/1710] Downloading: 2023 Q3 (part 9 of 30) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0009-of-0030.json.zip"

echo "[207/1710] Downloading: 2023 Q3 (part 10 of 30) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0010-of-0030.json.zip"

echo "[208/1710] Downloading: 2023 Q3 (part 11 of 30) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0011-of-0030.json.zip"

echo "[209/1710] Downloading: 2023 Q3 (part 12 of 30) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0012-of-0030.json.zip"

echo "[210/1710] Downloading: 2023 Q3 (part 13 of 30) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0013-of-0030.json.zip"

echo "[211/1710] Downloading: 2023 Q3 (part 14 of 30) (5.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0014-of-0030.json.zip"

echo "[212/1710] Downloading: 2023 Q3 (part 15 of 30) (11.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0015-of-0030.json.zip"

echo "[213/1710] Downloading: 2023 Q3 (part 16 of 30) (18.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0016-of-0030.json.zip"

echo "[214/1710] Downloading: 2023 Q3 (part 17 of 30) (21.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0017-of-0030.json.zip"

echo "[215/1710] Downloading: 2023 Q3 (part 18 of 30) (46.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0018-of-0030.json.zip"

echo "[216/1710] Downloading: 2023 Q3 (part 19 of 30) (54.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0019-of-0030.json.zip"

echo "[217/1710] Downloading: 2023 Q3 (part 20 of 30) (131.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0020-of-0030.json.zip"

echo "[218/1710] Downloading: 2023 Q3 (part 21 of 30) (176.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0021-of-0030.json.zip"

echo "[219/1710] Downloading: 2023 Q3 (part 22 of 30) (167.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0022-of-0030.json.zip"

echo "[220/1710] Downloading: 2023 Q3 (part 23 of 30) (166.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0023-of-0030.json.zip"

echo "[221/1710] Downloading: 2023 Q3 (part 24 of 30) (170.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0024-of-0030.json.zip"

echo "[222/1710] Downloading: 2023 Q3 (part 25 of 30) (168.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0025-of-0030.json.zip"

echo "[223/1710] Downloading: 2023 Q3 (part 26 of 30) (172.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0026-of-0030.json.zip"

echo "[224/1710] Downloading: 2023 Q3 (part 27 of 30) (170.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0027-of-0030.json.zip"

echo "[225/1710] Downloading: 2023 Q3 (part 28 of 30) (174.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0028-of-0030.json.zip"

echo "[226/1710] Downloading: 2023 Q3 (part 29 of 30) (174.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0029-of-0030.json.zip"

echo "[227/1710] Downloading: 2023 Q3 (part 30 of 30) (28.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q3/drug-event-0030-of-0030.json.zip"

echo "[228/1710] Downloading: 2007 Q1 (part 1 of 6) (66.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q1/drug-event-0001-of-0006.json.zip"

echo "[229/1710] Downloading: 2007 Q1 (part 2 of 6) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q1/drug-event-0002-of-0006.json.zip"

echo "[230/1710] Downloading: 2007 Q1 (part 3 of 6) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q1/drug-event-0003-of-0006.json.zip"

echo "[231/1710] Downloading: 2007 Q1 (part 4 of 6) (32.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q1/drug-event-0004-of-0006.json.zip"

echo "[232/1710] Downloading: 2007 Q1 (part 5 of 6) (108.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q1/drug-event-0005-of-0006.json.zip"

echo "[233/1710] Downloading: 2007 Q1 (part 6 of 6) (86.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q1/drug-event-0006-of-0006.json.zip"

echo "[234/1710] Downloading: 2020 Q4 (part 1 of 30) (120.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0001-of-0030.json.zip"

echo "[235/1710] Downloading: 2020 Q4 (part 2 of 30) (146.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0002-of-0030.json.zip"

echo "[236/1710] Downloading: 2020 Q4 (part 3 of 30) (58.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0003-of-0030.json.zip"

echo "[237/1710] Downloading: 2020 Q4 (part 4 of 30) (15.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0004-of-0030.json.zip"

echo "[238/1710] Downloading: 2020 Q4 (part 5 of 30) (12.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0005-of-0030.json.zip"

echo "[239/1710] Downloading: 2020 Q4 (part 6 of 30) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0006-of-0030.json.zip"

echo "[240/1710] Downloading: 2020 Q4 (part 7 of 30) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0007-of-0030.json.zip"

echo "[241/1710] Downloading: 2020 Q4 (part 8 of 30) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0008-of-0030.json.zip"

echo "[242/1710] Downloading: 2020 Q4 (part 9 of 30) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0009-of-0030.json.zip"

echo "[243/1710] Downloading: 2020 Q4 (part 10 of 30) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0010-of-0030.json.zip"

echo "[244/1710] Downloading: 2020 Q4 (part 11 of 30) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0011-of-0030.json.zip"

echo "[245/1710] Downloading: 2020 Q4 (part 12 of 30) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0012-of-0030.json.zip"

echo "[246/1710] Downloading: 2020 Q4 (part 13 of 30) (5.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0013-of-0030.json.zip"

echo "[247/1710] Downloading: 2020 Q4 (part 14 of 30) (6.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0014-of-0030.json.zip"

echo "[248/1710] Downloading: 2020 Q4 (part 15 of 30) (11.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0015-of-0030.json.zip"

echo "[249/1710] Downloading: 2020 Q4 (part 16 of 30) (13.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0016-of-0030.json.zip"

echo "[250/1710] Downloading: 2020 Q4 (part 17 of 30) (14.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0017-of-0030.json.zip"

echo "[251/1710] Downloading: 2020 Q4 (part 18 of 30) (27.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0018-of-0030.json.zip"

echo "[252/1710] Downloading: 2020 Q4 (part 19 of 30) (42.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0019-of-0030.json.zip"

echo "[253/1710] Downloading: 2020 Q4 (part 20 of 30) (51.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0020-of-0030.json.zip"

echo "[254/1710] Downloading: 2020 Q4 (part 21 of 30) (90.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0021-of-0030.json.zip"

echo "[255/1710] Downloading: 2020 Q4 (part 22 of 30) (150.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0022-of-0030.json.zip"

echo "[256/1710] Downloading: 2020 Q4 (part 23 of 30) (148.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0023-of-0030.json.zip"

echo "[257/1710] Downloading: 2020 Q4 (part 24 of 30) (146.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0024-of-0030.json.zip"

echo "[258/1710] Downloading: 2020 Q4 (part 25 of 30) (148.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0025-of-0030.json.zip"

echo "[259/1710] Downloading: 2020 Q4 (part 26 of 30) (146.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0026-of-0030.json.zip"

echo "[260/1710] Downloading: 2020 Q4 (part 27 of 30) (151.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0027-of-0030.json.zip"

echo "[261/1710] Downloading: 2020 Q4 (part 28 of 30) (147.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0028-of-0030.json.zip"

echo "[262/1710] Downloading: 2020 Q4 (part 29 of 30) (142.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0029-of-0030.json.zip"

echo "[263/1710] Downloading: 2020 Q4 (part 30 of 30) (12.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q4/drug-event-0030-of-0030.json.zip"

echo "[264/1710] Downloading: 2025 Q3 (part 1 of 35) (139.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0001-of-0035.json.zip"

echo "[265/1710] Downloading: 2025 Q3 (part 2 of 35) (128.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0002-of-0035.json.zip"

echo "[266/1710] Downloading: 2025 Q3 (part 3 of 35) (57.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0003-of-0035.json.zip"

echo "[267/1710] Downloading: 2025 Q3 (part 4 of 35) (42.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0004-of-0035.json.zip"

echo "[268/1710] Downloading: 2025 Q3 (part 5 of 35) (7.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0005-of-0035.json.zip"

echo "[269/1710] Downloading: 2025 Q3 (part 6 of 35) (55.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0006-of-0035.json.zip"

echo "[270/1710] Downloading: 2025 Q3 (part 7 of 35) (150.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0007-of-0035.json.zip"

echo "[271/1710] Downloading: 2025 Q3 (part 8 of 35) (80.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0008-of-0035.json.zip"

echo "[272/1710] Downloading: 2025 Q3 (part 9 of 35) (64.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0009-of-0035.json.zip"

echo "[273/1710] Downloading: 2025 Q3 (part 10 of 35) (22.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0010-of-0035.json.zip"

echo "[274/1710] Downloading: 2025 Q3 (part 11 of 35) (6.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0011-of-0035.json.zip"

echo "[275/1710] Downloading: 2025 Q3 (part 12 of 35) (9.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0012-of-0035.json.zip"

echo "[276/1710] Downloading: 2025 Q3 (part 13 of 35) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0013-of-0035.json.zip"

echo "[277/1710] Downloading: 2025 Q3 (part 14 of 35) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0014-of-0035.json.zip"

echo "[278/1710] Downloading: 2025 Q3 (part 15 of 35) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0015-of-0035.json.zip"

echo "[279/1710] Downloading: 2025 Q3 (part 16 of 35) (8.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0016-of-0035.json.zip"

echo "[280/1710] Downloading: 2025 Q3 (part 17 of 35) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0017-of-0035.json.zip"

echo "[281/1710] Downloading: 2025 Q3 (part 18 of 35) (20.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0018-of-0035.json.zip"

echo "[282/1710] Downloading: 2025 Q3 (part 19 of 35) (37.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0019-of-0035.json.zip"

echo "[283/1710] Downloading: 2025 Q3 (part 20 of 35) (59.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0020-of-0035.json.zip"

echo "[284/1710] Downloading: 2025 Q3 (part 21 of 35) (127.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0021-of-0035.json.zip"

echo "[285/1710] Downloading: 2025 Q3 (part 22 of 35) (180.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0022-of-0035.json.zip"

echo "[286/1710] Downloading: 2025 Q3 (part 23 of 35) (158.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0023-of-0035.json.zip"

echo "[287/1710] Downloading: 2025 Q3 (part 24 of 35) (204.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0024-of-0035.json.zip"

echo "[288/1710] Downloading: 2025 Q3 (part 25 of 35) (200.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0025-of-0035.json.zip"

echo "[289/1710] Downloading: 2025 Q3 (part 26 of 35) (191.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0026-of-0035.json.zip"

echo "[290/1710] Downloading: 2025 Q3 (part 27 of 35) (200.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0027-of-0035.json.zip"

echo "[291/1710] Downloading: 2025 Q3 (part 28 of 35) (191.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0028-of-0035.json.zip"

echo "[292/1710] Downloading: 2025 Q3 (part 29 of 35) (203.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0029-of-0035.json.zip"

echo "[293/1710] Downloading: 2025 Q3 (part 30 of 35) (192.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0030-of-0035.json.zip"

echo "[294/1710] Downloading: 2025 Q3 (part 31 of 35) (184.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0031-of-0035.json.zip"

echo "[295/1710] Downloading: 2025 Q3 (part 32 of 35) (197.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0032-of-0035.json.zip"

echo "[296/1710] Downloading: 2025 Q3 (part 33 of 35) (185.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0033-of-0035.json.zip"

echo "[297/1710] Downloading: 2025 Q3 (part 34 of 35) (199.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0034-of-0035.json.zip"

echo "[298/1710] Downloading: 2025 Q3 (part 35 of 35) (65.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q3/drug-event-0035-of-0035.json.zip"

echo "[299/1710] Downloading: 2024 Q2 (part 1 of 29) (88.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0001-of-0029.json.zip"

echo "[300/1710] Downloading: 2024 Q2 (part 2 of 29) (67.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0002-of-0029.json.zip"

echo "[301/1710] Downloading: 2024 Q2 (part 3 of 29) (110.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0003-of-0029.json.zip"

echo "[302/1710] Downloading: 2024 Q2 (part 4 of 29) (9.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0004-of-0029.json.zip"

echo "[303/1710] Downloading: 2024 Q2 (part 5 of 29) (35.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0005-of-0029.json.zip"

echo "[304/1710] Downloading: 2024 Q2 (part 6 of 29) (55.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0006-of-0029.json.zip"

echo "[305/1710] Downloading: 2024 Q2 (part 7 of 29) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0007-of-0029.json.zip"

echo "[306/1710] Downloading: 2024 Q2 (part 8 of 29) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0008-of-0029.json.zip"

echo "[307/1710] Downloading: 2024 Q2 (part 9 of 29) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0009-of-0029.json.zip"

echo "[308/1710] Downloading: 2024 Q2 (part 10 of 29) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0010-of-0029.json.zip"

echo "[309/1710] Downloading: 2024 Q2 (part 11 of 29) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0011-of-0029.json.zip"

echo "[310/1710] Downloading: 2024 Q2 (part 12 of 29) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0012-of-0029.json.zip"

echo "[311/1710] Downloading: 2024 Q2 (part 13 of 29) (11.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0013-of-0029.json.zip"

echo "[312/1710] Downloading: 2024 Q2 (part 14 of 29) (21.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0014-of-0029.json.zip"

echo "[313/1710] Downloading: 2024 Q2 (part 15 of 29) (19.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0015-of-0029.json.zip"

echo "[314/1710] Downloading: 2024 Q2 (part 16 of 29) (45.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0016-of-0029.json.zip"

echo "[315/1710] Downloading: 2024 Q2 (part 17 of 29) (78.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0017-of-0029.json.zip"

echo "[316/1710] Downloading: 2024 Q2 (part 18 of 29) (118.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0018-of-0029.json.zip"

echo "[317/1710] Downloading: 2024 Q2 (part 19 of 29) (160.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0019-of-0029.json.zip"

echo "[318/1710] Downloading: 2024 Q2 (part 20 of 29) (158.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0020-of-0029.json.zip"

echo "[319/1710] Downloading: 2024 Q2 (part 21 of 29) (179.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0021-of-0029.json.zip"

echo "[320/1710] Downloading: 2024 Q2 (part 22 of 29) (182.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0022-of-0029.json.zip"

echo "[321/1710] Downloading: 2024 Q2 (part 23 of 29) (175.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0023-of-0029.json.zip"

echo "[322/1710] Downloading: 2024 Q2 (part 24 of 29) (175.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0024-of-0029.json.zip"

echo "[323/1710] Downloading: 2024 Q2 (part 25 of 29) (175.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0025-of-0029.json.zip"

echo "[324/1710] Downloading: 2024 Q2 (part 26 of 29) (185.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0026-of-0029.json.zip"

echo "[325/1710] Downloading: 2024 Q2 (part 27 of 29) (182.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0027-of-0029.json.zip"

echo "[326/1710] Downloading: 2024 Q2 (part 28 of 29) (193.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0028-of-0029.json.zip"

echo "[327/1710] Downloading: 2024 Q2 (part 29 of 29) (8.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q2/drug-event-0029-of-0029.json.zip"

echo "[328/1710] Downloading: 2005 Q4 (part 1 of 5) (64.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q4/drug-event-0001-of-0005.json.zip"

echo "[329/1710] Downloading: 2005 Q4 (part 2 of 5) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q4/drug-event-0002-of-0005.json.zip"

echo "[330/1710] Downloading: 2005 Q4 (part 3 of 5) (7.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q4/drug-event-0003-of-0005.json.zip"

echo "[331/1710] Downloading: 2005 Q4 (part 4 of 5) (98.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q4/drug-event-0004-of-0005.json.zip"

echo "[332/1710] Downloading: 2005 Q4 (part 5 of 5) (125.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q4/drug-event-0005-of-0005.json.zip"

echo "[333/1710] Downloading: 2011 Q1 (part 1 of 11) (74.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0001-of-0011.json.zip"

echo "[334/1710] Downloading: 2011 Q1 (part 2 of 11) (54.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0002-of-0011.json.zip"

echo "[335/1710] Downloading: 2011 Q1 (part 3 of 11) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0003-of-0011.json.zip"

echo "[336/1710] Downloading: 2011 Q1 (part 4 of 11) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0004-of-0011.json.zip"

echo "[337/1710] Downloading: 2011 Q1 (part 5 of 11) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0005-of-0011.json.zip"

echo "[338/1710] Downloading: 2011 Q1 (part 6 of 11) (7.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0006-of-0011.json.zip"

echo "[339/1710] Downloading: 2011 Q1 (part 7 of 11) (34.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0007-of-0011.json.zip"

echo "[340/1710] Downloading: 2011 Q1 (part 8 of 11) (77.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0008-of-0011.json.zip"

echo "[341/1710] Downloading: 2011 Q1 (part 9 of 11) (124.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0009-of-0011.json.zip"

echo "[342/1710] Downloading: 2011 Q1 (part 10 of 11) (117.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0010-of-0011.json.zip"

echo "[343/1710] Downloading: 2011 Q1 (part 11 of 11) (115.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q1/drug-event-0011-of-0011.json.zip"

echo "[344/1710] Downloading: 2014 Q3 (part 1 of 17) (94.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0001-of-0017.json.zip"

echo "[345/1710] Downloading: 2014 Q3 (part 2 of 17) (32.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0002-of-0017.json.zip"

echo "[346/1710] Downloading: 2014 Q3 (part 3 of 17) (11.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0003-of-0017.json.zip"

echo "[347/1710] Downloading: 2014 Q3 (part 4 of 17) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0004-of-0017.json.zip"

echo "[348/1710] Downloading: 2014 Q3 (part 5 of 17) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0005-of-0017.json.zip"

echo "[349/1710] Downloading: 2014 Q3 (part 6 of 17) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0006-of-0017.json.zip"

echo "[350/1710] Downloading: 2014 Q3 (part 7 of 17) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0007-of-0017.json.zip"

echo "[351/1710] Downloading: 2014 Q3 (part 8 of 17) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0008-of-0017.json.zip"

echo "[352/1710] Downloading: 2014 Q3 (part 9 of 17) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0009-of-0017.json.zip"

echo "[353/1710] Downloading: 2014 Q3 (part 10 of 17) (10.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0010-of-0017.json.zip"

echo "[354/1710] Downloading: 2014 Q3 (part 11 of 17) (20.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0011-of-0017.json.zip"

echo "[355/1710] Downloading: 2014 Q3 (part 12 of 17) (43.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0012-of-0017.json.zip"

echo "[356/1710] Downloading: 2014 Q3 (part 13 of 17) (76.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0013-of-0017.json.zip"

echo "[357/1710] Downloading: 2014 Q3 (part 14 of 17) (111.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0014-of-0017.json.zip"

echo "[358/1710] Downloading: 2014 Q3 (part 15 of 17) (117.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0015-of-0017.json.zip"

echo "[359/1710] Downloading: 2014 Q3 (part 16 of 17) (118.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0016-of-0017.json.zip"

echo "[360/1710] Downloading: 2014 Q3 (part 17 of 17) (60.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q3/drug-event-0017-of-0017.json.zip"

echo "[361/1710] Downloading: 2022 Q2 (part 1 of 31) (98.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0001-of-0031.json.zip"

echo "[362/1710] Downloading: 2022 Q2 (part 2 of 31) (142.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0002-of-0031.json.zip"

echo "[363/1710] Downloading: 2022 Q2 (part 3 of 31) (15.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0003-of-0031.json.zip"

echo "[364/1710] Downloading: 2022 Q2 (part 4 of 31) (15.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0004-of-0031.json.zip"

echo "[365/1710] Downloading: 2022 Q2 (part 5 of 31) (8.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0005-of-0031.json.zip"

echo "[366/1710] Downloading: 2022 Q2 (part 6 of 31) (75.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0006-of-0031.json.zip"

echo "[367/1710] Downloading: 2022 Q2 (part 7 of 31) (44.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0007-of-0031.json.zip"

echo "[368/1710] Downloading: 2022 Q2 (part 8 of 31) (5.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0008-of-0031.json.zip"

echo "[369/1710] Downloading: 2022 Q2 (part 9 of 31) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0009-of-0031.json.zip"

echo "[370/1710] Downloading: 2022 Q2 (part 10 of 31) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0010-of-0031.json.zip"

echo "[371/1710] Downloading: 2022 Q2 (part 11 of 31) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0011-of-0031.json.zip"

echo "[372/1710] Downloading: 2022 Q2 (part 12 of 31) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0012-of-0031.json.zip"

echo "[373/1710] Downloading: 2022 Q2 (part 13 of 31) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0013-of-0031.json.zip"

echo "[374/1710] Downloading: 2022 Q2 (part 14 of 31) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0014-of-0031.json.zip"

echo "[375/1710] Downloading: 2022 Q2 (part 15 of 31) (5.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0015-of-0031.json.zip"

echo "[376/1710] Downloading: 2022 Q2 (part 16 of 31) (8.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0016-of-0031.json.zip"

echo "[377/1710] Downloading: 2022 Q2 (part 17 of 31) (11.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0017-of-0031.json.zip"

echo "[378/1710] Downloading: 2022 Q2 (part 18 of 31) (16.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0018-of-0031.json.zip"

echo "[379/1710] Downloading: 2022 Q2 (part 19 of 31) (17.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0019-of-0031.json.zip"

echo "[380/1710] Downloading: 2022 Q2 (part 20 of 31) (55.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0020-of-0031.json.zip"

echo "[381/1710] Downloading: 2022 Q2 (part 21 of 31) (59.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0021-of-0031.json.zip"

echo "[382/1710] Downloading: 2022 Q2 (part 22 of 31) (156.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0022-of-0031.json.zip"

echo "[383/1710] Downloading: 2022 Q2 (part 23 of 31) (189.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0023-of-0031.json.zip"

echo "[384/1710] Downloading: 2022 Q2 (part 24 of 31) (185.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0024-of-0031.json.zip"

echo "[385/1710] Downloading: 2022 Q2 (part 25 of 31) (179.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0025-of-0031.json.zip"

echo "[386/1710] Downloading: 2022 Q2 (part 26 of 31) (181.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0026-of-0031.json.zip"

echo "[387/1710] Downloading: 2022 Q2 (part 27 of 31) (183.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0027-of-0031.json.zip"

echo "[388/1710] Downloading: 2022 Q2 (part 28 of 31) (171.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0028-of-0031.json.zip"

echo "[389/1710] Downloading: 2022 Q2 (part 29 of 31) (169.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0029-of-0031.json.zip"

echo "[390/1710] Downloading: 2022 Q2 (part 30 of 31) (183.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0030-of-0031.json.zip"

echo "[391/1710] Downloading: 2022 Q2 (part 31 of 31) (53.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q2/drug-event-0031-of-0031.json.zip"

echo "[392/1710] Downloading: 2012 Q2 (part 1 of 11) (107.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0001-of-0011.json.zip"

echo "[393/1710] Downloading: 2012 Q2 (part 2 of 11) (46.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0002-of-0011.json.zip"

echo "[394/1710] Downloading: 2012 Q2 (part 3 of 11) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0003-of-0011.json.zip"

echo "[395/1710] Downloading: 2012 Q2 (part 4 of 11) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0004-of-0011.json.zip"

echo "[396/1710] Downloading: 2012 Q2 (part 5 of 11) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0005-of-0011.json.zip"

echo "[397/1710] Downloading: 2012 Q2 (part 6 of 11) (10.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0006-of-0011.json.zip"

echo "[398/1710] Downloading: 2012 Q2 (part 7 of 11) (53.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0007-of-0011.json.zip"

echo "[399/1710] Downloading: 2012 Q2 (part 8 of 11) (127.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0008-of-0011.json.zip"

echo "[400/1710] Downloading: 2012 Q2 (part 9 of 11) (138.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0009-of-0011.json.zip"

echo "[401/1710] Downloading: 2012 Q2 (part 10 of 11) (132.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0010-of-0011.json.zip"

echo "[402/1710] Downloading: 2012 Q2 (part 11 of 11) (100.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q2/drug-event-0011-of-0011.json.zip"

echo "[403/1710] Downloading: 2021 Q4 (part 1 of 31) (139.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0001-of-0031.json.zip"

echo "[404/1710] Downloading: 2021 Q4 (part 2 of 31) (133.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0002-of-0031.json.zip"

echo "[405/1710] Downloading: 2021 Q4 (part 3 of 31) (123.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0003-of-0031.json.zip"

echo "[406/1710] Downloading: 2021 Q4 (part 4 of 31) (13.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0004-of-0031.json.zip"

echo "[407/1710] Downloading: 2021 Q4 (part 5 of 31) (22.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0005-of-0031.json.zip"

echo "[408/1710] Downloading: 2021 Q4 (part 6 of 31) (57.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0006-of-0031.json.zip"

echo "[409/1710] Downloading: 2021 Q4 (part 7 of 31) (40.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0007-of-0031.json.zip"

echo "[410/1710] Downloading: 2021 Q4 (part 8 of 31) (6.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0008-of-0031.json.zip"

echo "[411/1710] Downloading: 2021 Q4 (part 9 of 31) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0009-of-0031.json.zip"

echo "[412/1710] Downloading: 2021 Q4 (part 10 of 31) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0010-of-0031.json.zip"

echo "[413/1710] Downloading: 2021 Q4 (part 11 of 31) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0011-of-0031.json.zip"

echo "[414/1710] Downloading: 2021 Q4 (part 12 of 31) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0012-of-0031.json.zip"

echo "[415/1710] Downloading: 2021 Q4 (part 13 of 31) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0013-of-0031.json.zip"

echo "[416/1710] Downloading: 2021 Q4 (part 14 of 31) (6.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0014-of-0031.json.zip"

echo "[417/1710] Downloading: 2021 Q4 (part 15 of 31) (6.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0015-of-0031.json.zip"

echo "[418/1710] Downloading: 2021 Q4 (part 16 of 31) (10.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0016-of-0031.json.zip"

echo "[419/1710] Downloading: 2021 Q4 (part 17 of 31) (13.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0017-of-0031.json.zip"

echo "[420/1710] Downloading: 2021 Q4 (part 18 of 31) (15.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0018-of-0031.json.zip"

echo "[421/1710] Downloading: 2021 Q4 (part 19 of 31) (20.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0019-of-0031.json.zip"

echo "[422/1710] Downloading: 2021 Q4 (part 20 of 31) (49.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0020-of-0031.json.zip"

echo "[423/1710] Downloading: 2021 Q4 (part 21 of 31) (58.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0021-of-0031.json.zip"

echo "[424/1710] Downloading: 2021 Q4 (part 22 of 31) (154.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0022-of-0031.json.zip"

echo "[425/1710] Downloading: 2021 Q4 (part 23 of 31) (152.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0023-of-0031.json.zip"

echo "[426/1710] Downloading: 2021 Q4 (part 24 of 31) (166.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0024-of-0031.json.zip"

echo "[427/1710] Downloading: 2021 Q4 (part 25 of 31) (168.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0025-of-0031.json.zip"

echo "[428/1710] Downloading: 2021 Q4 (part 26 of 31) (171.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0026-of-0031.json.zip"

echo "[429/1710] Downloading: 2021 Q4 (part 27 of 31) (172.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0027-of-0031.json.zip"

echo "[430/1710] Downloading: 2021 Q4 (part 28 of 31) (159.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0028-of-0031.json.zip"

echo "[431/1710] Downloading: 2021 Q4 (part 29 of 31) (167.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0029-of-0031.json.zip"

echo "[432/1710] Downloading: 2021 Q4 (part 30 of 31) (165.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0030-of-0031.json.zip"

echo "[433/1710] Downloading: 2021 Q4 (part 31 of 31) (107.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q4/drug-event-0031-of-0031.json.zip"

echo "[434/1710] Downloading: 2006 Q1 (part 1 of 6) (59.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q1/drug-event-0001-of-0006.json.zip"

echo "[435/1710] Downloading: 2006 Q1 (part 2 of 6) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q1/drug-event-0002-of-0006.json.zip"

echo "[436/1710] Downloading: 2006 Q1 (part 3 of 6) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q1/drug-event-0003-of-0006.json.zip"

echo "[437/1710] Downloading: 2006 Q1 (part 4 of 6) (60.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q1/drug-event-0004-of-0006.json.zip"

echo "[438/1710] Downloading: 2006 Q1 (part 5 of 6) (126.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q1/drug-event-0005-of-0006.json.zip"

echo "[439/1710] Downloading: 2006 Q1 (part 6 of 6) (29.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q1/drug-event-0006-of-0006.json.zip"

echo "[440/1710] Downloading: 2020 Q2 (part 1 of 30) (128.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0001-of-0030.json.zip"

echo "[441/1710] Downloading: 2020 Q2 (part 2 of 30) (123.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0002-of-0030.json.zip"

echo "[442/1710] Downloading: 2020 Q2 (part 3 of 30) (56.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0003-of-0030.json.zip"

echo "[443/1710] Downloading: 2020 Q2 (part 4 of 30) (12.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0004-of-0030.json.zip"

echo "[444/1710] Downloading: 2020 Q2 (part 5 of 30) (16.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0005-of-0030.json.zip"

echo "[445/1710] Downloading: 2020 Q2 (part 6 of 30) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0006-of-0030.json.zip"

echo "[446/1710] Downloading: 2020 Q2 (part 7 of 30) (6.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0007-of-0030.json.zip"

echo "[447/1710] Downloading: 2020 Q2 (part 8 of 30) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0008-of-0030.json.zip"

echo "[448/1710] Downloading: 2020 Q2 (part 9 of 30) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0009-of-0030.json.zip"

echo "[449/1710] Downloading: 2020 Q2 (part 10 of 30) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0010-of-0030.json.zip"

echo "[450/1710] Downloading: 2020 Q2 (part 11 of 30) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0011-of-0030.json.zip"

echo "[451/1710] Downloading: 2020 Q2 (part 12 of 30) (5.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0012-of-0030.json.zip"

echo "[452/1710] Downloading: 2020 Q2 (part 13 of 30) (6.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0013-of-0030.json.zip"

echo "[453/1710] Downloading: 2020 Q2 (part 14 of 30) (11.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0014-of-0030.json.zip"

echo "[454/1710] Downloading: 2020 Q2 (part 15 of 30) (11.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0015-of-0030.json.zip"

echo "[455/1710] Downloading: 2020 Q2 (part 16 of 30) (10.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0016-of-0030.json.zip"

echo "[456/1710] Downloading: 2020 Q2 (part 17 of 30) (11.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0017-of-0030.json.zip"

echo "[457/1710] Downloading: 2020 Q2 (part 18 of 30) (29.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0018-of-0030.json.zip"

echo "[458/1710] Downloading: 2020 Q2 (part 19 of 30) (34.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0019-of-0030.json.zip"

echo "[459/1710] Downloading: 2020 Q2 (part 20 of 30) (49.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0020-of-0030.json.zip"

echo "[460/1710] Downloading: 2020 Q2 (part 21 of 30) (88.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0021-of-0030.json.zip"

echo "[461/1710] Downloading: 2020 Q2 (part 22 of 30) (136.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0022-of-0030.json.zip"

echo "[462/1710] Downloading: 2020 Q2 (part 23 of 30) (134.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0023-of-0030.json.zip"

echo "[463/1710] Downloading: 2020 Q2 (part 24 of 30) (133.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0024-of-0030.json.zip"

echo "[464/1710] Downloading: 2020 Q2 (part 25 of 30) (130.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0025-of-0030.json.zip"

echo "[465/1710] Downloading: 2020 Q2 (part 26 of 30) (137.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0026-of-0030.json.zip"

echo "[466/1710] Downloading: 2020 Q2 (part 27 of 30) (133.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0027-of-0030.json.zip"

echo "[467/1710] Downloading: 2020 Q2 (part 28 of 30) (132.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0028-of-0030.json.zip"

echo "[468/1710] Downloading: 2020 Q2 (part 29 of 30) (138.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0029-of-0030.json.zip"

echo "[469/1710] Downloading: 2020 Q2 (part 30 of 30) (58.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q2/drug-event-0030-of-0030.json.zip"

echo "[470/1710] Downloading: 2021 Q3 (part 1 of 36) (128.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0001-of-0036.json.zip"

echo "[471/1710] Downloading: 2021 Q3 (part 2 of 36) (144.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0002-of-0036.json.zip"

echo "[472/1710] Downloading: 2021 Q3 (part 3 of 36) (71.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0003-of-0036.json.zip"

echo "[473/1710] Downloading: 2021 Q3 (part 4 of 36) (16.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0004-of-0036.json.zip"

echo "[474/1710] Downloading: 2021 Q3 (part 5 of 36) (11.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0005-of-0036.json.zip"

echo "[475/1710] Downloading: 2021 Q3 (part 6 of 36) (12.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0006-of-0036.json.zip"

echo "[476/1710] Downloading: 2021 Q3 (part 7 of 36) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0007-of-0036.json.zip"

echo "[477/1710] Downloading: 2021 Q3 (part 8 of 36) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0008-of-0036.json.zip"

echo "[478/1710] Downloading: 2021 Q3 (part 9 of 36) (1.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0009-of-0036.json.zip"

echo "[479/1710] Downloading: 2021 Q3 (part 10 of 36) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0010-of-0036.json.zip"

echo "[480/1710] Downloading: 2021 Q3 (part 11 of 36) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0011-of-0036.json.zip"

echo "[481/1710] Downloading: 2021 Q3 (part 12 of 36) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0012-of-0036.json.zip"

echo "[482/1710] Downloading: 2021 Q3 (part 13 of 36) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0013-of-0036.json.zip"

echo "[483/1710] Downloading: 2021 Q3 (part 14 of 36) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0014-of-0036.json.zip"

echo "[484/1710] Downloading: 2021 Q3 (part 15 of 36) (2.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0015-of-0036.json.zip"

echo "[485/1710] Downloading: 2021 Q3 (part 16 of 36) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0016-of-0036.json.zip"

echo "[486/1710] Downloading: 2021 Q3 (part 17 of 36) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0017-of-0036.json.zip"

echo "[487/1710] Downloading: 2021 Q3 (part 18 of 36) (5.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0018-of-0036.json.zip"

echo "[488/1710] Downloading: 2021 Q3 (part 19 of 36) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0019-of-0036.json.zip"

echo "[489/1710] Downloading: 2021 Q3 (part 20 of 36) (6.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0020-of-0036.json.zip"

echo "[490/1710] Downloading: 2021 Q3 (part 21 of 36) (12.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0021-of-0036.json.zip"

echo "[491/1710] Downloading: 2021 Q3 (part 22 of 36) (10.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0022-of-0036.json.zip"

echo "[492/1710] Downloading: 2021 Q3 (part 23 of 36) (12.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0023-of-0036.json.zip"

echo "[493/1710] Downloading: 2021 Q3 (part 24 of 36) (10.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0024-of-0036.json.zip"

echo "[494/1710] Downloading: 2021 Q3 (part 25 of 36) (36.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0025-of-0036.json.zip"

echo "[495/1710] Downloading: 2021 Q3 (part 26 of 36) (35.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0026-of-0036.json.zip"

echo "[496/1710] Downloading: 2021 Q3 (part 27 of 36) (90.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0027-of-0036.json.zip"

echo "[497/1710] Downloading: 2021 Q3 (part 28 of 36) (136.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0028-of-0036.json.zip"

echo "[498/1710] Downloading: 2021 Q3 (part 29 of 36) (134.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0029-of-0036.json.zip"

echo "[499/1710] Downloading: 2021 Q3 (part 30 of 36) (133.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0030-of-0036.json.zip"

echo "[500/1710] Downloading: 2021 Q3 (part 31 of 36) (140.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0031-of-0036.json.zip"

echo "[501/1710] Downloading: 2021 Q3 (part 32 of 36) (141.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0032-of-0036.json.zip"

echo "[502/1710] Downloading: 2021 Q3 (part 33 of 36) (141.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0033-of-0036.json.zip"

echo "[503/1710] Downloading: 2021 Q3 (part 34 of 36) (140.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0034-of-0036.json.zip"

echo "[504/1710] Downloading: 2021 Q3 (part 35 of 36) (146.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0035-of-0036.json.zip"

echo "[505/1710] Downloading: 2021 Q3 (part 36 of 36) (78.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q3/drug-event-0036-of-0036.json.zip"

echo "[506/1710] Downloading: 2024 Q3 (part 1 of 29) (47.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0001-of-0029.json.zip"

echo "[507/1710] Downloading: 2024 Q3 (part 2 of 29) (46.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0002-of-0029.json.zip"

echo "[508/1710] Downloading: 2024 Q3 (part 3 of 29) (123.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0003-of-0029.json.zip"

echo "[509/1710] Downloading: 2024 Q3 (part 4 of 29) (63.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0004-of-0029.json.zip"

echo "[510/1710] Downloading: 2024 Q3 (part 5 of 29) (19.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0005-of-0029.json.zip"

echo "[511/1710] Downloading: 2024 Q3 (part 6 of 29) (12.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0006-of-0029.json.zip"

echo "[512/1710] Downloading: 2024 Q3 (part 7 of 29) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0007-of-0029.json.zip"

echo "[513/1710] Downloading: 2024 Q3 (part 8 of 29) (6.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0008-of-0029.json.zip"

echo "[514/1710] Downloading: 2024 Q3 (part 9 of 29) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0009-of-0029.json.zip"

echo "[515/1710] Downloading: 2024 Q3 (part 10 of 29) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0010-of-0029.json.zip"

echo "[516/1710] Downloading: 2024 Q3 (part 11 of 29) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0011-of-0029.json.zip"

echo "[517/1710] Downloading: 2024 Q3 (part 12 of 29) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0012-of-0029.json.zip"

echo "[518/1710] Downloading: 2024 Q3 (part 13 of 29) (7.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0013-of-0029.json.zip"

echo "[519/1710] Downloading: 2024 Q3 (part 14 of 29) (14.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0014-of-0029.json.zip"

echo "[520/1710] Downloading: 2024 Q3 (part 15 of 29) (30.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0015-of-0029.json.zip"

echo "[521/1710] Downloading: 2024 Q3 (part 16 of 29) (33.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0016-of-0029.json.zip"

echo "[522/1710] Downloading: 2024 Q3 (part 17 of 29) (42.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0017-of-0029.json.zip"

echo "[523/1710] Downloading: 2024 Q3 (part 18 of 29) (163.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0018-of-0029.json.zip"

echo "[524/1710] Downloading: 2024 Q3 (part 19 of 29) (97.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0019-of-0029.json.zip"

echo "[525/1710] Downloading: 2024 Q3 (part 20 of 29) (162.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0020-of-0029.json.zip"

echo "[526/1710] Downloading: 2024 Q3 (part 21 of 29) (180.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0021-of-0029.json.zip"

echo "[527/1710] Downloading: 2024 Q3 (part 22 of 29) (180.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0022-of-0029.json.zip"

echo "[528/1710] Downloading: 2024 Q3 (part 23 of 29) (182.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0023-of-0029.json.zip"

echo "[529/1710] Downloading: 2024 Q3 (part 24 of 29) (174.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0024-of-0029.json.zip"

echo "[530/1710] Downloading: 2024 Q3 (part 25 of 29) (181.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0025-of-0029.json.zip"

echo "[531/1710] Downloading: 2024 Q3 (part 26 of 29) (187.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0026-of-0029.json.zip"

echo "[532/1710] Downloading: 2024 Q3 (part 27 of 29) (173.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0027-of-0029.json.zip"

echo "[533/1710] Downloading: 2024 Q3 (part 28 of 29) (177.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0028-of-0029.json.zip"

echo "[534/1710] Downloading: 2024 Q3 (part 29 of 29) (164.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q3/drug-event-0029-of-0029.json.zip"

echo "[535/1710] Downloading: 2007 Q4 (part 1 of 7) (68.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q4/drug-event-0001-of-0007.json.zip"

echo "[536/1710] Downloading: 2007 Q4 (part 2 of 7) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q4/drug-event-0002-of-0007.json.zip"

echo "[537/1710] Downloading: 2007 Q4 (part 3 of 7) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q4/drug-event-0003-of-0007.json.zip"

echo "[538/1710] Downloading: 2007 Q4 (part 4 of 7) (28.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q4/drug-event-0004-of-0007.json.zip"

echo "[539/1710] Downloading: 2007 Q4 (part 5 of 7) (87.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q4/drug-event-0005-of-0007.json.zip"

echo "[540/1710] Downloading: 2007 Q4 (part 6 of 7) (98.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q4/drug-event-0006-of-0007.json.zip"

echo "[541/1710] Downloading: 2007 Q4 (part 7 of 7) (17.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q4/drug-event-0007-of-0007.json.zip"

echo "[542/1710] Downloading: 2006 Q2 (part 1 of 5) (52.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q2/drug-event-0001-of-0005.json.zip"

echo "[543/1710] Downloading: 2006 Q2 (part 2 of 5) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q2/drug-event-0002-of-0005.json.zip"

echo "[544/1710] Downloading: 2006 Q2 (part 3 of 5) (7.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q2/drug-event-0003-of-0005.json.zip"

echo "[545/1710] Downloading: 2006 Q2 (part 4 of 5) (91.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q2/drug-event-0004-of-0005.json.zip"

echo "[546/1710] Downloading: 2006 Q2 (part 5 of 5) (88.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q2/drug-event-0005-of-0005.json.zip"

echo "[547/1710] Downloading: 2023 Q1 (part 1 of 30) (135.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0001-of-0030.json.zip"

echo "[548/1710] Downloading: 2023 Q1 (part 2 of 30) (96.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0002-of-0030.json.zip"

echo "[549/1710] Downloading: 2023 Q1 (part 3 of 30) (8.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0003-of-0030.json.zip"

echo "[550/1710] Downloading: 2023 Q1 (part 4 of 30) (29.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0004-of-0030.json.zip"

echo "[551/1710] Downloading: 2023 Q1 (part 5 of 30) (147.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0005-of-0030.json.zip"

echo "[552/1710] Downloading: 2023 Q1 (part 6 of 30) (73.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0006-of-0030.json.zip"

echo "[553/1710] Downloading: 2023 Q1 (part 7 of 30) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0007-of-0030.json.zip"

echo "[554/1710] Downloading: 2023 Q1 (part 8 of 30) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0008-of-0030.json.zip"

echo "[555/1710] Downloading: 2023 Q1 (part 9 of 30) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0009-of-0030.json.zip"

echo "[556/1710] Downloading: 2023 Q1 (part 10 of 30) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0010-of-0030.json.zip"

echo "[557/1710] Downloading: 2023 Q1 (part 11 of 30) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0011-of-0030.json.zip"

echo "[558/1710] Downloading: 2023 Q1 (part 12 of 30) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0012-of-0030.json.zip"

echo "[559/1710] Downloading: 2023 Q1 (part 13 of 30) (5.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0013-of-0030.json.zip"

echo "[560/1710] Downloading: 2023 Q1 (part 14 of 30) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0014-of-0030.json.zip"

echo "[561/1710] Downloading: 2023 Q1 (part 15 of 30) (9.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0015-of-0030.json.zip"

echo "[562/1710] Downloading: 2023 Q1 (part 16 of 30) (15.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0016-of-0030.json.zip"

echo "[563/1710] Downloading: 2023 Q1 (part 17 of 30) (15.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0017-of-0030.json.zip"

echo "[564/1710] Downloading: 2023 Q1 (part 18 of 30) (23.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0018-of-0030.json.zip"

echo "[565/1710] Downloading: 2023 Q1 (part 19 of 30) (49.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0019-of-0030.json.zip"

echo "[566/1710] Downloading: 2023 Q1 (part 20 of 30) (56.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0020-of-0030.json.zip"

echo "[567/1710] Downloading: 2023 Q1 (part 21 of 30) (193.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0021-of-0030.json.zip"

echo "[568/1710] Downloading: 2023 Q1 (part 22 of 30) (165.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0022-of-0030.json.zip"

echo "[569/1710] Downloading: 2023 Q1 (part 23 of 30) (187.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0023-of-0030.json.zip"

echo "[570/1710] Downloading: 2023 Q1 (part 24 of 30) (194.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0024-of-0030.json.zip"

echo "[571/1710] Downloading: 2023 Q1 (part 25 of 30) (180.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0025-of-0030.json.zip"

echo "[572/1710] Downloading: 2023 Q1 (part 26 of 30) (183.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0026-of-0030.json.zip"

echo "[573/1710] Downloading: 2023 Q1 (part 27 of 30) (179.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0027-of-0030.json.zip"

echo "[574/1710] Downloading: 2023 Q1 (part 28 of 30) (184.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0028-of-0030.json.zip"

echo "[575/1710] Downloading: 2023 Q1 (part 29 of 30) (192.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0029-of-0030.json.zip"

echo "[576/1710] Downloading: 2023 Q1 (part 30 of 30) (141.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q1/drug-event-0030-of-0030.json.zip"

echo "[577/1710] Downloading: 2009 Q3 (part 1 of 8) (83.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0001-of-0008.json.zip"

echo "[578/1710] Downloading: 2009 Q3 (part 2 of 8) (14.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0002-of-0008.json.zip"

echo "[579/1710] Downloading: 2009 Q3 (part 3 of 8) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0003-of-0008.json.zip"

echo "[580/1710] Downloading: 2009 Q3 (part 4 of 8) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0004-of-0008.json.zip"

echo "[581/1710] Downloading: 2009 Q3 (part 5 of 8) (31.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0005-of-0008.json.zip"

echo "[582/1710] Downloading: 2009 Q3 (part 6 of 8) (86.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0006-of-0008.json.zip"

echo "[583/1710] Downloading: 2009 Q3 (part 7 of 8) (120.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0007-of-0008.json.zip"

echo "[584/1710] Downloading: 2009 Q3 (part 8 of 8) (95.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q3/drug-event-0008-of-0008.json.zip"

echo "[585/1710] Downloading: 2004 Q2 (part 1 of 5) (51.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q2/drug-event-0001-of-0005.json.zip"

echo "[586/1710] Downloading: 2004 Q2 (part 2 of 5) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q2/drug-event-0002-of-0005.json.zip"

echo "[587/1710] Downloading: 2004 Q2 (part 3 of 5) (29.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q2/drug-event-0003-of-0005.json.zip"

echo "[588/1710] Downloading: 2004 Q2 (part 4 of 5) (123.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q2/drug-event-0004-of-0005.json.zip"

echo "[589/1710] Downloading: 2004 Q2 (part 5 of 5) (35.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q2/drug-event-0005-of-0005.json.zip"

echo "[590/1710] Downloading: 2012 Q4 (part 1 of 15) (77.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0001-of-0015.json.zip"

echo "[591/1710] Downloading: 2012 Q4 (part 2 of 15) (33.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0002-of-0015.json.zip"

echo "[592/1710] Downloading: 2012 Q4 (part 3 of 15) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0003-of-0015.json.zip"

echo "[593/1710] Downloading: 2012 Q4 (part 4 of 15) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0004-of-0015.json.zip"

echo "[594/1710] Downloading: 2012 Q4 (part 5 of 15) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0005-of-0015.json.zip"

echo "[595/1710] Downloading: 2012 Q4 (part 6 of 15) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0006-of-0015.json.zip"

echo "[596/1710] Downloading: 2012 Q4 (part 7 of 15) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0007-of-0015.json.zip"

echo "[597/1710] Downloading: 2012 Q4 (part 8 of 15) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0008-of-0015.json.zip"

echo "[598/1710] Downloading: 2012 Q4 (part 9 of 15) (7.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0009-of-0015.json.zip"

echo "[599/1710] Downloading: 2012 Q4 (part 10 of 15) (20.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0010-of-0015.json.zip"

echo "[600/1710] Downloading: 2012 Q4 (part 11 of 15) (36.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0011-of-0015.json.zip"

echo "[601/1710] Downloading: 2012 Q4 (part 12 of 15) (91.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0012-of-0015.json.zip"

echo "[602/1710] Downloading: 2012 Q4 (part 13 of 15) (96.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0013-of-0015.json.zip"

echo "[603/1710] Downloading: 2012 Q4 (part 14 of 15) (100.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0014-of-0015.json.zip"

echo "[604/1710] Downloading: 2012 Q4 (part 15 of 15) (53.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q4/drug-event-0015-of-0015.json.zip"

echo "[605/1710] Downloading: 2014 Q4 (part 1 of 17) (81.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0001-of-0017.json.zip"

echo "[606/1710] Downloading: 2014 Q4 (part 2 of 17) (58.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0002-of-0017.json.zip"

echo "[607/1710] Downloading: 2014 Q4 (part 3 of 17) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0003-of-0017.json.zip"

echo "[608/1710] Downloading: 2014 Q4 (part 4 of 17) (7.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0004-of-0017.json.zip"

echo "[609/1710] Downloading: 2014 Q4 (part 5 of 17) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0005-of-0017.json.zip"

echo "[610/1710] Downloading: 2014 Q4 (part 6 of 17) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0006-of-0017.json.zip"

echo "[611/1710] Downloading: 2014 Q4 (part 7 of 17) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0007-of-0017.json.zip"

echo "[612/1710] Downloading: 2014 Q4 (part 8 of 17) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0008-of-0017.json.zip"

echo "[613/1710] Downloading: 2014 Q4 (part 9 of 17) (5.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0009-of-0017.json.zip"

echo "[614/1710] Downloading: 2014 Q4 (part 10 of 17) (11.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0010-of-0017.json.zip"

echo "[615/1710] Downloading: 2014 Q4 (part 11 of 17) (19.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0011-of-0017.json.zip"

echo "[616/1710] Downloading: 2014 Q4 (part 12 of 17) (44.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0012-of-0017.json.zip"

echo "[617/1710] Downloading: 2014 Q4 (part 13 of 17) (80.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0013-of-0017.json.zip"

echo "[618/1710] Downloading: 2014 Q4 (part 14 of 17) (116.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0014-of-0017.json.zip"

echo "[619/1710] Downloading: 2014 Q4 (part 15 of 17) (129.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0015-of-0017.json.zip"

echo "[620/1710] Downloading: 2014 Q4 (part 16 of 17) (122.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0016-of-0017.json.zip"

echo "[621/1710] Downloading: 2014 Q4 (part 17 of 17) (38.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q4/drug-event-0017-of-0017.json.zip"

echo "[622/1710] Downloading: 2021 Q2 (part 1 of 34) (125.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0001-of-0034.json.zip"

echo "[623/1710] Downloading: 2021 Q2 (part 2 of 34) (136.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0002-of-0034.json.zip"

echo "[624/1710] Downloading: 2021 Q2 (part 3 of 34) (79.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0003-of-0034.json.zip"

echo "[625/1710] Downloading: 2021 Q2 (part 4 of 34) (14.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0004-of-0034.json.zip"

echo "[626/1710] Downloading: 2021 Q2 (part 5 of 34) (17.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0005-of-0034.json.zip"

echo "[627/1710] Downloading: 2021 Q2 (part 6 of 34) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0006-of-0034.json.zip"

echo "[628/1710] Downloading: 2021 Q2 (part 7 of 34) (5.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0007-of-0034.json.zip"

echo "[629/1710] Downloading: 2021 Q2 (part 8 of 34) (2.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0008-of-0034.json.zip"

echo "[630/1710] Downloading: 2021 Q2 (part 9 of 34) (7.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0009-of-0034.json.zip"

echo "[631/1710] Downloading: 2021 Q2 (part 10 of 34) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0010-of-0034.json.zip"

echo "[632/1710] Downloading: 2021 Q2 (part 11 of 34) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0011-of-0034.json.zip"

echo "[633/1710] Downloading: 2021 Q2 (part 12 of 34) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0012-of-0034.json.zip"

echo "[634/1710] Downloading: 2021 Q2 (part 13 of 34) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0013-of-0034.json.zip"

echo "[635/1710] Downloading: 2021 Q2 (part 14 of 34) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0014-of-0034.json.zip"

echo "[636/1710] Downloading: 2021 Q2 (part 15 of 34) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0015-of-0034.json.zip"

echo "[637/1710] Downloading: 2021 Q2 (part 16 of 34) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0016-of-0034.json.zip"

echo "[638/1710] Downloading: 2021 Q2 (part 17 of 34) (8.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0017-of-0034.json.zip"

echo "[639/1710] Downloading: 2021 Q2 (part 18 of 34) (11.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0018-of-0034.json.zip"

echo "[640/1710] Downloading: 2021 Q2 (part 19 of 34) (11.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0019-of-0034.json.zip"

echo "[641/1710] Downloading: 2021 Q2 (part 20 of 34) (12.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0020-of-0034.json.zip"

echo "[642/1710] Downloading: 2021 Q2 (part 21 of 34) (12.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0021-of-0034.json.zip"

echo "[643/1710] Downloading: 2021 Q2 (part 22 of 34) (44.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0022-of-0034.json.zip"

echo "[644/1710] Downloading: 2021 Q2 (part 23 of 34) (38.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0023-of-0034.json.zip"

echo "[645/1710] Downloading: 2021 Q2 (part 24 of 34) (86.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0024-of-0034.json.zip"

echo "[646/1710] Downloading: 2021 Q2 (part 25 of 34) (134.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0025-of-0034.json.zip"

echo "[647/1710] Downloading: 2021 Q2 (part 26 of 34) (126.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0026-of-0034.json.zip"

echo "[648/1710] Downloading: 2021 Q2 (part 27 of 34) (132.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0027-of-0034.json.zip"

echo "[649/1710] Downloading: 2021 Q2 (part 28 of 34) (133.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0028-of-0034.json.zip"

echo "[650/1710] Downloading: 2021 Q2 (part 29 of 34) (135.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0029-of-0034.json.zip"

echo "[651/1710] Downloading: 2021 Q2 (part 30 of 34) (132.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0030-of-0034.json.zip"

echo "[652/1710] Downloading: 2021 Q2 (part 31 of 34) (131.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0031-of-0034.json.zip"

echo "[653/1710] Downloading: 2021 Q2 (part 32 of 34) (128.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0032-of-0034.json.zip"

echo "[654/1710] Downloading: 2021 Q2 (part 33 of 34) (135.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0033-of-0034.json.zip"

echo "[655/1710] Downloading: 2021 Q2 (part 34 of 34) (46.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q2/drug-event-0034-of-0034.json.zip"

echo "[656/1710] Downloading: 2017 Q4 (part 1 of 25) (14.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0001-of-0025.json.zip"

echo "[657/1710] Downloading: 2017 Q4 (part 2 of 25) (18.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0002-of-0025.json.zip"

echo "[658/1710] Downloading: 2017 Q4 (part 3 of 25) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0003-of-0025.json.zip"

echo "[659/1710] Downloading: 2017 Q4 (part 4 of 25) (16.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0004-of-0025.json.zip"

echo "[660/1710] Downloading: 2017 Q4 (part 5 of 25) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0005-of-0025.json.zip"

echo "[661/1710] Downloading: 2017 Q4 (part 6 of 25) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0006-of-0025.json.zip"

echo "[662/1710] Downloading: 2017 Q4 (part 7 of 25) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0007-of-0025.json.zip"

echo "[663/1710] Downloading: 2017 Q4 (part 8 of 25) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0008-of-0025.json.zip"

echo "[664/1710] Downloading: 2017 Q4 (part 9 of 25) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0009-of-0025.json.zip"

echo "[665/1710] Downloading: 2017 Q4 (part 10 of 25) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0010-of-0025.json.zip"

echo "[666/1710] Downloading: 2017 Q4 (part 11 of 25) (6.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0011-of-0025.json.zip"

echo "[667/1710] Downloading: 2017 Q4 (part 12 of 25) (10.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0012-of-0025.json.zip"

echo "[668/1710] Downloading: 2017 Q4 (part 13 of 25) (13.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0013-of-0025.json.zip"

echo "[669/1710] Downloading: 2017 Q4 (part 14 of 25) (15.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0014-of-0025.json.zip"

echo "[670/1710] Downloading: 2017 Q4 (part 15 of 25) (48.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0015-of-0025.json.zip"

echo "[671/1710] Downloading: 2017 Q4 (part 16 of 25) (50.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0016-of-0025.json.zip"

echo "[672/1710] Downloading: 2017 Q4 (part 17 of 25) (60.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0017-of-0025.json.zip"

echo "[673/1710] Downloading: 2017 Q4 (part 18 of 25) (134.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0018-of-0025.json.zip"

echo "[674/1710] Downloading: 2017 Q4 (part 19 of 25) (151.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0019-of-0025.json.zip"

echo "[675/1710] Downloading: 2017 Q4 (part 20 of 25) (145.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0020-of-0025.json.zip"

echo "[676/1710] Downloading: 2017 Q4 (part 21 of 25) (135.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0021-of-0025.json.zip"

echo "[677/1710] Downloading: 2017 Q4 (part 22 of 25) (143.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0022-of-0025.json.zip"

echo "[678/1710] Downloading: 2017 Q4 (part 23 of 25) (150.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0023-of-0025.json.zip"

echo "[679/1710] Downloading: 2017 Q4 (part 24 of 25) (151.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0024-of-0025.json.zip"

echo "[680/1710] Downloading: 2017 Q4 (part 25 of 25) (60.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q4/drug-event-0025-of-0025.json.zip"

echo "[681/1710] Downloading: 2007 Q2 (part 1 of 7) (62.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q2/drug-event-0001-of-0007.json.zip"

echo "[682/1710] Downloading: 2007 Q2 (part 2 of 7) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q2/drug-event-0002-of-0007.json.zip"

echo "[683/1710] Downloading: 2007 Q2 (part 3 of 7) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q2/drug-event-0003-of-0007.json.zip"

echo "[684/1710] Downloading: 2007 Q2 (part 4 of 7) (22.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q2/drug-event-0004-of-0007.json.zip"

echo "[685/1710] Downloading: 2007 Q2 (part 5 of 7) (87.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q2/drug-event-0005-of-0007.json.zip"

echo "[686/1710] Downloading: 2007 Q2 (part 6 of 7) (98.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q2/drug-event-0006-of-0007.json.zip"

echo "[687/1710] Downloading: 2007 Q2 (part 7 of 7) (17.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q2/drug-event-0007-of-0007.json.zip"

echo "[688/1710] Downloading: 2012 Q1 (part 1 of 11) (111.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0001-of-0011.json.zip"

echo "[689/1710] Downloading: 2012 Q1 (part 2 of 11) (50.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0002-of-0011.json.zip"

echo "[690/1710] Downloading: 2012 Q1 (part 3 of 11) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0003-of-0011.json.zip"

echo "[691/1710] Downloading: 2012 Q1 (part 4 of 11) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0004-of-0011.json.zip"

echo "[692/1710] Downloading: 2012 Q1 (part 5 of 11) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0005-of-0011.json.zip"

echo "[693/1710] Downloading: 2012 Q1 (part 6 of 11) (10.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0006-of-0011.json.zip"

echo "[694/1710] Downloading: 2012 Q1 (part 7 of 11) (48.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0007-of-0011.json.zip"

echo "[695/1710] Downloading: 2012 Q1 (part 8 of 11) (129.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0008-of-0011.json.zip"

echo "[696/1710] Downloading: 2012 Q1 (part 9 of 11) (142.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0009-of-0011.json.zip"

echo "[697/1710] Downloading: 2012 Q1 (part 10 of 11) (143.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0010-of-0011.json.zip"

echo "[698/1710] Downloading: 2012 Q1 (part 11 of 11) (117.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q1/drug-event-0011-of-0011.json.zip"

echo "[699/1710] Downloading: 2015 Q3 (part 1 of 32) (47.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0001-of-0032.json.zip"

echo "[700/1710] Downloading: 2015 Q3 (part 2 of 32) (88.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0002-of-0032.json.zip"

echo "[701/1710] Downloading: 2015 Q3 (part 3 of 32) (13.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0003-of-0032.json.zip"

echo "[702/1710] Downloading: 2015 Q3 (part 4 of 32) (11.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0004-of-0032.json.zip"

echo "[703/1710] Downloading: 2015 Q3 (part 5 of 32) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0005-of-0032.json.zip"

echo "[704/1710] Downloading: 2015 Q3 (part 6 of 32) (18.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0006-of-0032.json.zip"

echo "[705/1710] Downloading: 2015 Q3 (part 7 of 32) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0007-of-0032.json.zip"

echo "[706/1710] Downloading: 2015 Q3 (part 8 of 32) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0008-of-0032.json.zip"

echo "[707/1710] Downloading: 2015 Q3 (part 9 of 32) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0009-of-0032.json.zip"

echo "[708/1710] Downloading: 2015 Q3 (part 10 of 32) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0010-of-0032.json.zip"

echo "[709/1710] Downloading: 2015 Q3 (part 11 of 32) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0011-of-0032.json.zip"

echo "[710/1710] Downloading: 2015 Q3 (part 12 of 32) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0012-of-0032.json.zip"

echo "[711/1710] Downloading: 2015 Q3 (part 13 of 32) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0013-of-0032.json.zip"

echo "[712/1710] Downloading: 2015 Q3 (part 14 of 32) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0014-of-0032.json.zip"

echo "[713/1710] Downloading: 2015 Q3 (part 15 of 32) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0015-of-0032.json.zip"

echo "[714/1710] Downloading: 2015 Q3 (part 16 of 32) (6.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0016-of-0032.json.zip"

echo "[715/1710] Downloading: 2015 Q3 (part 17 of 32) (7.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0017-of-0032.json.zip"

echo "[716/1710] Downloading: 2015 Q3 (part 18 of 32) (12.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0018-of-0032.json.zip"

echo "[717/1710] Downloading: 2015 Q3 (part 19 of 32) (10.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0019-of-0032.json.zip"

echo "[718/1710] Downloading: 2015 Q3 (part 20 of 32) (28.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0020-of-0032.json.zip"

echo "[719/1710] Downloading: 2015 Q3 (part 21 of 32) (38.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0021-of-0032.json.zip"

echo "[720/1710] Downloading: 2015 Q3 (part 22 of 32) (31.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0022-of-0032.json.zip"

echo "[721/1710] Downloading: 2015 Q3 (part 23 of 32) (85.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0023-of-0032.json.zip"

echo "[722/1710] Downloading: 2015 Q3 (part 24 of 32) (53.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0024-of-0032.json.zip"

echo "[723/1710] Downloading: 2015 Q3 (part 25 of 32) (62.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0025-of-0032.json.zip"

echo "[724/1710] Downloading: 2015 Q3 (part 26 of 32) (111.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0026-of-0032.json.zip"

echo "[725/1710] Downloading: 2015 Q3 (part 27 of 32) (99.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0027-of-0032.json.zip"

echo "[726/1710] Downloading: 2015 Q3 (part 28 of 32) (110.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0028-of-0032.json.zip"

echo "[727/1710] Downloading: 2015 Q3 (part 29 of 32) (117.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0029-of-0032.json.zip"

echo "[728/1710] Downloading: 2015 Q3 (part 30 of 32) (112.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0030-of-0032.json.zip"

echo "[729/1710] Downloading: 2015 Q3 (part 31 of 32) (117.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0031-of-0032.json.zip"

echo "[730/1710] Downloading: 2015 Q3 (part 32 of 32) (11.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q3/drug-event-0032-of-0032.json.zip"

echo "[731/1710] Downloading: 2004 Q1 (part 1 of 5) (51.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q1/drug-event-0001-of-0005.json.zip"

echo "[732/1710] Downloading: 2004 Q1 (part 2 of 5) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q1/drug-event-0002-of-0005.json.zip"

echo "[733/1710] Downloading: 2004 Q1 (part 3 of 5) (17.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q1/drug-event-0003-of-0005.json.zip"

echo "[734/1710] Downloading: 2004 Q1 (part 4 of 5) (118.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q1/drug-event-0004-of-0005.json.zip"

echo "[735/1710] Downloading: 2004 Q1 (part 5 of 5) (42.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q1/drug-event-0005-of-0005.json.zip"

echo "[736/1710] Downloading: 2010 Q1 (part 1 of 9) (84.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0001-of-0009.json.zip"

echo "[737/1710] Downloading: 2010 Q1 (part 2 of 9) (23.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0002-of-0009.json.zip"

echo "[738/1710] Downloading: 2010 Q1 (part 3 of 9) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0003-of-0009.json.zip"

echo "[739/1710] Downloading: 2010 Q1 (part 4 of 9) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0004-of-0009.json.zip"

echo "[740/1710] Downloading: 2010 Q1 (part 5 of 9) (8.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0005-of-0009.json.zip"

echo "[741/1710] Downloading: 2010 Q1 (part 6 of 9) (50.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0006-of-0009.json.zip"

echo "[742/1710] Downloading: 2010 Q1 (part 7 of 9) (120.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0007-of-0009.json.zip"

echo "[743/1710] Downloading: 2010 Q1 (part 8 of 9) (123.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0008-of-0009.json.zip"

echo "[744/1710] Downloading: 2010 Q1 (part 9 of 9) (82.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q1/drug-event-0009-of-0009.json.zip"

echo "[745/1710] Downloading: 2004 Q4 (part 1 of 5) (60.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q4/drug-event-0001-of-0005.json.zip"

echo "[746/1710] Downloading: 2004 Q4 (part 2 of 5) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q4/drug-event-0002-of-0005.json.zip"

echo "[747/1710] Downloading: 2004 Q4 (part 3 of 5) (7.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q4/drug-event-0003-of-0005.json.zip"

echo "[748/1710] Downloading: 2004 Q4 (part 4 of 5) (99.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q4/drug-event-0004-of-0005.json.zip"

echo "[749/1710] Downloading: 2004 Q4 (part 5 of 5) (103.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2004q4/drug-event-0005-of-0005.json.zip"

echo "[750/1710] Downloading: 2009 Q1 (part 1 of 8) (82.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0001-of-0008.json.zip"

echo "[751/1710] Downloading: 2009 Q1 (part 2 of 8) (9.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0002-of-0008.json.zip"

echo "[752/1710] Downloading: 2009 Q1 (part 3 of 8) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0003-of-0008.json.zip"

echo "[753/1710] Downloading: 2009 Q1 (part 4 of 8) (7.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0004-of-0008.json.zip"

echo "[754/1710] Downloading: 2009 Q1 (part 5 of 8) (48.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0005-of-0008.json.zip"

echo "[755/1710] Downloading: 2009 Q1 (part 6 of 8) (120.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0006-of-0008.json.zip"

echo "[756/1710] Downloading: 2009 Q1 (part 7 of 8) (109.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0007-of-0008.json.zip"

echo "[757/1710] Downloading: 2009 Q1 (part 8 of 8) (35.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2009q1/drug-event-0008-of-0008.json.zip"

echo "[758/1710] Downloading: 2014 Q2 (part 1 of 16) (101.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0001-of-0016.json.zip"

echo "[759/1710] Downloading: 2014 Q2 (part 2 of 16) (20.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0002-of-0016.json.zip"

echo "[760/1710] Downloading: 2014 Q2 (part 3 of 16) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0003-of-0016.json.zip"

echo "[761/1710] Downloading: 2014 Q2 (part 4 of 16) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0004-of-0016.json.zip"

echo "[762/1710] Downloading: 2014 Q2 (part 5 of 16) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0005-of-0016.json.zip"

echo "[763/1710] Downloading: 2014 Q2 (part 6 of 16) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0006-of-0016.json.zip"

echo "[764/1710] Downloading: 2014 Q2 (part 7 of 16) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0007-of-0016.json.zip"

echo "[765/1710] Downloading: 2014 Q2 (part 8 of 16) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0008-of-0016.json.zip"

echo "[766/1710] Downloading: 2014 Q2 (part 9 of 16) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0009-of-0016.json.zip"

echo "[767/1710] Downloading: 2014 Q2 (part 10 of 16) (8.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0010-of-0016.json.zip"

echo "[768/1710] Downloading: 2014 Q2 (part 11 of 16) (20.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0011-of-0016.json.zip"

echo "[769/1710] Downloading: 2014 Q2 (part 12 of 16) (51.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0012-of-0016.json.zip"

echo "[770/1710] Downloading: 2014 Q2 (part 13 of 16) (103.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0013-of-0016.json.zip"

echo "[771/1710] Downloading: 2014 Q2 (part 14 of 16) (121.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0014-of-0016.json.zip"

echo "[772/1710] Downloading: 2014 Q2 (part 15 of 16) (118.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0015-of-0016.json.zip"

echo "[773/1710] Downloading: 2014 Q2 (part 16 of 16) (55.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2014q2/drug-event-0016-of-0016.json.zip"

echo "[774/1710] Downloading: 2010 Q2 (part 1 of 9) (75.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0001-of-0009.json.zip"

echo "[775/1710] Downloading: 2010 Q2 (part 2 of 9) (28.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0002-of-0009.json.zip"

echo "[776/1710] Downloading: 2010 Q2 (part 3 of 9) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0003-of-0009.json.zip"

echo "[777/1710] Downloading: 2010 Q2 (part 4 of 9) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0004-of-0009.json.zip"

echo "[778/1710] Downloading: 2010 Q2 (part 5 of 9) (7.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0005-of-0009.json.zip"

echo "[779/1710] Downloading: 2010 Q2 (part 6 of 9) (40.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0006-of-0009.json.zip"

echo "[780/1710] Downloading: 2010 Q2 (part 7 of 9) (94.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0007-of-0009.json.zip"

echo "[781/1710] Downloading: 2010 Q2 (part 8 of 9) (113.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0008-of-0009.json.zip"

echo "[782/1710] Downloading: 2010 Q2 (part 9 of 9) (107.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q2/drug-event-0009-of-0009.json.zip"

echo "[783/1710] Downloading: 2016 Q4 (part 1 of 23) (12.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0001-of-0023.json.zip"

echo "[784/1710] Downloading: 2016 Q4 (part 2 of 23) (16.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0002-of-0023.json.zip"

echo "[785/1710] Downloading: 2016 Q4 (part 3 of 23) (11.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0003-of-0023.json.zip"

echo "[786/1710] Downloading: 2016 Q4 (part 4 of 23) (8.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0004-of-0023.json.zip"

echo "[787/1710] Downloading: 2016 Q4 (part 5 of 23) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0005-of-0023.json.zip"

echo "[788/1710] Downloading: 2016 Q4 (part 6 of 23) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0006-of-0023.json.zip"

echo "[789/1710] Downloading: 2016 Q4 (part 7 of 23) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0007-of-0023.json.zip"

echo "[790/1710] Downloading: 2016 Q4 (part 8 of 23) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0008-of-0023.json.zip"

echo "[791/1710] Downloading: 2016 Q4 (part 9 of 23) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0009-of-0023.json.zip"

echo "[792/1710] Downloading: 2016 Q4 (part 10 of 23) (6.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0010-of-0023.json.zip"

echo "[793/1710] Downloading: 2016 Q4 (part 11 of 23) (9.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0011-of-0023.json.zip"

echo "[794/1710] Downloading: 2016 Q4 (part 12 of 23) (11.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0012-of-0023.json.zip"

echo "[795/1710] Downloading: 2016 Q4 (part 13 of 23) (23.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0013-of-0023.json.zip"

echo "[796/1710] Downloading: 2016 Q4 (part 14 of 23) (44.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0014-of-0023.json.zip"

echo "[797/1710] Downloading: 2016 Q4 (part 15 of 23) (57.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0015-of-0023.json.zip"

echo "[798/1710] Downloading: 2016 Q4 (part 16 of 23) (88.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0016-of-0023.json.zip"

echo "[799/1710] Downloading: 2016 Q4 (part 17 of 23) (132.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0017-of-0023.json.zip"

echo "[800/1710] Downloading: 2016 Q4 (part 18 of 23) (129.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0018-of-0023.json.zip"

echo "[801/1710] Downloading: 2016 Q4 (part 19 of 23) (134.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0019-of-0023.json.zip"

echo "[802/1710] Downloading: 2016 Q4 (part 20 of 23) (133.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0020-of-0023.json.zip"

echo "[803/1710] Downloading: 2016 Q4 (part 21 of 23) (132.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0021-of-0023.json.zip"

echo "[804/1710] Downloading: 2016 Q4 (part 22 of 23) (133.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0022-of-0023.json.zip"

echo "[805/1710] Downloading: 2016 Q4 (part 23 of 23) (49.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q4/drug-event-0023-of-0023.json.zip"

echo "[806/1710] Downloading: 2005 Q1 (part 1 of 6) (61.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q1/drug-event-0001-of-0006.json.zip"

echo "[807/1710] Downloading: 2005 Q1 (part 2 of 6) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q1/drug-event-0002-of-0006.json.zip"

echo "[808/1710] Downloading: 2005 Q1 (part 3 of 6) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q1/drug-event-0003-of-0006.json.zip"

echo "[809/1710] Downloading: 2005 Q1 (part 4 of 6) (80.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q1/drug-event-0004-of-0006.json.zip"

echo "[810/1710] Downloading: 2005 Q1 (part 5 of 6) (122.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q1/drug-event-0005-of-0006.json.zip"

echo "[811/1710] Downloading: 2005 Q1 (part 6 of 6) (18.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q1/drug-event-0006-of-0006.json.zip"

echo "[812/1710] Downloading: 2011 Q4 (part 1 of 11) (110.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0001-of-0011.json.zip"

echo "[813/1710] Downloading: 2011 Q4 (part 2 of 11) (47.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0002-of-0011.json.zip"

echo "[814/1710] Downloading: 2011 Q4 (part 3 of 11) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0003-of-0011.json.zip"

echo "[815/1710] Downloading: 2011 Q4 (part 4 of 11) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0004-of-0011.json.zip"

echo "[816/1710] Downloading: 2011 Q4 (part 5 of 11) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0005-of-0011.json.zip"

echo "[817/1710] Downloading: 2011 Q4 (part 6 of 11) (11.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0006-of-0011.json.zip"

echo "[818/1710] Downloading: 2011 Q4 (part 7 of 11) (51.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0007-of-0011.json.zip"

echo "[819/1710] Downloading: 2011 Q4 (part 8 of 11) (145.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0008-of-0011.json.zip"

echo "[820/1710] Downloading: 2011 Q4 (part 9 of 11) (150.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0009-of-0011.json.zip"

echo "[821/1710] Downloading: 2011 Q4 (part 10 of 11) (147.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0010-of-0011.json.zip"

echo "[822/1710] Downloading: 2011 Q4 (part 11 of 11) (72.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q4/drug-event-0011-of-0011.json.zip"

echo "[823/1710] Downloading: 2011 Q2 (part 1 of 12) (87.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0001-of-0012.json.zip"

echo "[824/1710] Downloading: 2011 Q2 (part 2 of 12) (55.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0002-of-0012.json.zip"

echo "[825/1710] Downloading: 2011 Q2 (part 3 of 12) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0003-of-0012.json.zip"

echo "[826/1710] Downloading: 2011 Q2 (part 4 of 12) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0004-of-0012.json.zip"

echo "[827/1710] Downloading: 2011 Q2 (part 5 of 12) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0005-of-0012.json.zip"

echo "[828/1710] Downloading: 2011 Q2 (part 6 of 12) (6.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0006-of-0012.json.zip"

echo "[829/1710] Downloading: 2011 Q2 (part 7 of 12) (26.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0007-of-0012.json.zip"

echo "[830/1710] Downloading: 2011 Q2 (part 8 of 12) (71.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0008-of-0012.json.zip"

echo "[831/1710] Downloading: 2011 Q2 (part 9 of 12) (126.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0009-of-0012.json.zip"

echo "[832/1710] Downloading: 2011 Q2 (part 10 of 12) (129.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0010-of-0012.json.zip"

echo "[833/1710] Downloading: 2011 Q2 (part 11 of 12) (113.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0011-of-0012.json.zip"

echo "[834/1710] Downloading: 2011 Q2 (part 12 of 12) (51.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2011q2/drug-event-0012-of-0012.json.zip"

echo "[835/1710] Downloading: 2007 Q3 (part 1 of 7) (66.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q3/drug-event-0001-of-0007.json.zip"

echo "[836/1710] Downloading: 2007 Q3 (part 2 of 7) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q3/drug-event-0002-of-0007.json.zip"

echo "[837/1710] Downloading: 2007 Q3 (part 3 of 7) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q3/drug-event-0003-of-0007.json.zip"

echo "[838/1710] Downloading: 2007 Q3 (part 4 of 7) (7.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q3/drug-event-0004-of-0007.json.zip"

echo "[839/1710] Downloading: 2007 Q3 (part 5 of 7) (60.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q3/drug-event-0005-of-0007.json.zip"

echo "[840/1710] Downloading: 2007 Q3 (part 6 of 7) (109.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q3/drug-event-0006-of-0007.json.zip"

echo "[841/1710] Downloading: 2007 Q3 (part 7 of 7) (58.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2007q3/drug-event-0007-of-0007.json.zip"

echo "[842/1710] Downloading: 2008 Q2 (part 1 of 8) (70.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0001-of-0008.json.zip"

echo "[843/1710] Downloading: 2008 Q2 (part 2 of 8) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0002-of-0008.json.zip"

echo "[844/1710] Downloading: 2008 Q2 (part 3 of 8) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0003-of-0008.json.zip"

echo "[845/1710] Downloading: 2008 Q2 (part 4 of 8) (7.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0004-of-0008.json.zip"

echo "[846/1710] Downloading: 2008 Q2 (part 5 of 8) (42.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0005-of-0008.json.zip"

echo "[847/1710] Downloading: 2008 Q2 (part 6 of 8) (100.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0006-of-0008.json.zip"

echo "[848/1710] Downloading: 2008 Q2 (part 7 of 8) (101.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0007-of-0008.json.zip"

echo "[849/1710] Downloading: 2008 Q2 (part 8 of 8) (15.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q2/drug-event-0008-of-0008.json.zip"

echo "[850/1710] Downloading: All other data (part 1 of 4) (39.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/all_other/drug-event-0001-of-0004.json.zip"

echo "[851/1710] Downloading: All other data (part 2 of 4) (2.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/all_other/drug-event-0002-of-0004.json.zip"

echo "[852/1710] Downloading: All other data (part 3 of 4) (31.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/all_other/drug-event-0003-of-0004.json.zip"

echo "[853/1710] Downloading: All other data (part 4 of 4) (108.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/all_other/drug-event-0004-of-0004.json.zip"

echo "[854/1710] Downloading: 2024 Q4 (part 1 of 29) (21.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0001-of-0029.json.zip"

echo "[855/1710] Downloading: 2024 Q4 (part 2 of 29) (107.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0002-of-0029.json.zip"

echo "[856/1710] Downloading: 2024 Q4 (part 3 of 29) (105.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0003-of-0029.json.zip"

echo "[857/1710] Downloading: 2024 Q4 (part 4 of 29) (96.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0004-of-0029.json.zip"

echo "[858/1710] Downloading: 2024 Q4 (part 5 of 29) (62.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0005-of-0029.json.zip"

echo "[859/1710] Downloading: 2024 Q4 (part 6 of 29) (20.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0006-of-0029.json.zip"

echo "[860/1710] Downloading: 2024 Q4 (part 7 of 29) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0007-of-0029.json.zip"

echo "[861/1710] Downloading: 2024 Q4 (part 8 of 29) (5.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0008-of-0029.json.zip"

echo "[862/1710] Downloading: 2024 Q4 (part 9 of 29) (5.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0009-of-0029.json.zip"

echo "[863/1710] Downloading: 2024 Q4 (part 10 of 29) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0010-of-0029.json.zip"

echo "[864/1710] Downloading: 2024 Q4 (part 11 of 29) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0011-of-0029.json.zip"

echo "[865/1710] Downloading: 2024 Q4 (part 12 of 29) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0012-of-0029.json.zip"

echo "[866/1710] Downloading: 2024 Q4 (part 13 of 29) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0013-of-0029.json.zip"

echo "[867/1710] Downloading: 2024 Q4 (part 14 of 29) (14.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0014-of-0029.json.zip"

echo "[868/1710] Downloading: 2024 Q4 (part 15 of 29) (29.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0015-of-0029.json.zip"

echo "[869/1710] Downloading: 2024 Q4 (part 16 of 29) (23.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0016-of-0029.json.zip"

echo "[870/1710] Downloading: 2024 Q4 (part 17 of 29) (48.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0017-of-0029.json.zip"

echo "[871/1710] Downloading: 2024 Q4 (part 18 of 29) (138.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0018-of-0029.json.zip"

echo "[872/1710] Downloading: 2024 Q4 (part 19 of 29) (143.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0019-of-0029.json.zip"

echo "[873/1710] Downloading: 2024 Q4 (part 20 of 29) (179.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0020-of-0029.json.zip"

echo "[874/1710] Downloading: 2024 Q4 (part 21 of 29) (197.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0021-of-0029.json.zip"

echo "[875/1710] Downloading: 2024 Q4 (part 22 of 29) (207.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0022-of-0029.json.zip"

echo "[876/1710] Downloading: 2024 Q4 (part 23 of 29) (205.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0023-of-0029.json.zip"

echo "[877/1710] Downloading: 2024 Q4 (part 24 of 29) (210.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0024-of-0029.json.zip"

echo "[878/1710] Downloading: 2024 Q4 (part 25 of 29) (203.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0025-of-0029.json.zip"

echo "[879/1710] Downloading: 2024 Q4 (part 26 of 29) (205.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0026-of-0029.json.zip"

echo "[880/1710] Downloading: 2024 Q4 (part 27 of 29) (193.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0027-of-0029.json.zip"

echo "[881/1710] Downloading: 2024 Q4 (part 28 of 29) (200.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0028-of-0029.json.zip"

echo "[882/1710] Downloading: 2024 Q4 (part 29 of 29) (57.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q4/drug-event-0029-of-0029.json.zip"

echo "[883/1710] Downloading: 2018 Q3 (part 1 of 30) (14.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0001-of-0030.json.zip"

echo "[884/1710] Downloading: 2018 Q3 (part 2 of 30) (8.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0002-of-0030.json.zip"

echo "[885/1710] Downloading: 2018 Q3 (part 3 of 30) (18.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0003-of-0030.json.zip"

echo "[886/1710] Downloading: 2018 Q3 (part 4 of 30) (14.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0004-of-0030.json.zip"

echo "[887/1710] Downloading: 2018 Q3 (part 5 of 30) (7.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0005-of-0030.json.zip"

echo "[888/1710] Downloading: 2018 Q3 (part 6 of 30) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0006-of-0030.json.zip"

echo "[889/1710] Downloading: 2018 Q3 (part 7 of 30) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0007-of-0030.json.zip"

echo "[890/1710] Downloading: 2018 Q3 (part 8 of 30) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0008-of-0030.json.zip"

echo "[891/1710] Downloading: 2018 Q3 (part 9 of 30) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0009-of-0030.json.zip"

echo "[892/1710] Downloading: 2018 Q3 (part 10 of 30) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0010-of-0030.json.zip"

echo "[893/1710] Downloading: 2018 Q3 (part 11 of 30) (6.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0011-of-0030.json.zip"

echo "[894/1710] Downloading: 2018 Q3 (part 12 of 30) (10.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0012-of-0030.json.zip"

echo "[895/1710] Downloading: 2018 Q3 (part 13 of 30) (11.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0013-of-0030.json.zip"

echo "[896/1710] Downloading: 2018 Q3 (part 14 of 30) (14.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0014-of-0030.json.zip"

echo "[897/1710] Downloading: 2018 Q3 (part 15 of 30) (19.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0015-of-0030.json.zip"

echo "[898/1710] Downloading: 2018 Q3 (part 16 of 30) (51.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0016-of-0030.json.zip"

echo "[899/1710] Downloading: 2018 Q3 (part 17 of 30) (42.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0017-of-0030.json.zip"

echo "[900/1710] Downloading: 2018 Q3 (part 18 of 30) (50.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0018-of-0030.json.zip"

echo "[901/1710] Downloading: 2018 Q3 (part 19 of 30) (119.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0019-of-0030.json.zip"

echo "[902/1710] Downloading: 2018 Q3 (part 20 of 30) (121.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0020-of-0030.json.zip"

echo "[903/1710] Downloading: 2018 Q3 (part 21 of 30) (109.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0021-of-0030.json.zip"

echo "[904/1710] Downloading: 2018 Q3 (part 22 of 30) (116.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0022-of-0030.json.zip"

echo "[905/1710] Downloading: 2018 Q3 (part 23 of 30) (119.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0023-of-0030.json.zip"

echo "[906/1710] Downloading: 2018 Q3 (part 24 of 30) (105.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0024-of-0030.json.zip"

echo "[907/1710] Downloading: 2018 Q3 (part 25 of 30) (122.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0025-of-0030.json.zip"

echo "[908/1710] Downloading: 2018 Q3 (part 26 of 30) (117.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0026-of-0030.json.zip"

echo "[909/1710] Downloading: 2018 Q3 (part 27 of 30) (116.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0027-of-0030.json.zip"

echo "[910/1710] Downloading: 2018 Q3 (part 28 of 30) (124.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0028-of-0030.json.zip"

echo "[911/1710] Downloading: 2018 Q3 (part 29 of 30) (117.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0029-of-0030.json.zip"

echo "[912/1710] Downloading: 2018 Q3 (part 30 of 30) (9.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q3/drug-event-0030-of-0030.json.zip"

echo "[913/1710] Downloading: 2024 Q1 (part 1 of 29) (113.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0001-of-0029.json.zip"

echo "[914/1710] Downloading: 2024 Q1 (part 2 of 29) (47.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0002-of-0029.json.zip"

echo "[915/1710] Downloading: 2024 Q1 (part 3 of 29) (7.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0003-of-0029.json.zip"

echo "[916/1710] Downloading: 2024 Q1 (part 4 of 29) (109.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0004-of-0029.json.zip"

echo "[917/1710] Downloading: 2024 Q1 (part 5 of 29) (77.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0005-of-0029.json.zip"

echo "[918/1710] Downloading: 2024 Q1 (part 6 of 29) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0006-of-0029.json.zip"

echo "[919/1710] Downloading: 2024 Q1 (part 7 of 29) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0007-of-0029.json.zip"

echo "[920/1710] Downloading: 2024 Q1 (part 8 of 29) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0008-of-0029.json.zip"

echo "[921/1710] Downloading: 2024 Q1 (part 9 of 29) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0009-of-0029.json.zip"

echo "[922/1710] Downloading: 2024 Q1 (part 10 of 29) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0010-of-0029.json.zip"

echo "[923/1710] Downloading: 2024 Q1 (part 11 of 29) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0011-of-0029.json.zip"

echo "[924/1710] Downloading: 2024 Q1 (part 12 of 29) (5.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0012-of-0029.json.zip"

echo "[925/1710] Downloading: 2024 Q1 (part 13 of 29) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0013-of-0029.json.zip"

echo "[926/1710] Downloading: 2024 Q1 (part 14 of 29) (15.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0014-of-0029.json.zip"

echo "[927/1710] Downloading: 2024 Q1 (part 15 of 29) (26.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0015-of-0029.json.zip"

echo "[928/1710] Downloading: 2024 Q1 (part 16 of 29) (24.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0016-of-0029.json.zip"

echo "[929/1710] Downloading: 2024 Q1 (part 17 of 29) (57.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0017-of-0029.json.zip"

echo "[930/1710] Downloading: 2024 Q1 (part 18 of 29) (133.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0018-of-0029.json.zip"

echo "[931/1710] Downloading: 2024 Q1 (part 19 of 29) (107.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0019-of-0029.json.zip"

echo "[932/1710] Downloading: 2024 Q1 (part 20 of 29) (182.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0020-of-0029.json.zip"

echo "[933/1710] Downloading: 2024 Q1 (part 21 of 29) (179.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0021-of-0029.json.zip"

echo "[934/1710] Downloading: 2024 Q1 (part 22 of 29) (185.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0022-of-0029.json.zip"

echo "[935/1710] Downloading: 2024 Q1 (part 23 of 29) (173.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0023-of-0029.json.zip"

echo "[936/1710] Downloading: 2024 Q1 (part 24 of 29) (177.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0024-of-0029.json.zip"

echo "[937/1710] Downloading: 2024 Q1 (part 25 of 29) (169.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0025-of-0029.json.zip"

echo "[938/1710] Downloading: 2024 Q1 (part 26 of 29) (175.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0026-of-0029.json.zip"

echo "[939/1710] Downloading: 2024 Q1 (part 27 of 29) (181.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0027-of-0029.json.zip"

echo "[940/1710] Downloading: 2024 Q1 (part 28 of 29) (178.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0028-of-0029.json.zip"

echo "[941/1710] Downloading: 2024 Q1 (part 29 of 29) (43.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2024q1/drug-event-0029-of-0029.json.zip"

echo "[942/1710] Downloading: 2008 Q3 (part 1 of 7) (74.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q3/drug-event-0001-of-0007.json.zip"

echo "[943/1710] Downloading: 2008 Q3 (part 2 of 7) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q3/drug-event-0002-of-0007.json.zip"

echo "[944/1710] Downloading: 2008 Q3 (part 3 of 7) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q3/drug-event-0003-of-0007.json.zip"

echo "[945/1710] Downloading: 2008 Q3 (part 4 of 7) (14.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q3/drug-event-0004-of-0007.json.zip"

echo "[946/1710] Downloading: 2008 Q3 (part 5 of 7) (84.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q3/drug-event-0005-of-0007.json.zip"

echo "[947/1710] Downloading: 2008 Q3 (part 6 of 7) (119.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q3/drug-event-0006-of-0007.json.zip"

echo "[948/1710] Downloading: 2008 Q3 (part 7 of 7) (73.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q3/drug-event-0007-of-0007.json.zip"

echo "[949/1710] Downloading: 2012 Q3 (part 1 of 10) (95.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0001-of-0010.json.zip"

echo "[950/1710] Downloading: 2012 Q3 (part 2 of 10) (17.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0002-of-0010.json.zip"

echo "[951/1710] Downloading: 2012 Q3 (part 3 of 10) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0003-of-0010.json.zip"

echo "[952/1710] Downloading: 2012 Q3 (part 4 of 10) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0004-of-0010.json.zip"

echo "[953/1710] Downloading: 2012 Q3 (part 5 of 10) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0005-of-0010.json.zip"

echo "[954/1710] Downloading: 2012 Q3 (part 6 of 10) (10.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0006-of-0010.json.zip"

echo "[955/1710] Downloading: 2012 Q3 (part 7 of 10) (65.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0007-of-0010.json.zip"

echo "[956/1710] Downloading: 2012 Q3 (part 8 of 10) (124.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0008-of-0010.json.zip"

echo "[957/1710] Downloading: 2012 Q3 (part 9 of 10) (114.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0009-of-0010.json.zip"

echo "[958/1710] Downloading: 2012 Q3 (part 10 of 10) (114.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2012q3/drug-event-0010-of-0010.json.zip"

echo "[959/1710] Downloading: 2016 Q1 (part 1 of 28) (7.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0001-of-0028.json.zip"

echo "[960/1710] Downloading: 2016 Q1 (part 2 of 28) (68.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0002-of-0028.json.zip"

echo "[961/1710] Downloading: 2016 Q1 (part 3 of 28) (15.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0003-of-0028.json.zip"

echo "[962/1710] Downloading: 2016 Q1 (part 4 of 28) (6.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0004-of-0028.json.zip"

echo "[963/1710] Downloading: 2016 Q1 (part 5 of 28) (18.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0005-of-0028.json.zip"

echo "[964/1710] Downloading: 2016 Q1 (part 6 of 28) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0006-of-0028.json.zip"

echo "[965/1710] Downloading: 2016 Q1 (part 7 of 28) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0007-of-0028.json.zip"

echo "[966/1710] Downloading: 2016 Q1 (part 8 of 28) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0008-of-0028.json.zip"

echo "[967/1710] Downloading: 2016 Q1 (part 9 of 28) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0009-of-0028.json.zip"

echo "[968/1710] Downloading: 2016 Q1 (part 10 of 28) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0010-of-0028.json.zip"

echo "[969/1710] Downloading: 2016 Q1 (part 11 of 28) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0011-of-0028.json.zip"

echo "[970/1710] Downloading: 2016 Q1 (part 12 of 28) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0012-of-0028.json.zip"

echo "[971/1710] Downloading: 2016 Q1 (part 13 of 28) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0013-of-0028.json.zip"

echo "[972/1710] Downloading: 2016 Q1 (part 14 of 28) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0014-of-0028.json.zip"

echo "[973/1710] Downloading: 2016 Q1 (part 15 of 28) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0015-of-0028.json.zip"

echo "[974/1710] Downloading: 2016 Q1 (part 16 of 28) (7.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0016-of-0028.json.zip"

echo "[975/1710] Downloading: 2016 Q1 (part 17 of 28) (14.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0017-of-0028.json.zip"

echo "[976/1710] Downloading: 2016 Q1 (part 18 of 28) (10.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0018-of-0028.json.zip"

echo "[977/1710] Downloading: 2016 Q1 (part 19 of 28) (51.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0019-of-0028.json.zip"

echo "[978/1710] Downloading: 2016 Q1 (part 20 of 28) (44.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0020-of-0028.json.zip"

echo "[979/1710] Downloading: 2016 Q1 (part 21 of 28) (78.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0021-of-0028.json.zip"

echo "[980/1710] Downloading: 2016 Q1 (part 22 of 28) (74.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0022-of-0028.json.zip"

echo "[981/1710] Downloading: 2016 Q1 (part 23 of 28) (125.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0023-of-0028.json.zip"

echo "[982/1710] Downloading: 2016 Q1 (part 24 of 28) (141.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0024-of-0028.json.zip"

echo "[983/1710] Downloading: 2016 Q1 (part 25 of 28) (143.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0025-of-0028.json.zip"

echo "[984/1710] Downloading: 2016 Q1 (part 26 of 28) (143.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0026-of-0028.json.zip"

echo "[985/1710] Downloading: 2016 Q1 (part 27 of 28) (140.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0027-of-0028.json.zip"

echo "[986/1710] Downloading: 2016 Q1 (part 28 of 28) (141.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q1/drug-event-0028-of-0028.json.zip"

echo "[987/1710] Downloading: 2022 Q4 (part 1 of 34) (119.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0001-of-0034.json.zip"

echo "[988/1710] Downloading: 2022 Q4 (part 2 of 34) (107.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0002-of-0034.json.zip"

echo "[989/1710] Downloading: 2022 Q4 (part 3 of 34) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0003-of-0034.json.zip"

echo "[990/1710] Downloading: 2022 Q4 (part 4 of 34) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0004-of-0034.json.zip"

echo "[991/1710] Downloading: 2022 Q4 (part 5 of 34) (24.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0005-of-0034.json.zip"

echo "[992/1710] Downloading: 2022 Q4 (part 6 of 34) (128.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0006-of-0034.json.zip"

echo "[993/1710] Downloading: 2022 Q4 (part 7 of 34) (80.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0007-of-0034.json.zip"

echo "[994/1710] Downloading: 2022 Q4 (part 8 of 34) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0008-of-0034.json.zip"

echo "[995/1710] Downloading: 2022 Q4 (part 9 of 34) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0009-of-0034.json.zip"

echo "[996/1710] Downloading: 2022 Q4 (part 10 of 34) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0010-of-0034.json.zip"

echo "[997/1710] Downloading: 2022 Q4 (part 11 of 34) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0011-of-0034.json.zip"

echo "[998/1710] Downloading: 2022 Q4 (part 12 of 34) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0012-of-0034.json.zip"

echo "[999/1710] Downloading: 2022 Q4 (part 13 of 34) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0013-of-0034.json.zip"

echo "[1000/1710] Downloading: 2022 Q4 (part 14 of 34) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0014-of-0034.json.zip"

echo "[1001/1710] Downloading: 2022 Q4 (part 15 of 34) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0015-of-0034.json.zip"

echo "[1002/1710] Downloading: 2022 Q4 (part 16 of 34) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0016-of-0034.json.zip"

echo "[1003/1710] Downloading: 2022 Q4 (part 17 of 34) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0017-of-0034.json.zip"

echo "[1004/1710] Downloading: 2022 Q4 (part 18 of 34) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0018-of-0034.json.zip"

echo "[1005/1710] Downloading: 2022 Q4 (part 19 of 34) (11.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0019-of-0034.json.zip"

echo "[1006/1710] Downloading: 2022 Q4 (part 20 of 34) (15.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0020-of-0034.json.zip"

echo "[1007/1710] Downloading: 2022 Q4 (part 21 of 34) (9.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0021-of-0034.json.zip"

echo "[1008/1710] Downloading: 2022 Q4 (part 22 of 34) (29.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0022-of-0034.json.zip"

echo "[1009/1710] Downloading: 2022 Q4 (part 23 of 34) (45.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0023-of-0034.json.zip"

echo "[1010/1710] Downloading: 2022 Q4 (part 24 of 34) (55.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0024-of-0034.json.zip"

echo "[1011/1710] Downloading: 2022 Q4 (part 25 of 34) (161.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0025-of-0034.json.zip"

echo "[1012/1710] Downloading: 2022 Q4 (part 26 of 34) (170.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0026-of-0034.json.zip"

echo "[1013/1710] Downloading: 2022 Q4 (part 27 of 34) (181.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0027-of-0034.json.zip"

echo "[1014/1710] Downloading: 2022 Q4 (part 28 of 34) (188.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0028-of-0034.json.zip"

echo "[1015/1710] Downloading: 2022 Q4 (part 29 of 34) (174.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0029-of-0034.json.zip"

echo "[1016/1710] Downloading: 2022 Q4 (part 30 of 34) (178.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0030-of-0034.json.zip"

echo "[1017/1710] Downloading: 2022 Q4 (part 31 of 34) (177.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0031-of-0034.json.zip"

echo "[1018/1710] Downloading: 2022 Q4 (part 32 of 34) (180.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0032-of-0034.json.zip"

echo "[1019/1710] Downloading: 2022 Q4 (part 33 of 34) (179.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0033-of-0034.json.zip"

echo "[1020/1710] Downloading: 2022 Q4 (part 34 of 34) (84.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q4/drug-event-0034-of-0034.json.zip"

echo "[1021/1710] Downloading: 2019 Q1 (part 1 of 30) (47.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0001-of-0030.json.zip"

echo "[1022/1710] Downloading: 2019 Q1 (part 2 of 30) (8.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0002-of-0030.json.zip"

echo "[1023/1710] Downloading: 2019 Q1 (part 3 of 30) (22.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0003-of-0030.json.zip"

echo "[1024/1710] Downloading: 2019 Q1 (part 4 of 30) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0004-of-0030.json.zip"

echo "[1025/1710] Downloading: 2019 Q1 (part 5 of 30) (6.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0005-of-0030.json.zip"

echo "[1026/1710] Downloading: 2019 Q1 (part 6 of 30) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0006-of-0030.json.zip"

echo "[1027/1710] Downloading: 2019 Q1 (part 7 of 30) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0007-of-0030.json.zip"

echo "[1028/1710] Downloading: 2019 Q1 (part 8 of 30) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0008-of-0030.json.zip"

echo "[1029/1710] Downloading: 2019 Q1 (part 9 of 30) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0009-of-0030.json.zip"

echo "[1030/1710] Downloading: 2019 Q1 (part 10 of 30) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0010-of-0030.json.zip"

echo "[1031/1710] Downloading: 2019 Q1 (part 11 of 30) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0011-of-0030.json.zip"

echo "[1032/1710] Downloading: 2019 Q1 (part 12 of 30) (6.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0012-of-0030.json.zip"

echo "[1033/1710] Downloading: 2019 Q1 (part 13 of 30) (11.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0013-of-0030.json.zip"

echo "[1034/1710] Downloading: 2019 Q1 (part 14 of 30) (11.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0014-of-0030.json.zip"

echo "[1035/1710] Downloading: 2019 Q1 (part 15 of 30) (18.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0015-of-0030.json.zip"

echo "[1036/1710] Downloading: 2019 Q1 (part 16 of 30) (22.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0016-of-0030.json.zip"

echo "[1037/1710] Downloading: 2019 Q1 (part 17 of 30) (54.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0017-of-0030.json.zip"

echo "[1038/1710] Downloading: 2019 Q1 (part 18 of 30) (41.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0018-of-0030.json.zip"

echo "[1039/1710] Downloading: 2019 Q1 (part 19 of 30) (63.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0019-of-0030.json.zip"

echo "[1040/1710] Downloading: 2019 Q1 (part 20 of 30) (146.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0020-of-0030.json.zip"

echo "[1041/1710] Downloading: 2019 Q1 (part 21 of 30) (144.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0021-of-0030.json.zip"

echo "[1042/1710] Downloading: 2019 Q1 (part 22 of 30) (141.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0022-of-0030.json.zip"

echo "[1043/1710] Downloading: 2019 Q1 (part 23 of 30) (129.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0023-of-0030.json.zip"

echo "[1044/1710] Downloading: 2019 Q1 (part 24 of 30) (136.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0024-of-0030.json.zip"

echo "[1045/1710] Downloading: 2019 Q1 (part 25 of 30) (132.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0025-of-0030.json.zip"

echo "[1046/1710] Downloading: 2019 Q1 (part 26 of 30) (142.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0026-of-0030.json.zip"

echo "[1047/1710] Downloading: 2019 Q1 (part 27 of 30) (146.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0027-of-0030.json.zip"

echo "[1048/1710] Downloading: 2019 Q1 (part 28 of 30) (150.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0028-of-0030.json.zip"

echo "[1049/1710] Downloading: 2019 Q1 (part 29 of 30) (146.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0029-of-0030.json.zip"

echo "[1050/1710] Downloading: 2019 Q1 (part 30 of 30) (21.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q1/drug-event-0030-of-0030.json.zip"

echo "[1051/1710] Downloading: 2017 Q1 (part 1 of 26) (9.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0001-of-0026.json.zip"

echo "[1052/1710] Downloading: 2017 Q1 (part 2 of 26) (20.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0002-of-0026.json.zip"

echo "[1053/1710] Downloading: 2017 Q1 (part 3 of 26) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0003-of-0026.json.zip"

echo "[1054/1710] Downloading: 2017 Q1 (part 4 of 26) (15.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0004-of-0026.json.zip"

echo "[1055/1710] Downloading: 2017 Q1 (part 5 of 26) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0005-of-0026.json.zip"

echo "[1056/1710] Downloading: 2017 Q1 (part 6 of 26) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0006-of-0026.json.zip"

echo "[1057/1710] Downloading: 2017 Q1 (part 7 of 26) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0007-of-0026.json.zip"

echo "[1058/1710] Downloading: 2017 Q1 (part 8 of 26) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0008-of-0026.json.zip"

echo "[1059/1710] Downloading: 2017 Q1 (part 9 of 26) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0009-of-0026.json.zip"

echo "[1060/1710] Downloading: 2017 Q1 (part 10 of 26) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0010-of-0026.json.zip"

echo "[1061/1710] Downloading: 2017 Q1 (part 11 of 26) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0011-of-0026.json.zip"

echo "[1062/1710] Downloading: 2017 Q1 (part 12 of 26) (6.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0012-of-0026.json.zip"

echo "[1063/1710] Downloading: 2017 Q1 (part 13 of 26) (9.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0013-of-0026.json.zip"

echo "[1064/1710] Downloading: 2017 Q1 (part 14 of 26) (12.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0014-of-0026.json.zip"

echo "[1065/1710] Downloading: 2017 Q1 (part 15 of 26) (20.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0015-of-0026.json.zip"

echo "[1066/1710] Downloading: 2017 Q1 (part 16 of 26) (39.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0016-of-0026.json.zip"

echo "[1067/1710] Downloading: 2017 Q1 (part 17 of 26) (53.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0017-of-0026.json.zip"

echo "[1068/1710] Downloading: 2017 Q1 (part 18 of 26) (50.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0018-of-0026.json.zip"

echo "[1069/1710] Downloading: 2017 Q1 (part 19 of 26) (138.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0019-of-0026.json.zip"

echo "[1070/1710] Downloading: 2017 Q1 (part 20 of 26) (140.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0020-of-0026.json.zip"

echo "[1071/1710] Downloading: 2017 Q1 (part 21 of 26) (131.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0021-of-0026.json.zip"

echo "[1072/1710] Downloading: 2017 Q1 (part 22 of 26) (144.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0022-of-0026.json.zip"

echo "[1073/1710] Downloading: 2017 Q1 (part 23 of 26) (150.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0023-of-0026.json.zip"

echo "[1074/1710] Downloading: 2017 Q1 (part 24 of 26) (140.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0024-of-0026.json.zip"

echo "[1075/1710] Downloading: 2017 Q1 (part 25 of 26) (149.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0025-of-0026.json.zip"

echo "[1076/1710] Downloading: 2017 Q1 (part 26 of 26) (54.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q1/drug-event-0026-of-0026.json.zip"

echo "[1077/1710] Downloading: 2019 Q2 (part 1 of 30) (73.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0001-of-0030.json.zip"

echo "[1078/1710] Downloading: 2019 Q2 (part 2 of 30) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0002-of-0030.json.zip"

echo "[1079/1710] Downloading: 2019 Q2 (part 3 of 30) (24.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0003-of-0030.json.zip"

echo "[1080/1710] Downloading: 2019 Q2 (part 4 of 30) (5.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0004-of-0030.json.zip"

echo "[1081/1710] Downloading: 2019 Q2 (part 5 of 30) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0005-of-0030.json.zip"

echo "[1082/1710] Downloading: 2019 Q2 (part 6 of 30) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0006-of-0030.json.zip"

echo "[1083/1710] Downloading: 2019 Q2 (part 7 of 30) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0007-of-0030.json.zip"

echo "[1084/1710] Downloading: 2019 Q2 (part 8 of 30) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0008-of-0030.json.zip"

echo "[1085/1710] Downloading: 2019 Q2 (part 9 of 30) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0009-of-0030.json.zip"

echo "[1086/1710] Downloading: 2019 Q2 (part 10 of 30) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0010-of-0030.json.zip"

echo "[1087/1710] Downloading: 2019 Q2 (part 11 of 30) (5.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0011-of-0030.json.zip"

echo "[1088/1710] Downloading: 2019 Q2 (part 12 of 30) (6.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0012-of-0030.json.zip"

echo "[1089/1710] Downloading: 2019 Q2 (part 13 of 30) (11.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0013-of-0030.json.zip"

echo "[1090/1710] Downloading: 2019 Q2 (part 14 of 30) (10.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0014-of-0030.json.zip"

echo "[1091/1710] Downloading: 2019 Q2 (part 15 of 30) (12.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0015-of-0030.json.zip"

echo "[1092/1710] Downloading: 2019 Q2 (part 16 of 30) (11.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0016-of-0030.json.zip"

echo "[1093/1710] Downloading: 2019 Q2 (part 17 of 30) (38.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0017-of-0030.json.zip"

echo "[1094/1710] Downloading: 2019 Q2 (part 18 of 30) (39.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0018-of-0030.json.zip"

echo "[1095/1710] Downloading: 2019 Q2 (part 19 of 30) (53.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0019-of-0030.json.zip"

echo "[1096/1710] Downloading: 2019 Q2 (part 20 of 30) (102.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0020-of-0030.json.zip"

echo "[1097/1710] Downloading: 2019 Q2 (part 21 of 30) (131.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0021-of-0030.json.zip"

echo "[1098/1710] Downloading: 2019 Q2 (part 22 of 30) (123.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0022-of-0030.json.zip"

echo "[1099/1710] Downloading: 2019 Q2 (part 23 of 30) (131.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0023-of-0030.json.zip"

echo "[1100/1710] Downloading: 2019 Q2 (part 24 of 30) (125.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0024-of-0030.json.zip"

echo "[1101/1710] Downloading: 2019 Q2 (part 25 of 30) (124.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0025-of-0030.json.zip"

echo "[1102/1710] Downloading: 2019 Q2 (part 26 of 30) (135.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0026-of-0030.json.zip"

echo "[1103/1710] Downloading: 2019 Q2 (part 27 of 30) (133.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0027-of-0030.json.zip"

echo "[1104/1710] Downloading: 2019 Q2 (part 28 of 30) (132.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0028-of-0030.json.zip"

echo "[1105/1710] Downloading: 2019 Q2 (part 29 of 30) (133.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0029-of-0030.json.zip"

echo "[1106/1710] Downloading: 2019 Q2 (part 30 of 30) (119.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q2/drug-event-0030-of-0030.json.zip"

echo "[1107/1710] Downloading: 2006 Q4 (part 1 of 5) (59.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q4/drug-event-0001-of-0005.json.zip"

echo "[1108/1710] Downloading: 2006 Q4 (part 2 of 5) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q4/drug-event-0002-of-0005.json.zip"

echo "[1109/1710] Downloading: 2006 Q4 (part 3 of 5) (7.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q4/drug-event-0003-of-0005.json.zip"

echo "[1110/1710] Downloading: 2006 Q4 (part 4 of 5) (90.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q4/drug-event-0004-of-0005.json.zip"

echo "[1111/1710] Downloading: 2006 Q4 (part 5 of 5) (119.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q4/drug-event-0005-of-0005.json.zip"

echo "[1112/1710] Downloading: 2025 Q2 (part 1 of 29) (53.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0001-of-0029.json.zip"

echo "[1113/1710] Downloading: 2025 Q2 (part 2 of 29) (164.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0002-of-0029.json.zip"

echo "[1114/1710] Downloading: 2025 Q2 (part 3 of 29) (41.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0003-of-0029.json.zip"

echo "[1115/1710] Downloading: 2025 Q2 (part 4 of 29) (122.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0004-of-0029.json.zip"

echo "[1116/1710] Downloading: 2025 Q2 (part 5 of 29) (140.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0005-of-0029.json.zip"

echo "[1117/1710] Downloading: 2025 Q2 (part 6 of 29) (19.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0006-of-0029.json.zip"

echo "[1118/1710] Downloading: 2025 Q2 (part 7 of 29) (8.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0007-of-0029.json.zip"

echo "[1119/1710] Downloading: 2025 Q2 (part 8 of 29) (7.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0008-of-0029.json.zip"

echo "[1120/1710] Downloading: 2025 Q2 (part 9 of 29) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0009-of-0029.json.zip"

echo "[1121/1710] Downloading: 2025 Q2 (part 10 of 29) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0010-of-0029.json.zip"

echo "[1122/1710] Downloading: 2025 Q2 (part 11 of 29) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0011-of-0029.json.zip"

echo "[1123/1710] Downloading: 2025 Q2 (part 12 of 29) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0012-of-0029.json.zip"

echo "[1124/1710] Downloading: 2025 Q2 (part 13 of 29) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0013-of-0029.json.zip"

echo "[1125/1710] Downloading: 2025 Q2 (part 14 of 29) (9.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0014-of-0029.json.zip"

echo "[1126/1710] Downloading: 2025 Q2 (part 15 of 29) (18.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0015-of-0029.json.zip"

echo "[1127/1710] Downloading: 2025 Q2 (part 16 of 29) (23.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0016-of-0029.json.zip"

echo "[1128/1710] Downloading: 2025 Q2 (part 17 of 29) (50.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0017-of-0029.json.zip"

echo "[1129/1710] Downloading: 2025 Q2 (part 18 of 29) (51.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0018-of-0029.json.zip"

echo "[1130/1710] Downloading: 2025 Q2 (part 19 of 29) (201.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0019-of-0029.json.zip"

echo "[1131/1710] Downloading: 2025 Q2 (part 20 of 29) (145.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0020-of-0029.json.zip"

echo "[1132/1710] Downloading: 2025 Q2 (part 21 of 29) (194.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0021-of-0029.json.zip"

echo "[1133/1710] Downloading: 2025 Q2 (part 22 of 29) (199.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0022-of-0029.json.zip"

echo "[1134/1710] Downloading: 2025 Q2 (part 23 of 29) (204.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0023-of-0029.json.zip"

echo "[1135/1710] Downloading: 2025 Q2 (part 24 of 29) (199.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0024-of-0029.json.zip"

echo "[1136/1710] Downloading: 2025 Q2 (part 25 of 29) (204.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0025-of-0029.json.zip"

echo "[1137/1710] Downloading: 2025 Q2 (part 26 of 29) (208.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0026-of-0029.json.zip"

echo "[1138/1710] Downloading: 2025 Q2 (part 27 of 29) (200.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0027-of-0029.json.zip"

echo "[1139/1710] Downloading: 2025 Q2 (part 28 of 29) (208.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0028-of-0029.json.zip"

echo "[1140/1710] Downloading: 2025 Q2 (part 29 of 29) (38.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q2/drug-event-0029-of-0029.json.zip"

echo "[1141/1710] Downloading: 2016 Q3 (part 1 of 23) (12.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0001-of-0023.json.zip"

echo "[1142/1710] Downloading: 2016 Q3 (part 2 of 23) (16.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0002-of-0023.json.zip"

echo "[1143/1710] Downloading: 2016 Q3 (part 3 of 23) (8.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0003-of-0023.json.zip"

echo "[1144/1710] Downloading: 2016 Q3 (part 4 of 23) (11.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0004-of-0023.json.zip"

echo "[1145/1710] Downloading: 2016 Q3 (part 5 of 23) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0005-of-0023.json.zip"

echo "[1146/1710] Downloading: 2016 Q3 (part 6 of 23) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0006-of-0023.json.zip"

echo "[1147/1710] Downloading: 2016 Q3 (part 7 of 23) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0007-of-0023.json.zip"

echo "[1148/1710] Downloading: 2016 Q3 (part 8 of 23) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0008-of-0023.json.zip"

echo "[1149/1710] Downloading: 2016 Q3 (part 9 of 23) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0009-of-0023.json.zip"

echo "[1150/1710] Downloading: 2016 Q3 (part 10 of 23) (6.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0010-of-0023.json.zip"

echo "[1151/1710] Downloading: 2016 Q3 (part 11 of 23) (10.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0011-of-0023.json.zip"

echo "[1152/1710] Downloading: 2016 Q3 (part 12 of 23) (14.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0012-of-0023.json.zip"

echo "[1153/1710] Downloading: 2016 Q3 (part 13 of 23) (47.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0013-of-0023.json.zip"

echo "[1154/1710] Downloading: 2016 Q3 (part 14 of 23) (40.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0014-of-0023.json.zip"

echo "[1155/1710] Downloading: 2016 Q3 (part 15 of 23) (42.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0015-of-0023.json.zip"

echo "[1156/1710] Downloading: 2016 Q3 (part 16 of 23) (144.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0016-of-0023.json.zip"

echo "[1157/1710] Downloading: 2016 Q3 (part 17 of 23) (161.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0017-of-0023.json.zip"

echo "[1158/1710] Downloading: 2016 Q3 (part 18 of 23) (164.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0018-of-0023.json.zip"

echo "[1159/1710] Downloading: 2016 Q3 (part 19 of 23) (168.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0019-of-0023.json.zip"

echo "[1160/1710] Downloading: 2016 Q3 (part 20 of 23) (169.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0020-of-0023.json.zip"

echo "[1161/1710] Downloading: 2016 Q3 (part 21 of 23) (169.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0021-of-0023.json.zip"

echo "[1162/1710] Downloading: 2016 Q3 (part 22 of 23) (171.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0022-of-0023.json.zip"

echo "[1163/1710] Downloading: 2016 Q3 (part 23 of 23) (71.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q3/drug-event-0023-of-0023.json.zip"

echo "[1164/1710] Downloading: 2006 Q3 (part 1 of 5) (56.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q3/drug-event-0001-of-0005.json.zip"

echo "[1165/1710] Downloading: 2006 Q3 (part 2 of 5) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q3/drug-event-0002-of-0005.json.zip"

echo "[1166/1710] Downloading: 2006 Q3 (part 3 of 5) (7.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q3/drug-event-0003-of-0005.json.zip"

echo "[1167/1710] Downloading: 2006 Q3 (part 4 of 5) (88.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q3/drug-event-0004-of-0005.json.zip"

echo "[1168/1710] Downloading: 2006 Q3 (part 5 of 5) (108.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2006q3/drug-event-0005-of-0005.json.zip"

echo "[1169/1710] Downloading: 2023 Q2 (part 1 of 30) (130.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0001-of-0030.json.zip"

echo "[1170/1710] Downloading: 2023 Q2 (part 2 of 30) (98.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0002-of-0030.json.zip"

echo "[1171/1710] Downloading: 2023 Q2 (part 3 of 30) (20.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0003-of-0030.json.zip"

echo "[1172/1710] Downloading: 2023 Q2 (part 4 of 30) (42.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0004-of-0030.json.zip"

echo "[1173/1710] Downloading: 2023 Q2 (part 5 of 30) (127.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0005-of-0030.json.zip"

echo "[1174/1710] Downloading: 2023 Q2 (part 6 of 30) (58.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0006-of-0030.json.zip"

echo "[1175/1710] Downloading: 2023 Q2 (part 7 of 30) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0007-of-0030.json.zip"

echo "[1176/1710] Downloading: 2023 Q2 (part 8 of 30) (6.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0008-of-0030.json.zip"

echo "[1177/1710] Downloading: 2023 Q2 (part 9 of 30) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0009-of-0030.json.zip"

echo "[1178/1710] Downloading: 2023 Q2 (part 10 of 30) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0010-of-0030.json.zip"

echo "[1179/1710] Downloading: 2023 Q2 (part 11 of 30) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0011-of-0030.json.zip"

echo "[1180/1710] Downloading: 2023 Q2 (part 12 of 30) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0012-of-0030.json.zip"

echo "[1181/1710] Downloading: 2023 Q2 (part 13 of 30) (6.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0013-of-0030.json.zip"

echo "[1182/1710] Downloading: 2023 Q2 (part 14 of 30) (8.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0014-of-0030.json.zip"

echo "[1183/1710] Downloading: 2023 Q2 (part 15 of 30) (15.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0015-of-0030.json.zip"

echo "[1184/1710] Downloading: 2023 Q2 (part 16 of 30) (16.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0016-of-0030.json.zip"

echo "[1185/1710] Downloading: 2023 Q2 (part 17 of 30) (27.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0017-of-0030.json.zip"

echo "[1186/1710] Downloading: 2023 Q2 (part 18 of 30) (52.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0018-of-0030.json.zip"

echo "[1187/1710] Downloading: 2023 Q2 (part 19 of 30) (73.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0019-of-0030.json.zip"

echo "[1188/1710] Downloading: 2023 Q2 (part 20 of 30) (170.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0020-of-0030.json.zip"

echo "[1189/1710] Downloading: 2023 Q2 (part 21 of 30) (152.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0021-of-0030.json.zip"

echo "[1190/1710] Downloading: 2023 Q2 (part 22 of 30) (167.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0022-of-0030.json.zip"

echo "[1191/1710] Downloading: 2023 Q2 (part 23 of 30) (172.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0023-of-0030.json.zip"

echo "[1192/1710] Downloading: 2023 Q2 (part 24 of 30) (170.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0024-of-0030.json.zip"

echo "[1193/1710] Downloading: 2023 Q2 (part 25 of 30) (180.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0025-of-0030.json.zip"

echo "[1194/1710] Downloading: 2023 Q2 (part 26 of 30) (175.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0026-of-0030.json.zip"

echo "[1195/1710] Downloading: 2023 Q2 (part 27 of 30) (172.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0027-of-0030.json.zip"

echo "[1196/1710] Downloading: 2023 Q2 (part 28 of 30) (175.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0028-of-0030.json.zip"

echo "[1197/1710] Downloading: 2023 Q2 (part 29 of 30) (170.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0029-of-0030.json.zip"

echo "[1198/1710] Downloading: 2023 Q2 (part 30 of 30) (10.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q2/drug-event-0030-of-0030.json.zip"

echo "[1199/1710] Downloading: 2022 Q3 (part 1 of 32) (106.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0001-of-0032.json.zip"

echo "[1200/1710] Downloading: 2022 Q3 (part 2 of 32) (117.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0002-of-0032.json.zip"

echo "[1201/1710] Downloading: 2022 Q3 (part 3 of 32) (8.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0003-of-0032.json.zip"

echo "[1202/1710] Downloading: 2022 Q3 (part 4 of 32) (18.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0004-of-0032.json.zip"

echo "[1203/1710] Downloading: 2022 Q3 (part 5 of 32) (23.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0005-of-0032.json.zip"

echo "[1204/1710] Downloading: 2022 Q3 (part 6 of 32) (54.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0006-of-0032.json.zip"

echo "[1205/1710] Downloading: 2022 Q3 (part 7 of 32) (134.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0007-of-0032.json.zip"

echo "[1206/1710] Downloading: 2022 Q3 (part 8 of 32) (1.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0008-of-0032.json.zip"

echo "[1207/1710] Downloading: 2022 Q3 (part 9 of 32) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0009-of-0032.json.zip"

echo "[1208/1710] Downloading: 2022 Q3 (part 10 of 32) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0010-of-0032.json.zip"

echo "[1209/1710] Downloading: 2022 Q3 (part 11 of 32) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0011-of-0032.json.zip"

echo "[1210/1710] Downloading: 2022 Q3 (part 12 of 32) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0012-of-0032.json.zip"

echo "[1211/1710] Downloading: 2022 Q3 (part 13 of 32) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0013-of-0032.json.zip"

echo "[1212/1710] Downloading: 2022 Q3 (part 14 of 32) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0014-of-0032.json.zip"

echo "[1213/1710] Downloading: 2022 Q3 (part 15 of 32) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0015-of-0032.json.zip"

echo "[1214/1710] Downloading: 2022 Q3 (part 16 of 32) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0016-of-0032.json.zip"

echo "[1215/1710] Downloading: 2022 Q3 (part 17 of 32) (10.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0017-of-0032.json.zip"

echo "[1216/1710] Downloading: 2022 Q3 (part 18 of 32) (11.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0018-of-0032.json.zip"

echo "[1217/1710] Downloading: 2022 Q3 (part 19 of 32) (18.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0019-of-0032.json.zip"

echo "[1218/1710] Downloading: 2022 Q3 (part 20 of 32) (26.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0020-of-0032.json.zip"

echo "[1219/1710] Downloading: 2022 Q3 (part 21 of 32) (55.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0021-of-0032.json.zip"

echo "[1220/1710] Downloading: 2022 Q3 (part 22 of 32) (66.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0022-of-0032.json.zip"

echo "[1221/1710] Downloading: 2022 Q3 (part 23 of 32) (148.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0023-of-0032.json.zip"

echo "[1222/1710] Downloading: 2022 Q3 (part 24 of 32) (168.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0024-of-0032.json.zip"

echo "[1223/1710] Downloading: 2022 Q3 (part 25 of 32) (168.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0025-of-0032.json.zip"

echo "[1224/1710] Downloading: 2022 Q3 (part 26 of 32) (170.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0026-of-0032.json.zip"

echo "[1225/1710] Downloading: 2022 Q3 (part 27 of 32) (170.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0027-of-0032.json.zip"

echo "[1226/1710] Downloading: 2022 Q3 (part 28 of 32) (158.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0028-of-0032.json.zip"

echo "[1227/1710] Downloading: 2022 Q3 (part 29 of 32) (169.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0029-of-0032.json.zip"

echo "[1228/1710] Downloading: 2022 Q3 (part 30 of 32) (160.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0030-of-0032.json.zip"

echo "[1229/1710] Downloading: 2022 Q3 (part 31 of 32) (178.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0031-of-0032.json.zip"

echo "[1230/1710] Downloading: 2022 Q3 (part 32 of 32) (101.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q3/drug-event-0032-of-0032.json.zip"

echo "[1231/1710] Downloading: 2013 Q4 (part 1 of 19) (100.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0001-of-0019.json.zip"

echo "[1232/1710] Downloading: 2013 Q4 (part 2 of 19) (25.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0002-of-0019.json.zip"

echo "[1233/1710] Downloading: 2013 Q4 (part 3 of 19) (12.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0003-of-0019.json.zip"

echo "[1234/1710] Downloading: 2013 Q4 (part 4 of 19) (2.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0004-of-0019.json.zip"

echo "[1235/1710] Downloading: 2013 Q4 (part 5 of 19) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0005-of-0019.json.zip"

echo "[1236/1710] Downloading: 2013 Q4 (part 6 of 19) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0006-of-0019.json.zip"

echo "[1237/1710] Downloading: 2013 Q4 (part 7 of 19) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0007-of-0019.json.zip"

echo "[1238/1710] Downloading: 2013 Q4 (part 8 of 19) (2.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0008-of-0019.json.zip"

echo "[1239/1710] Downloading: 2013 Q4 (part 9 of 19) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0009-of-0019.json.zip"

echo "[1240/1710] Downloading: 2013 Q4 (part 10 of 19) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0010-of-0019.json.zip"

echo "[1241/1710] Downloading: 2013 Q4 (part 11 of 19) (6.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0011-of-0019.json.zip"

echo "[1242/1710] Downloading: 2013 Q4 (part 12 of 19) (11.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0012-of-0019.json.zip"

echo "[1243/1710] Downloading: 2013 Q4 (part 13 of 19) (20.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0013-of-0019.json.zip"

echo "[1244/1710] Downloading: 2013 Q4 (part 14 of 19) (37.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0014-of-0019.json.zip"

echo "[1245/1710] Downloading: 2013 Q4 (part 15 of 19) (61.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0015-of-0019.json.zip"

echo "[1246/1710] Downloading: 2013 Q4 (part 16 of 19) (109.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0016-of-0019.json.zip"

echo "[1247/1710] Downloading: 2013 Q4 (part 17 of 19) (115.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0017-of-0019.json.zip"

echo "[1248/1710] Downloading: 2013 Q4 (part 18 of 19) (102.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0018-of-0019.json.zip"

echo "[1249/1710] Downloading: 2013 Q4 (part 19 of 19) (49.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q4/drug-event-0019-of-0019.json.zip"

echo "[1250/1710] Downloading: 2021 Q1 (part 1 of 32) (157.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0001-of-0032.json.zip"

echo "[1251/1710] Downloading: 2021 Q1 (part 2 of 32) (123.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0002-of-0032.json.zip"

echo "[1252/1710] Downloading: 2021 Q1 (part 3 of 32) (79.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0003-of-0032.json.zip"

echo "[1253/1710] Downloading: 2021 Q1 (part 4 of 32) (8.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0004-of-0032.json.zip"

echo "[1254/1710] Downloading: 2021 Q1 (part 5 of 32) (16.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0005-of-0032.json.zip"

echo "[1255/1710] Downloading: 2021 Q1 (part 6 of 32) (7.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0006-of-0032.json.zip"

echo "[1256/1710] Downloading: 2021 Q1 (part 7 of 32) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0007-of-0032.json.zip"

echo "[1257/1710] Downloading: 2021 Q1 (part 8 of 32) (6.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0008-of-0032.json.zip"

echo "[1258/1710] Downloading: 2021 Q1 (part 9 of 32) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0009-of-0032.json.zip"

echo "[1259/1710] Downloading: 2021 Q1 (part 10 of 32) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0010-of-0032.json.zip"

echo "[1260/1710] Downloading: 2021 Q1 (part 11 of 32) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0011-of-0032.json.zip"

echo "[1261/1710] Downloading: 2021 Q1 (part 12 of 32) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0012-of-0032.json.zip"

echo "[1262/1710] Downloading: 2021 Q1 (part 13 of 32) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0013-of-0032.json.zip"

echo "[1263/1710] Downloading: 2021 Q1 (part 14 of 32) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0014-of-0032.json.zip"

echo "[1264/1710] Downloading: 2021 Q1 (part 15 of 32) (5.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0015-of-0032.json.zip"

echo "[1265/1710] Downloading: 2021 Q1 (part 16 of 32) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0016-of-0032.json.zip"

echo "[1266/1710] Downloading: 2021 Q1 (part 17 of 32) (11.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0017-of-0032.json.zip"

echo "[1267/1710] Downloading: 2021 Q1 (part 18 of 32) (12.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0018-of-0032.json.zip"

echo "[1268/1710] Downloading: 2021 Q1 (part 19 of 32) (12.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0019-of-0032.json.zip"

echo "[1269/1710] Downloading: 2021 Q1 (part 20 of 32) (11.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0020-of-0032.json.zip"

echo "[1270/1710] Downloading: 2021 Q1 (part 21 of 32) (49.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0021-of-0032.json.zip"

echo "[1271/1710] Downloading: 2021 Q1 (part 22 of 32) (27.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0022-of-0032.json.zip"

echo "[1272/1710] Downloading: 2021 Q1 (part 23 of 32) (64.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0023-of-0032.json.zip"

echo "[1273/1710] Downloading: 2021 Q1 (part 24 of 32) (136.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0024-of-0032.json.zip"

echo "[1274/1710] Downloading: 2021 Q1 (part 25 of 32) (141.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0025-of-0032.json.zip"

echo "[1275/1710] Downloading: 2021 Q1 (part 26 of 32) (155.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0026-of-0032.json.zip"

echo "[1276/1710] Downloading: 2021 Q1 (part 27 of 32) (154.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0027-of-0032.json.zip"

echo "[1277/1710] Downloading: 2021 Q1 (part 28 of 32) (156.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0028-of-0032.json.zip"

echo "[1278/1710] Downloading: 2021 Q1 (part 29 of 32) (156.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0029-of-0032.json.zip"

echo "[1279/1710] Downloading: 2021 Q1 (part 30 of 32) (152.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0030-of-0032.json.zip"

echo "[1280/1710] Downloading: 2021 Q1 (part 31 of 32) (151.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0031-of-0032.json.zip"

echo "[1281/1710] Downloading: 2021 Q1 (part 32 of 32) (145.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2021q1/drug-event-0032-of-0032.json.zip"

echo "[1282/1710] Downloading: 2018 Q1 (part 1 of 30) (11.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0001-of-0030.json.zip"

echo "[1283/1710] Downloading: 2018 Q1 (part 2 of 30) (19.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0002-of-0030.json.zip"

echo "[1284/1710] Downloading: 2018 Q1 (part 3 of 30) (9.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0003-of-0030.json.zip"

echo "[1285/1710] Downloading: 2018 Q1 (part 4 of 30) (19.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0004-of-0030.json.zip"

echo "[1286/1710] Downloading: 2018 Q1 (part 5 of 30) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0005-of-0030.json.zip"

echo "[1287/1710] Downloading: 2018 Q1 (part 6 of 30) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0006-of-0030.json.zip"

echo "[1288/1710] Downloading: 2018 Q1 (part 7 of 30) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0007-of-0030.json.zip"

echo "[1289/1710] Downloading: 2018 Q1 (part 8 of 30) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0008-of-0030.json.zip"

echo "[1290/1710] Downloading: 2018 Q1 (part 9 of 30) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0009-of-0030.json.zip"

echo "[1291/1710] Downloading: 2018 Q1 (part 10 of 30) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0010-of-0030.json.zip"

echo "[1292/1710] Downloading: 2018 Q1 (part 11 of 30) (5.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0011-of-0030.json.zip"

echo "[1293/1710] Downloading: 2018 Q1 (part 12 of 30) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0012-of-0030.json.zip"

echo "[1294/1710] Downloading: 2018 Q1 (part 13 of 30) (11.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0013-of-0030.json.zip"

echo "[1295/1710] Downloading: 2018 Q1 (part 14 of 30) (14.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0014-of-0030.json.zip"

echo "[1296/1710] Downloading: 2018 Q1 (part 15 of 30) (14.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0015-of-0030.json.zip"

echo "[1297/1710] Downloading: 2018 Q1 (part 16 of 30) (46.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0016-of-0030.json.zip"

echo "[1298/1710] Downloading: 2018 Q1 (part 17 of 30) (44.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0017-of-0030.json.zip"

echo "[1299/1710] Downloading: 2018 Q1 (part 18 of 30) (43.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0018-of-0030.json.zip"

echo "[1300/1710] Downloading: 2018 Q1 (part 19 of 30) (65.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0019-of-0030.json.zip"

echo "[1301/1710] Downloading: 2018 Q1 (part 20 of 30) (117.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0020-of-0030.json.zip"

echo "[1302/1710] Downloading: 2018 Q1 (part 21 of 30) (117.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0021-of-0030.json.zip"

echo "[1303/1710] Downloading: 2018 Q1 (part 22 of 30) (114.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0022-of-0030.json.zip"

echo "[1304/1710] Downloading: 2018 Q1 (part 23 of 30) (122.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0023-of-0030.json.zip"

echo "[1305/1710] Downloading: 2018 Q1 (part 24 of 30) (120.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0024-of-0030.json.zip"

echo "[1306/1710] Downloading: 2018 Q1 (part 25 of 30) (113.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0025-of-0030.json.zip"

echo "[1307/1710] Downloading: 2018 Q1 (part 26 of 30) (119.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0026-of-0030.json.zip"

echo "[1308/1710] Downloading: 2018 Q1 (part 27 of 30) (123.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0027-of-0030.json.zip"

echo "[1309/1710] Downloading: 2018 Q1 (part 28 of 30) (116.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0028-of-0030.json.zip"

echo "[1310/1710] Downloading: 2018 Q1 (part 29 of 30) (117.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0029-of-0030.json.zip"

echo "[1311/1710] Downloading: 2018 Q1 (part 30 of 30) (68.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q1/drug-event-0030-of-0030.json.zip"

echo "[1312/1710] Downloading: 2013 Q3 (part 1 of 15) (94.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0001-of-0015.json.zip"

echo "[1313/1710] Downloading: 2013 Q3 (part 2 of 15) (22.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0002-of-0015.json.zip"

echo "[1314/1710] Downloading: 2013 Q3 (part 3 of 15) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0003-of-0015.json.zip"

echo "[1315/1710] Downloading: 2013 Q3 (part 4 of 15) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0004-of-0015.json.zip"

echo "[1316/1710] Downloading: 2013 Q3 (part 5 of 15) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0005-of-0015.json.zip"

echo "[1317/1710] Downloading: 2013 Q3 (part 6 of 15) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0006-of-0015.json.zip"

echo "[1318/1710] Downloading: 2013 Q3 (part 7 of 15) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0007-of-0015.json.zip"

echo "[1319/1710] Downloading: 2013 Q3 (part 8 of 15) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0008-of-0015.json.zip"

echo "[1320/1710] Downloading: 2013 Q3 (part 9 of 15) (6.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0009-of-0015.json.zip"

echo "[1321/1710] Downloading: 2013 Q3 (part 10 of 15) (11.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0010-of-0015.json.zip"

echo "[1322/1710] Downloading: 2013 Q3 (part 11 of 15) (34.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0011-of-0015.json.zip"

echo "[1323/1710] Downloading: 2013 Q3 (part 12 of 15) (60.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0012-of-0015.json.zip"

echo "[1324/1710] Downloading: 2013 Q3 (part 13 of 15) (105.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0013-of-0015.json.zip"

echo "[1325/1710] Downloading: 2013 Q3 (part 14 of 15) (114.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0014-of-0015.json.zip"

echo "[1326/1710] Downloading: 2013 Q3 (part 15 of 15) (118.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2013q3/drug-event-0015-of-0015.json.zip"

echo "[1327/1710] Downloading: 2005 Q3 (part 1 of 5) (66.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q3/drug-event-0001-of-0005.json.zip"

echo "[1328/1710] Downloading: 2005 Q3 (part 2 of 5) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q3/drug-event-0002-of-0005.json.zip"

echo "[1329/1710] Downloading: 2005 Q3 (part 3 of 5) (12.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q3/drug-event-0003-of-0005.json.zip"

echo "[1330/1710] Downloading: 2005 Q3 (part 4 of 5) (108.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q3/drug-event-0004-of-0005.json.zip"

echo "[1331/1710] Downloading: 2005 Q3 (part 5 of 5) (118.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2005q3/drug-event-0005-of-0005.json.zip"

echo "[1332/1710] Downloading: 2023 Q4 (part 1 of 29) (161.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0001-of-0029.json.zip"

echo "[1333/1710] Downloading: 2023 Q4 (part 2 of 29) (70.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0002-of-0029.json.zip"

echo "[1334/1710] Downloading: 2023 Q4 (part 3 of 29) (20.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0003-of-0029.json.zip"

echo "[1335/1710] Downloading: 2023 Q4 (part 4 of 29) (92.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0004-of-0029.json.zip"

echo "[1336/1710] Downloading: 2023 Q4 (part 5 of 29) (116.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0005-of-0029.json.zip"

echo "[1337/1710] Downloading: 2023 Q4 (part 6 of 29) (19.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0006-of-0029.json.zip"

echo "[1338/1710] Downloading: 2023 Q4 (part 7 of 29) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0007-of-0029.json.zip"

echo "[1339/1710] Downloading: 2023 Q4 (part 8 of 29) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0008-of-0029.json.zip"

echo "[1340/1710] Downloading: 2023 Q4 (part 9 of 29) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0009-of-0029.json.zip"

echo "[1341/1710] Downloading: 2023 Q4 (part 10 of 29) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0010-of-0029.json.zip"

echo "[1342/1710] Downloading: 2023 Q4 (part 11 of 29) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0011-of-0029.json.zip"

echo "[1343/1710] Downloading: 2023 Q4 (part 12 of 29) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0012-of-0029.json.zip"

echo "[1344/1710] Downloading: 2023 Q4 (part 13 of 29) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0013-of-0029.json.zip"

echo "[1345/1710] Downloading: 2023 Q4 (part 14 of 29) (9.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0014-of-0029.json.zip"

echo "[1346/1710] Downloading: 2023 Q4 (part 15 of 29) (16.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0015-of-0029.json.zip"

echo "[1347/1710] Downloading: 2023 Q4 (part 16 of 29) (26.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0016-of-0029.json.zip"

echo "[1348/1710] Downloading: 2023 Q4 (part 17 of 29) (28.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0017-of-0029.json.zip"

echo "[1349/1710] Downloading: 2023 Q4 (part 18 of 29) (56.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0018-of-0029.json.zip"

echo "[1350/1710] Downloading: 2023 Q4 (part 19 of 29) (87.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0019-of-0029.json.zip"

echo "[1351/1710] Downloading: 2023 Q4 (part 20 of 29) (176.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0020-of-0029.json.zip"

echo "[1352/1710] Downloading: 2023 Q4 (part 21 of 29) (180.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0021-of-0029.json.zip"

echo "[1353/1710] Downloading: 2023 Q4 (part 22 of 29) (179.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0022-of-0029.json.zip"

echo "[1354/1710] Downloading: 2023 Q4 (part 23 of 29) (168.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0023-of-0029.json.zip"

echo "[1355/1710] Downloading: 2023 Q4 (part 24 of 29) (174.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0024-of-0029.json.zip"

echo "[1356/1710] Downloading: 2023 Q4 (part 25 of 29) (182.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0025-of-0029.json.zip"

echo "[1357/1710] Downloading: 2023 Q4 (part 26 of 29) (174.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0026-of-0029.json.zip"

echo "[1358/1710] Downloading: 2023 Q4 (part 27 of 29) (173.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0027-of-0029.json.zip"

echo "[1359/1710] Downloading: 2023 Q4 (part 28 of 29) (170.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0028-of-0029.json.zip"

echo "[1360/1710] Downloading: 2023 Q4 (part 29 of 29) (89.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2023q4/drug-event-0029-of-0029.json.zip"

echo "[1361/1710] Downloading: 2015 Q1 (part 1 of 25) (104.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0001-of-0025.json.zip"

echo "[1362/1710] Downloading: 2015 Q1 (part 2 of 25) (64.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0002-of-0025.json.zip"

echo "[1363/1710] Downloading: 2015 Q1 (part 3 of 25) (49.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0003-of-0025.json.zip"

echo "[1364/1710] Downloading: 2015 Q1 (part 4 of 25) (11.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0004-of-0025.json.zip"

echo "[1365/1710] Downloading: 2015 Q1 (part 5 of 25) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0005-of-0025.json.zip"

echo "[1366/1710] Downloading: 2015 Q1 (part 6 of 25) (9.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0006-of-0025.json.zip"

echo "[1367/1710] Downloading: 2015 Q1 (part 7 of 25) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0007-of-0025.json.zip"

echo "[1368/1710] Downloading: 2015 Q1 (part 8 of 25) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0008-of-0025.json.zip"

echo "[1369/1710] Downloading: 2015 Q1 (part 9 of 25) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0009-of-0025.json.zip"

echo "[1370/1710] Downloading: 2015 Q1 (part 10 of 25) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0010-of-0025.json.zip"

echo "[1371/1710] Downloading: 2015 Q1 (part 11 of 25) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0011-of-0025.json.zip"

echo "[1372/1710] Downloading: 2015 Q1 (part 12 of 25) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0012-of-0025.json.zip"

echo "[1373/1710] Downloading: 2015 Q1 (part 13 of 25) (6.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0013-of-0025.json.zip"

echo "[1374/1710] Downloading: 2015 Q1 (part 14 of 25) (12.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0014-of-0025.json.zip"

echo "[1375/1710] Downloading: 2015 Q1 (part 15 of 25) (13.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0015-of-0025.json.zip"

echo "[1376/1710] Downloading: 2015 Q1 (part 16 of 25) (36.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0016-of-0025.json.zip"

echo "[1377/1710] Downloading: 2015 Q1 (part 17 of 25) (45.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0017-of-0025.json.zip"

echo "[1378/1710] Downloading: 2015 Q1 (part 18 of 25) (87.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0018-of-0025.json.zip"

echo "[1379/1710] Downloading: 2015 Q1 (part 19 of 25) (109.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0019-of-0025.json.zip"

echo "[1380/1710] Downloading: 2015 Q1 (part 20 of 25) (107.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0020-of-0025.json.zip"

echo "[1381/1710] Downloading: 2015 Q1 (part 21 of 25) (134.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0021-of-0025.json.zip"

echo "[1382/1710] Downloading: 2015 Q1 (part 22 of 25) (115.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0022-of-0025.json.zip"

echo "[1383/1710] Downloading: 2015 Q1 (part 23 of 25) (123.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0023-of-0025.json.zip"

echo "[1384/1710] Downloading: 2015 Q1 (part 24 of 25) (117.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0024-of-0025.json.zip"

echo "[1385/1710] Downloading: 2015 Q1 (part 25 of 25) (116.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q1/drug-event-0025-of-0025.json.zip"

echo "[1386/1710] Downloading: 2016 Q2 (part 1 of 23) (12.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0001-of-0023.json.zip"

echo "[1387/1710] Downloading: 2016 Q2 (part 2 of 23) (18.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0002-of-0023.json.zip"

echo "[1388/1710] Downloading: 2016 Q2 (part 3 of 23) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0003-of-0023.json.zip"

echo "[1389/1710] Downloading: 2016 Q2 (part 4 of 23) (17.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0004-of-0023.json.zip"

echo "[1390/1710] Downloading: 2016 Q2 (part 5 of 23) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0005-of-0023.json.zip"

echo "[1391/1710] Downloading: 2016 Q2 (part 6 of 23) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0006-of-0023.json.zip"

echo "[1392/1710] Downloading: 2016 Q2 (part 7 of 23) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0007-of-0023.json.zip"

echo "[1393/1710] Downloading: 2016 Q2 (part 8 of 23) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0008-of-0023.json.zip"

echo "[1394/1710] Downloading: 2016 Q2 (part 9 of 23) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0009-of-0023.json.zip"

echo "[1395/1710] Downloading: 2016 Q2 (part 10 of 23) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0010-of-0023.json.zip"

echo "[1396/1710] Downloading: 2016 Q2 (part 11 of 23) (9.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0011-of-0023.json.zip"

echo "[1397/1710] Downloading: 2016 Q2 (part 12 of 23) (12.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0012-of-0023.json.zip"

echo "[1398/1710] Downloading: 2016 Q2 (part 13 of 23) (13.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0013-of-0023.json.zip"

echo "[1399/1710] Downloading: 2016 Q2 (part 14 of 23) (57.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0014-of-0023.json.zip"

echo "[1400/1710] Downloading: 2016 Q2 (part 15 of 23) (42.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0015-of-0023.json.zip"

echo "[1401/1710] Downloading: 2016 Q2 (part 16 of 23) (68.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0016-of-0023.json.zip"

echo "[1402/1710] Downloading: 2016 Q2 (part 17 of 23) (127.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0017-of-0023.json.zip"

echo "[1403/1710] Downloading: 2016 Q2 (part 18 of 23) (130.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0018-of-0023.json.zip"

echo "[1404/1710] Downloading: 2016 Q2 (part 19 of 23) (140.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0019-of-0023.json.zip"

echo "[1405/1710] Downloading: 2016 Q2 (part 20 of 23) (141.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0020-of-0023.json.zip"

echo "[1406/1710] Downloading: 2016 Q2 (part 21 of 23) (137.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0021-of-0023.json.zip"

echo "[1407/1710] Downloading: 2016 Q2 (part 22 of 23) (144.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0022-of-0023.json.zip"

echo "[1408/1710] Downloading: 2016 Q2 (part 23 of 23) (67.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2016q2/drug-event-0023-of-0023.json.zip"

echo "[1409/1710] Downloading: 2018 Q2 (part 1 of 32) (11.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0001-of-0032.json.zip"

echo "[1410/1710] Downloading: 2018 Q2 (part 2 of 32) (10.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0002-of-0032.json.zip"

echo "[1411/1710] Downloading: 2018 Q2 (part 3 of 32) (18.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0003-of-0032.json.zip"

echo "[1412/1710] Downloading: 2018 Q2 (part 4 of 32) (13.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0004-of-0032.json.zip"

echo "[1413/1710] Downloading: 2018 Q2 (part 5 of 32) (10.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0005-of-0032.json.zip"

echo "[1414/1710] Downloading: 2018 Q2 (part 6 of 32) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0006-of-0032.json.zip"

echo "[1415/1710] Downloading: 2018 Q2 (part 7 of 32) (3.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0007-of-0032.json.zip"

echo "[1416/1710] Downloading: 2018 Q2 (part 8 of 32) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0008-of-0032.json.zip"

echo "[1417/1710] Downloading: 2018 Q2 (part 9 of 32) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0009-of-0032.json.zip"

echo "[1418/1710] Downloading: 2018 Q2 (part 10 of 32) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0010-of-0032.json.zip"

echo "[1419/1710] Downloading: 2018 Q2 (part 11 of 32) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0011-of-0032.json.zip"

echo "[1420/1710] Downloading: 2018 Q2 (part 12 of 32) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0012-of-0032.json.zip"

echo "[1421/1710] Downloading: 2018 Q2 (part 13 of 32) (7.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0013-of-0032.json.zip"

echo "[1422/1710] Downloading: 2018 Q2 (part 14 of 32) (9.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0014-of-0032.json.zip"

echo "[1423/1710] Downloading: 2018 Q2 (part 15 of 32) (9.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0015-of-0032.json.zip"

echo "[1424/1710] Downloading: 2018 Q2 (part 16 of 32) (12.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0016-of-0032.json.zip"

echo "[1425/1710] Downloading: 2018 Q2 (part 17 of 32) (11.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0017-of-0032.json.zip"

echo "[1426/1710] Downloading: 2018 Q2 (part 18 of 32) (43.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0018-of-0032.json.zip"

echo "[1427/1710] Downloading: 2018 Q2 (part 19 of 32) (45.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0019-of-0032.json.zip"

echo "[1428/1710] Downloading: 2018 Q2 (part 20 of 32) (47.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0020-of-0032.json.zip"

echo "[1429/1710] Downloading: 2018 Q2 (part 21 of 32) (56.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0021-of-0032.json.zip"

echo "[1430/1710] Downloading: 2018 Q2 (part 22 of 32) (117.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0022-of-0032.json.zip"

echo "[1431/1710] Downloading: 2018 Q2 (part 23 of 32) (125.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0023-of-0032.json.zip"

echo "[1432/1710] Downloading: 2018 Q2 (part 24 of 32) (119.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0024-of-0032.json.zip"

echo "[1433/1710] Downloading: 2018 Q2 (part 25 of 32) (123.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0025-of-0032.json.zip"

echo "[1434/1710] Downloading: 2018 Q2 (part 26 of 32) (114.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0026-of-0032.json.zip"

echo "[1435/1710] Downloading: 2018 Q2 (part 27 of 32) (108.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0027-of-0032.json.zip"

echo "[1436/1710] Downloading: 2018 Q2 (part 28 of 32) (124.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0028-of-0032.json.zip"

echo "[1437/1710] Downloading: 2018 Q2 (part 29 of 32) (123.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0029-of-0032.json.zip"

echo "[1438/1710] Downloading: 2018 Q2 (part 30 of 32) (121.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0030-of-0032.json.zip"

echo "[1439/1710] Downloading: 2018 Q2 (part 31 of 32) (122.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0031-of-0032.json.zip"

echo "[1440/1710] Downloading: 2018 Q2 (part 32 of 32) (52.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2018q2/drug-event-0032-of-0032.json.zip"

echo "[1441/1710] Downloading: 2017 Q2 (part 1 of 25) (11.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0001-of-0025.json.zip"

echo "[1442/1710] Downloading: 2017 Q2 (part 2 of 25) (20.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0002-of-0025.json.zip"

echo "[1443/1710] Downloading: 2017 Q2 (part 3 of 25) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0003-of-0025.json.zip"

echo "[1444/1710] Downloading: 2017 Q2 (part 4 of 25) (16.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0004-of-0025.json.zip"

echo "[1445/1710] Downloading: 2017 Q2 (part 5 of 25) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0005-of-0025.json.zip"

echo "[1446/1710] Downloading: 2017 Q2 (part 6 of 25) (3.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0006-of-0025.json.zip"

echo "[1447/1710] Downloading: 2017 Q2 (part 7 of 25) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0007-of-0025.json.zip"

echo "[1448/1710] Downloading: 2017 Q2 (part 8 of 25) (3.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0008-of-0025.json.zip"

echo "[1449/1710] Downloading: 2017 Q2 (part 9 of 25) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0009-of-0025.json.zip"

echo "[1450/1710] Downloading: 2017 Q2 (part 10 of 25) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0010-of-0025.json.zip"

echo "[1451/1710] Downloading: 2017 Q2 (part 11 of 25) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0011-of-0025.json.zip"

echo "[1452/1710] Downloading: 2017 Q2 (part 12 of 25) (9.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0012-of-0025.json.zip"

echo "[1453/1710] Downloading: 2017 Q2 (part 13 of 25) (12.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0013-of-0025.json.zip"

echo "[1454/1710] Downloading: 2017 Q2 (part 14 of 25) (14.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0014-of-0025.json.zip"

echo "[1455/1710] Downloading: 2017 Q2 (part 15 of 25) (46.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0015-of-0025.json.zip"

echo "[1456/1710] Downloading: 2017 Q2 (part 16 of 25) (48.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0016-of-0025.json.zip"

echo "[1457/1710] Downloading: 2017 Q2 (part 17 of 25) (37.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0017-of-0025.json.zip"

echo "[1458/1710] Downloading: 2017 Q2 (part 18 of 25) (115.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0018-of-0025.json.zip"

echo "[1459/1710] Downloading: 2017 Q2 (part 19 of 25) (128.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0019-of-0025.json.zip"

echo "[1460/1710] Downloading: 2017 Q2 (part 20 of 25) (128.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0020-of-0025.json.zip"

echo "[1461/1710] Downloading: 2017 Q2 (part 21 of 25) (118.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0021-of-0025.json.zip"

echo "[1462/1710] Downloading: 2017 Q2 (part 22 of 25) (129.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0022-of-0025.json.zip"

echo "[1463/1710] Downloading: 2017 Q2 (part 23 of 25) (127.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0023-of-0025.json.zip"

echo "[1464/1710] Downloading: 2017 Q2 (part 24 of 25) (130.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0024-of-0025.json.zip"

echo "[1465/1710] Downloading: 2017 Q2 (part 25 of 25) (119.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q2/drug-event-0025-of-0025.json.zip"

echo "[1466/1710] Downloading: 2017 Q3 (part 1 of 26) (9.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0001-of-0026.json.zip"

echo "[1467/1710] Downloading: 2017 Q3 (part 2 of 26) (22.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0002-of-0026.json.zip"

echo "[1468/1710] Downloading: 2017 Q3 (part 3 of 26) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0003-of-0026.json.zip"

echo "[1469/1710] Downloading: 2017 Q3 (part 4 of 26) (16.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0004-of-0026.json.zip"

echo "[1470/1710] Downloading: 2017 Q3 (part 5 of 26) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0005-of-0026.json.zip"

echo "[1471/1710] Downloading: 2017 Q3 (part 6 of 26) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0006-of-0026.json.zip"

echo "[1472/1710] Downloading: 2017 Q3 (part 7 of 26) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0007-of-0026.json.zip"

echo "[1473/1710] Downloading: 2017 Q3 (part 8 of 26) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0008-of-0026.json.zip"

echo "[1474/1710] Downloading: 2017 Q3 (part 9 of 26) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0009-of-0026.json.zip"

echo "[1475/1710] Downloading: 2017 Q3 (part 10 of 26) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0010-of-0026.json.zip"

echo "[1476/1710] Downloading: 2017 Q3 (part 11 of 26) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0011-of-0026.json.zip"

echo "[1477/1710] Downloading: 2017 Q3 (part 12 of 26) (7.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0012-of-0026.json.zip"

echo "[1478/1710] Downloading: 2017 Q3 (part 13 of 26) (10.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0013-of-0026.json.zip"

echo "[1479/1710] Downloading: 2017 Q3 (part 14 of 26) (13.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0014-of-0026.json.zip"

echo "[1480/1710] Downloading: 2017 Q3 (part 15 of 26) (30.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0015-of-0026.json.zip"

echo "[1481/1710] Downloading: 2017 Q3 (part 16 of 26) (45.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0016-of-0026.json.zip"

echo "[1482/1710] Downloading: 2017 Q3 (part 17 of 26) (48.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0017-of-0026.json.zip"

echo "[1483/1710] Downloading: 2017 Q3 (part 18 of 26) (59.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0018-of-0026.json.zip"

echo "[1484/1710] Downloading: 2017 Q3 (part 19 of 26) (126.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0019-of-0026.json.zip"

echo "[1485/1710] Downloading: 2017 Q3 (part 20 of 26) (134.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0020-of-0026.json.zip"

echo "[1486/1710] Downloading: 2017 Q3 (part 21 of 26) (136.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0021-of-0026.json.zip"

echo "[1487/1710] Downloading: 2017 Q3 (part 22 of 26) (126.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0022-of-0026.json.zip"

echo "[1488/1710] Downloading: 2017 Q3 (part 23 of 26) (131.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0023-of-0026.json.zip"

echo "[1489/1710] Downloading: 2017 Q3 (part 24 of 26) (132.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0024-of-0026.json.zip"

echo "[1490/1710] Downloading: 2017 Q3 (part 25 of 26) (135.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0025-of-0026.json.zip"

echo "[1491/1710] Downloading: 2017 Q3 (part 26 of 26) (68.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2017q3/drug-event-0026-of-0026.json.zip"

echo "[1492/1710] Downloading: 2008 Q1 (part 1 of 8) (77.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0001-of-0008.json.zip"

echo "[1493/1710] Downloading: 2008 Q1 (part 2 of 8) (6.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0002-of-0008.json.zip"

echo "[1494/1710] Downloading: 2008 Q1 (part 3 of 8) (2.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0003-of-0008.json.zip"

echo "[1495/1710] Downloading: 2008 Q1 (part 4 of 8) (7.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0004-of-0008.json.zip"

echo "[1496/1710] Downloading: 2008 Q1 (part 5 of 8) (51.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0005-of-0008.json.zip"

echo "[1497/1710] Downloading: 2008 Q1 (part 6 of 8) (112.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0006-of-0008.json.zip"

echo "[1498/1710] Downloading: 2008 Q1 (part 7 of 8) (109.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0007-of-0008.json.zip"

echo "[1499/1710] Downloading: 2008 Q1 (part 8 of 8) (16.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2008q1/drug-event-0008-of-0008.json.zip"

echo "[1500/1710] Downloading: 2025 Q1 (part 1 of 28) (55.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0001-of-0028.json.zip"

echo "[1501/1710] Downloading: 2025 Q1 (part 2 of 28) (188.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0002-of-0028.json.zip"

echo "[1502/1710] Downloading: 2025 Q1 (part 3 of 28) (31.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0003-of-0028.json.zip"

echo "[1503/1710] Downloading: 2025 Q1 (part 4 of 28) (101.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0004-of-0028.json.zip"

echo "[1504/1710] Downloading: 2025 Q1 (part 5 of 28) (101.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0005-of-0028.json.zip"

echo "[1505/1710] Downloading: 2025 Q1 (part 6 of 28) (63.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0006-of-0028.json.zip"

echo "[1506/1710] Downloading: 2025 Q1 (part 7 of 28) (18.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0007-of-0028.json.zip"

echo "[1507/1710] Downloading: 2025 Q1 (part 8 of 28) (7.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0008-of-0028.json.zip"

echo "[1508/1710] Downloading: 2025 Q1 (part 9 of 28) (5.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0009-of-0028.json.zip"

echo "[1509/1710] Downloading: 2025 Q1 (part 10 of 28) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0010-of-0028.json.zip"

echo "[1510/1710] Downloading: 2025 Q1 (part 11 of 28) (4.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0011-of-0028.json.zip"

echo "[1511/1710] Downloading: 2025 Q1 (part 12 of 28) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0012-of-0028.json.zip"

echo "[1512/1710] Downloading: 2025 Q1 (part 13 of 28) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0013-of-0028.json.zip"

echo "[1513/1710] Downloading: 2025 Q1 (part 14 of 28) (11.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0014-of-0028.json.zip"

echo "[1514/1710] Downloading: 2025 Q1 (part 15 of 28) (27.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0015-of-0028.json.zip"

echo "[1515/1710] Downloading: 2025 Q1 (part 16 of 28) (16.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0016-of-0028.json.zip"

echo "[1516/1710] Downloading: 2025 Q1 (part 17 of 28) (56.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0017-of-0028.json.zip"

echo "[1517/1710] Downloading: 2025 Q1 (part 18 of 28) (96.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0018-of-0028.json.zip"

echo "[1518/1710] Downloading: 2025 Q1 (part 19 of 28) (187.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0019-of-0028.json.zip"

echo "[1519/1710] Downloading: 2025 Q1 (part 20 of 28) (197.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0020-of-0028.json.zip"

echo "[1520/1710] Downloading: 2025 Q1 (part 21 of 28) (215.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0021-of-0028.json.zip"

echo "[1521/1710] Downloading: 2025 Q1 (part 22 of 28) (205.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0022-of-0028.json.zip"

echo "[1522/1710] Downloading: 2025 Q1 (part 23 of 28) (213.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0023-of-0028.json.zip"

echo "[1523/1710] Downloading: 2025 Q1 (part 24 of 28) (218.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0024-of-0028.json.zip"

echo "[1524/1710] Downloading: 2025 Q1 (part 25 of 28) (206.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0025-of-0028.json.zip"

echo "[1525/1710] Downloading: 2025 Q1 (part 26 of 28) (223.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0026-of-0028.json.zip"

echo "[1526/1710] Downloading: 2025 Q1 (part 27 of 28) (215.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0027-of-0028.json.zip"

echo "[1527/1710] Downloading: 2025 Q1 (part 28 of 28) (159.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2025q1/drug-event-0028-of-0028.json.zip"

echo "[1528/1710] Downloading: 2020 Q1 (part 1 of 32) (133.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0001-of-0032.json.zip"

echo "[1529/1710] Downloading: 2020 Q1 (part 2 of 32) (111.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0002-of-0032.json.zip"

echo "[1530/1710] Downloading: 2020 Q1 (part 3 of 32) (100.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0003-of-0032.json.zip"

echo "[1531/1710] Downloading: 2020 Q1 (part 4 of 32) (8.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0004-of-0032.json.zip"

echo "[1532/1710] Downloading: 2020 Q1 (part 5 of 32) (21.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0005-of-0032.json.zip"

echo "[1533/1710] Downloading: 2020 Q1 (part 6 of 32) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0006-of-0032.json.zip"

echo "[1534/1710] Downloading: 2020 Q1 (part 7 of 32) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0007-of-0032.json.zip"

echo "[1535/1710] Downloading: 2020 Q1 (part 8 of 32) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0008-of-0032.json.zip"

echo "[1536/1710] Downloading: 2020 Q1 (part 9 of 32) (4.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0009-of-0032.json.zip"

echo "[1537/1710] Downloading: 2020 Q1 (part 10 of 32) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0010-of-0032.json.zip"

echo "[1538/1710] Downloading: 2020 Q1 (part 11 of 32) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0011-of-0032.json.zip"

echo "[1539/1710] Downloading: 2020 Q1 (part 12 of 32) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0012-of-0032.json.zip"

echo "[1540/1710] Downloading: 2020 Q1 (part 13 of 32) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0013-of-0032.json.zip"

echo "[1541/1710] Downloading: 2020 Q1 (part 14 of 32) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0014-of-0032.json.zip"

echo "[1542/1710] Downloading: 2020 Q1 (part 15 of 32) (9.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0015-of-0032.json.zip"

echo "[1543/1710] Downloading: 2020 Q1 (part 16 of 32) (11.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0016-of-0032.json.zip"

echo "[1544/1710] Downloading: 2020 Q1 (part 17 of 32) (13.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0017-of-0032.json.zip"

echo "[1545/1710] Downloading: 2020 Q1 (part 18 of 32) (12.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0018-of-0032.json.zip"

echo "[1546/1710] Downloading: 2020 Q1 (part 19 of 32) (10.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0019-of-0032.json.zip"

echo "[1547/1710] Downloading: 2020 Q1 (part 20 of 32) (41.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0020-of-0032.json.zip"

echo "[1548/1710] Downloading: 2020 Q1 (part 21 of 32) (32.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0021-of-0032.json.zip"

echo "[1549/1710] Downloading: 2020 Q1 (part 22 of 32) (56.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0022-of-0032.json.zip"

echo "[1550/1710] Downloading: 2020 Q1 (part 23 of 32) (90.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0023-of-0032.json.zip"

echo "[1551/1710] Downloading: 2020 Q1 (part 24 of 32) (150.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0024-of-0032.json.zip"

echo "[1552/1710] Downloading: 2020 Q1 (part 25 of 32) (149.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0025-of-0032.json.zip"

echo "[1553/1710] Downloading: 2020 Q1 (part 26 of 32) (153.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0026-of-0032.json.zip"

echo "[1554/1710] Downloading: 2020 Q1 (part 27 of 32) (147.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0027-of-0032.json.zip"

echo "[1555/1710] Downloading: 2020 Q1 (part 28 of 32) (146.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0028-of-0032.json.zip"

echo "[1556/1710] Downloading: 2020 Q1 (part 29 of 32) (151.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0029-of-0032.json.zip"

echo "[1557/1710] Downloading: 2020 Q1 (part 30 of 32) (150.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0030-of-0032.json.zip"

echo "[1558/1710] Downloading: 2020 Q1 (part 31 of 32) (149.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0031-of-0032.json.zip"

echo "[1559/1710] Downloading: 2020 Q1 (part 32 of 32) (127.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2020q1/drug-event-0032-of-0032.json.zip"

echo "[1560/1710] Downloading: 2015 Q4 (part 1 of 24) (68.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0001-of-0024.json.zip"

echo "[1561/1710] Downloading: 2015 Q4 (part 2 of 24) (22.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0002-of-0024.json.zip"

echo "[1562/1710] Downloading: 2015 Q4 (part 3 of 24) (12.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0003-of-0024.json.zip"

echo "[1563/1710] Downloading: 2015 Q4 (part 4 of 24) (17.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0004-of-0024.json.zip"

echo "[1564/1710] Downloading: 2015 Q4 (part 5 of 24) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0005-of-0024.json.zip"

echo "[1565/1710] Downloading: 2015 Q4 (part 6 of 24) (3.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0006-of-0024.json.zip"

echo "[1566/1710] Downloading: 2015 Q4 (part 7 of 24) (2.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0007-of-0024.json.zip"

echo "[1567/1710] Downloading: 2015 Q4 (part 8 of 24) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0008-of-0024.json.zip"

echo "[1568/1710] Downloading: 2015 Q4 (part 9 of 24) (4.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0009-of-0024.json.zip"

echo "[1569/1710] Downloading: 2015 Q4 (part 10 of 24) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0010-of-0024.json.zip"

echo "[1570/1710] Downloading: 2015 Q4 (part 11 of 24) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0011-of-0024.json.zip"

echo "[1571/1710] Downloading: 2015 Q4 (part 12 of 24) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0012-of-0024.json.zip"

echo "[1572/1710] Downloading: 2015 Q4 (part 13 of 24) (7.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0013-of-0024.json.zip"

echo "[1573/1710] Downloading: 2015 Q4 (part 14 of 24) (13.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0014-of-0024.json.zip"

echo "[1574/1710] Downloading: 2015 Q4 (part 15 of 24) (10.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0015-of-0024.json.zip"

echo "[1575/1710] Downloading: 2015 Q4 (part 16 of 24) (46.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0016-of-0024.json.zip"

echo "[1576/1710] Downloading: 2015 Q4 (part 17 of 24) (56.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0017-of-0024.json.zip"

echo "[1577/1710] Downloading: 2015 Q4 (part 18 of 24) (60.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0018-of-0024.json.zip"

echo "[1578/1710] Downloading: 2015 Q4 (part 19 of 24) (129.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0019-of-0024.json.zip"

echo "[1579/1710] Downloading: 2015 Q4 (part 20 of 24) (127.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0020-of-0024.json.zip"

echo "[1580/1710] Downloading: 2015 Q4 (part 21 of 24) (136.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0021-of-0024.json.zip"

echo "[1581/1710] Downloading: 2015 Q4 (part 22 of 24) (140.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0022-of-0024.json.zip"

echo "[1582/1710] Downloading: 2015 Q4 (part 23 of 24) (140.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0023-of-0024.json.zip"

echo "[1583/1710] Downloading: 2015 Q4 (part 24 of 24) (127.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q4/drug-event-0024-of-0024.json.zip"

echo "[1584/1710] Downloading: 2015 Q2 (part 1 of 23) (79.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0001-of-0023.json.zip"

echo "[1585/1710] Downloading: 2015 Q2 (part 2 of 23) (64.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0002-of-0023.json.zip"

echo "[1586/1710] Downloading: 2015 Q2 (part 3 of 23) (16.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0003-of-0023.json.zip"

echo "[1587/1710] Downloading: 2015 Q2 (part 4 of 23) (3.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0004-of-0023.json.zip"

echo "[1588/1710] Downloading: 2015 Q2 (part 5 of 23) (13.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0005-of-0023.json.zip"

echo "[1589/1710] Downloading: 2015 Q2 (part 6 of 23) (3.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0006-of-0023.json.zip"

echo "[1590/1710] Downloading: 2015 Q2 (part 7 of 23) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0007-of-0023.json.zip"

echo "[1591/1710] Downloading: 2015 Q2 (part 8 of 23) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0008-of-0023.json.zip"

echo "[1592/1710] Downloading: 2015 Q2 (part 9 of 23) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0009-of-0023.json.zip"

echo "[1593/1710] Downloading: 2015 Q2 (part 10 of 23) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0010-of-0023.json.zip"

echo "[1594/1710] Downloading: 2015 Q2 (part 11 of 23) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0011-of-0023.json.zip"

echo "[1595/1710] Downloading: 2015 Q2 (part 12 of 23) (7.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0012-of-0023.json.zip"

echo "[1596/1710] Downloading: 2015 Q2 (part 13 of 23) (11.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0013-of-0023.json.zip"

echo "[1597/1710] Downloading: 2015 Q2 (part 14 of 23) (13.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0014-of-0023.json.zip"

echo "[1598/1710] Downloading: 2015 Q2 (part 15 of 23) (43.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0015-of-0023.json.zip"

echo "[1599/1710] Downloading: 2015 Q2 (part 16 of 23) (51.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0016-of-0023.json.zip"

echo "[1600/1710] Downloading: 2015 Q2 (part 17 of 23) (74.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0017-of-0023.json.zip"

echo "[1601/1710] Downloading: 2015 Q2 (part 18 of 23) (88.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0018-of-0023.json.zip"

echo "[1602/1710] Downloading: 2015 Q2 (part 19 of 23) (110.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0019-of-0023.json.zip"

echo "[1603/1710] Downloading: 2015 Q2 (part 20 of 23) (127.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0020-of-0023.json.zip"

echo "[1604/1710] Downloading: 2015 Q2 (part 21 of 23) (105.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0021-of-0023.json.zip"

echo "[1605/1710] Downloading: 2015 Q2 (part 22 of 23) (126.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0022-of-0023.json.zip"

echo "[1606/1710] Downloading: 2015 Q2 (part 23 of 23) (10.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2015q2/drug-event-0023-of-0023.json.zip"

echo "[1607/1710] Downloading: 2022 Q1 (part 1 of 33) (157.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0001-of-0033.json.zip"

echo "[1608/1710] Downloading: 2022 Q1 (part 2 of 33) (110.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0002-of-0033.json.zip"

echo "[1609/1710] Downloading: 2022 Q1 (part 3 of 33) (105.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0003-of-0033.json.zip"

echo "[1610/1710] Downloading: 2022 Q1 (part 4 of 33) (6.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0004-of-0033.json.zip"

echo "[1611/1710] Downloading: 2022 Q1 (part 5 of 33) (12.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0005-of-0033.json.zip"

echo "[1612/1710] Downloading: 2022 Q1 (part 6 of 33) (12.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0006-of-0033.json.zip"

echo "[1613/1710] Downloading: 2022 Q1 (part 7 of 33) (72.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0007-of-0033.json.zip"

echo "[1614/1710] Downloading: 2022 Q1 (part 8 of 33) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0008-of-0033.json.zip"

echo "[1615/1710] Downloading: 2022 Q1 (part 9 of 33) (6.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0009-of-0033.json.zip"

echo "[1616/1710] Downloading: 2022 Q1 (part 10 of 33) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0010-of-0033.json.zip"

echo "[1617/1710] Downloading: 2022 Q1 (part 11 of 33) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0011-of-0033.json.zip"

echo "[1618/1710] Downloading: 2022 Q1 (part 12 of 33) (3.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0012-of-0033.json.zip"

echo "[1619/1710] Downloading: 2022 Q1 (part 13 of 33) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0013-of-0033.json.zip"

echo "[1620/1710] Downloading: 2022 Q1 (part 14 of 33) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0014-of-0033.json.zip"

echo "[1621/1710] Downloading: 2022 Q1 (part 15 of 33) (5.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0015-of-0033.json.zip"

echo "[1622/1710] Downloading: 2022 Q1 (part 16 of 33) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0016-of-0033.json.zip"

echo "[1623/1710] Downloading: 2022 Q1 (part 17 of 33) (9.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0017-of-0033.json.zip"

echo "[1624/1710] Downloading: 2022 Q1 (part 18 of 33) (11.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0018-of-0033.json.zip"

echo "[1625/1710] Downloading: 2022 Q1 (part 19 of 33) (11.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0019-of-0033.json.zip"

echo "[1626/1710] Downloading: 2022 Q1 (part 20 of 33) (12.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0020-of-0033.json.zip"

echo "[1627/1710] Downloading: 2022 Q1 (part 21 of 33) (12.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0021-of-0033.json.zip"

echo "[1628/1710] Downloading: 2022 Q1 (part 22 of 33) (45.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0022-of-0033.json.zip"

echo "[1629/1710] Downloading: 2022 Q1 (part 23 of 33) (50.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0023-of-0033.json.zip"

echo "[1630/1710] Downloading: 2022 Q1 (part 24 of 33) (112.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0024-of-0033.json.zip"

echo "[1631/1710] Downloading: 2022 Q1 (part 25 of 33) (191.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0025-of-0033.json.zip"

echo "[1632/1710] Downloading: 2022 Q1 (part 26 of 33) (196.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0026-of-0033.json.zip"

echo "[1633/1710] Downloading: 2022 Q1 (part 27 of 33) (188.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0027-of-0033.json.zip"

echo "[1634/1710] Downloading: 2022 Q1 (part 28 of 33) (192.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0028-of-0033.json.zip"

echo "[1635/1710] Downloading: 2022 Q1 (part 29 of 33) (190.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0029-of-0033.json.zip"

echo "[1636/1710] Downloading: 2022 Q1 (part 30 of 33) (193.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0030-of-0033.json.zip"

echo "[1637/1710] Downloading: 2022 Q1 (part 31 of 33) (190.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0031-of-0033.json.zip"

echo "[1638/1710] Downloading: 2022 Q1 (part 32 of 33) (185.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0032-of-0033.json.zip"

echo "[1639/1710] Downloading: 2022 Q1 (part 33 of 33) (181.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2022q1/drug-event-0033-of-0033.json.zip"

echo "[1640/1710] Downloading: 2019 Q3 (part 1 of 32) (111.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0001-of-0032.json.zip"

echo "[1641/1710] Downloading: 2019 Q3 (part 2 of 32) (70.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0002-of-0032.json.zip"

echo "[1642/1710] Downloading: 2019 Q3 (part 3 of 32) (8.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0003-of-0032.json.zip"

echo "[1643/1710] Downloading: 2019 Q3 (part 4 of 32) (24.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0004-of-0032.json.zip"

echo "[1644/1710] Downloading: 2019 Q3 (part 5 of 32) (5.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0005-of-0032.json.zip"

echo "[1645/1710] Downloading: 2019 Q3 (part 6 of 32) (5.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0006-of-0032.json.zip"

echo "[1646/1710] Downloading: 2019 Q3 (part 7 of 32) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0007-of-0032.json.zip"

echo "[1647/1710] Downloading: 2019 Q3 (part 8 of 32) (4.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0008-of-0032.json.zip"

echo "[1648/1710] Downloading: 2019 Q3 (part 9 of 32) (4.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0009-of-0032.json.zip"

echo "[1649/1710] Downloading: 2019 Q3 (part 10 of 32) (4.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0010-of-0032.json.zip"

echo "[1650/1710] Downloading: 2019 Q3 (part 11 of 32) (4.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0011-of-0032.json.zip"

echo "[1651/1710] Downloading: 2019 Q3 (part 12 of 32) (5.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0012-of-0032.json.zip"

echo "[1652/1710] Downloading: 2019 Q3 (part 13 of 32) (6.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0013-of-0032.json.zip"

echo "[1653/1710] Downloading: 2019 Q3 (part 14 of 32) (11.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0014-of-0032.json.zip"

echo "[1654/1710] Downloading: 2019 Q3 (part 15 of 32) (11.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0015-of-0032.json.zip"

echo "[1655/1710] Downloading: 2019 Q3 (part 16 of 32) (9.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0016-of-0032.json.zip"

echo "[1656/1710] Downloading: 2019 Q3 (part 17 of 32) (11.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0017-of-0032.json.zip"

echo "[1657/1710] Downloading: 2019 Q3 (part 18 of 32) (10.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0018-of-0032.json.zip"

echo "[1658/1710] Downloading: 2019 Q3 (part 19 of 32) (57.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0019-of-0032.json.zip"

echo "[1659/1710] Downloading: 2019 Q3 (part 20 of 32) (37.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0020-of-0032.json.zip"

echo "[1660/1710] Downloading: 2019 Q3 (part 21 of 32) (59.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0021-of-0032.json.zip"

echo "[1661/1710] Downloading: 2019 Q3 (part 22 of 32) (120.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0022-of-0032.json.zip"

echo "[1662/1710] Downloading: 2019 Q3 (part 23 of 32) (138.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0023-of-0032.json.zip"

echo "[1663/1710] Downloading: 2019 Q3 (part 24 of 32) (135.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0024-of-0032.json.zip"

echo "[1664/1710] Downloading: 2019 Q3 (part 25 of 32) (133.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0025-of-0032.json.zip"

echo "[1665/1710] Downloading: 2019 Q3 (part 26 of 32) (136.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0026-of-0032.json.zip"

echo "[1666/1710] Downloading: 2019 Q3 (part 27 of 32) (137.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0027-of-0032.json.zip"

echo "[1667/1710] Downloading: 2019 Q3 (part 28 of 32) (137.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0028-of-0032.json.zip"

echo "[1668/1710] Downloading: 2019 Q3 (part 29 of 32) (140.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0029-of-0032.json.zip"

echo "[1669/1710] Downloading: 2019 Q3 (part 30 of 32) (136.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0030-of-0032.json.zip"

echo "[1670/1710] Downloading: 2019 Q3 (part 31 of 32) (139.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0031-of-0032.json.zip"

echo "[1671/1710] Downloading: 2019 Q3 (part 32 of 32) (55.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q3/drug-event-0032-of-0032.json.zip"

echo "[1672/1710] Downloading: 2019 Q4 (part 1 of 29) (123.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0001-of-0029.json.zip"

echo "[1673/1710] Downloading: 2019 Q4 (part 2 of 29) (102.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0002-of-0029.json.zip"

echo "[1674/1710] Downloading: 2019 Q4 (part 3 of 29) (42.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0003-of-0029.json.zip"

echo "[1675/1710] Downloading: 2019 Q4 (part 4 of 29) (21.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0004-of-0029.json.zip"

echo "[1676/1710] Downloading: 2019 Q4 (part 5 of 29) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0005-of-0029.json.zip"

echo "[1677/1710] Downloading: 2019 Q4 (part 6 of 29) (6.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0006-of-0029.json.zip"

echo "[1678/1710] Downloading: 2019 Q4 (part 7 of 29) (4.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0007-of-0029.json.zip"

echo "[1679/1710] Downloading: 2019 Q4 (part 8 of 29) (3.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0008-of-0029.json.zip"

echo "[1680/1710] Downloading: 2019 Q4 (part 9 of 29) (4.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0009-of-0029.json.zip"

echo "[1681/1710] Downloading: 2019 Q4 (part 10 of 29) (3.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0010-of-0029.json.zip"

echo "[1682/1710] Downloading: 2019 Q4 (part 11 of 29) (4.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0011-of-0029.json.zip"

echo "[1683/1710] Downloading: 2019 Q4 (part 12 of 29) (5.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0012-of-0029.json.zip"

echo "[1684/1710] Downloading: 2019 Q4 (part 13 of 29) (8.1 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0013-of-0029.json.zip"

echo "[1685/1710] Downloading: 2019 Q4 (part 14 of 29) (11.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0014-of-0029.json.zip"

echo "[1686/1710] Downloading: 2019 Q4 (part 15 of 29) (15.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0015-of-0029.json.zip"

echo "[1687/1710] Downloading: 2019 Q4 (part 16 of 29) (20.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0016-of-0029.json.zip"

echo "[1688/1710] Downloading: 2019 Q4 (part 17 of 29) (52.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0017-of-0029.json.zip"

echo "[1689/1710] Downloading: 2019 Q4 (part 18 of 29) (45.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0018-of-0029.json.zip"

echo "[1690/1710] Downloading: 2019 Q4 (part 19 of 29) (76.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0019-of-0029.json.zip"

echo "[1691/1710] Downloading: 2019 Q4 (part 20 of 29) (118.7 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0020-of-0029.json.zip"

echo "[1692/1710] Downloading: 2019 Q4 (part 21 of 29) (139.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0021-of-0029.json.zip"

echo "[1693/1710] Downloading: 2019 Q4 (part 22 of 29) (129.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0022-of-0029.json.zip"

echo "[1694/1710] Downloading: 2019 Q4 (part 23 of 29) (135.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0023-of-0029.json.zip"

echo "[1695/1710] Downloading: 2019 Q4 (part 24 of 29) (135.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0024-of-0029.json.zip"

echo "[1696/1710] Downloading: 2019 Q4 (part 25 of 29) (132.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0025-of-0029.json.zip"

echo "[1697/1710] Downloading: 2019 Q4 (part 26 of 29) (134.5 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0026-of-0029.json.zip"

echo "[1698/1710] Downloading: 2019 Q4 (part 27 of 29) (126.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0027-of-0029.json.zip"

echo "[1699/1710] Downloading: 2019 Q4 (part 28 of 29) (136.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0028-of-0029.json.zip"

echo "[1700/1710] Downloading: 2019 Q4 (part 29 of 29) (46.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2019q4/drug-event-0029-of-0029.json.zip"

echo "[1701/1710] Downloading: 2010 Q3 (part 1 of 10) (73.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0001-of-0010.json.zip"

echo "[1702/1710] Downloading: 2010 Q3 (part 2 of 10) (34.8 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0002-of-0010.json.zip"

echo "[1703/1710] Downloading: 2010 Q3 (part 3 of 10) (2.9 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0003-of-0010.json.zip"

echo "[1704/1710] Downloading: 2010 Q3 (part 4 of 10) (3.0 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0004-of-0010.json.zip"

echo "[1705/1710] Downloading: 2010 Q3 (part 5 of 10) (5.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0005-of-0010.json.zip"

echo "[1706/1710] Downloading: 2010 Q3 (part 6 of 10) (28.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0006-of-0010.json.zip"

echo "[1707/1710] Downloading: 2010 Q3 (part 7 of 10) (82.2 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0007-of-0010.json.zip"

echo "[1708/1710] Downloading: 2010 Q3 (part 8 of 10) (123.3 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0008-of-0010.json.zip"

echo "[1709/1710] Downloading: 2010 Q3 (part 9 of 10) (114.4 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0009-of-0010.json.zip"

echo "[1710/1710] Downloading: 2010 Q3 (part 10 of 10) (59.6 MB)"
wget -c -q --show-progress "https://download.open.fda.gov/drug/event/2010q3/drug-event-0010-of-0010.json.zip"

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
