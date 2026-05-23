#!/bin/bash

echo "======================================"
echo " GenusHelper Full Automation Started"
echo "======================================"

# Step 1: Run main automation
# main.py creates run folders, generates SDC/TCL, and runs Genus using csh + suite
echo "[1/3] Creating runs and running Genus..."
python3 main.py

if [ $? -ne 0 ]; then
    echo "ERROR: main.py failed. Stopping."
    exit 1
fi

# Step 2: Parse reports and create QoR CSV
echo "[2/3] Parsing reports..."
python3 parse_and_analyze.py

if [ $? -ne 0 ]; then
    echo "ERROR: parse_and_analyze.py failed. Stopping."
    exit 1
fi

# Step 3: Generate dashboard
echo "[3/3] Creating dashboard..."
cd outputs || exit 1
python3 dashboard.py
cd ..

if [ $? -ne 0 ]; then
    echo "ERROR: dashboard.py failed. Stopping."
    exit 1
fi

echo "======================================"
echo " Dashboard generated successfully!"
echo "======================================"
echo "File location:"
echo "outputs/dashboard/dashboard.html"
echo ""
echo "To download from your laptop, run:"
echo "scp 22bec0985@cadence.vit.ac.in:/home/userdata/22bec0985/GenusHelper/outputs/dashboard/dashboard.html ."
echo ""
echo "Then open:"
echo "explorer.exe dashboard.html"
