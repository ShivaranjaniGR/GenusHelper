# GenusHelper: Automated RTL Synthesis and QoR Dashboard
link to video walkthrough - https://www.youtube.com/watch?v=3chKxKhE2jU

GenusHelper is an automation framework for running Cadence Genus synthesis on multiple RTL design variants and timing constraints. It automatically generates SDC/TCL files, runs synthesis, parses timing/area/power reports, and creates a visual HTML dashboard for QoR comparison.

## Project Overview

The goal of this project is to simplify repetitive RTL synthesis experiments.

Instead of manually running Genus for every design and clock constraint, this tool automates the full flow:

```text
RTL Variants + Timing Config
        ↓
Generate SDC and Genus TCL
        ↓
Run Cadence Genus
        ↓
Extract Timing, Area, and Power Metrics
        ↓
Generate QoR CSV
        ↓
Create HTML Dashboard
```

## Features

- Supports multiple RTL design variants
- Supports multiple timing/frequency constraints
- Automatically generates:
  - SDC constraint files
  - Genus TCL scripts
  - Run folders for each experiment
- Runs Cadence Genus automatically through `csh` and `suite`
- Extracts key QoR metrics:
  - WNS
  - Timing status
  - Final pass/fail status
  - Cell count
  - Cell area
  - Total area
  - Leakage power
  - Internal power
  - Switching power
  - Dynamic power
  - Total power
- Generates a clean HTML dashboard with visual bar graphs
- Produces a final `qor_summary.csv` for analysis

## Project Structure

```text
GenusHelper/
├── inputs/
│   ├── rtl_variants.csv
│   └── timing_config.csv
│
├── rtl_source/
│   └── RTL design files
│
├── runs/
│   └── Auto-generated run folders
│
├── outputs/
│   ├── qor_summary.csv
│   ├── dashboard.py
│   └── dashboard/
│       └── dashboard.html
│
├── main.py
├── generate_sdc.py
├── generate_genus_tcl.py
├── parse_and_analyze.py
├── run_all.sh
└── README.md
```

## Input Files

### `inputs/rtl_variants.csv`

This file lists the RTL designs to synthesize.

Example:

```csv
variant_name,rtl_path,top_module,clock_port
SPI_Master_1,rtl_source/spi_master_1.v,spi_master,clk
spi_master_2,rtl_source/spi_master_2.v,spi_master,clk
```

### `inputs/timing_config.csv`

This file lists the timing constraint cases.

Example:

```csv
case_name,frequency_mhz,setup_uncertainty_ns,hold_uncertainty_ns,source_latency_max_ns,source_latency_min_ns
relaxed_100MHz,100,0.1,0.05,0.2,0.1
nominal_200MHz,200,0.1,0.05,0.2,0.1
aggressive_300MHz,300,0.1,0.05,0.2,0.1
```

## How to Run

From the main project folder:

```bash
cd GenusHelper
chmod +x run_all.sh
./run_all.sh
```
-------------
## EXCECUTION OF THE SCRIPT
<img width="911" height="960" alt="image" src="https://github.com/user-attachments/assets/9a5c84bd-f23c-4aff-bb48-c067657a6a5d" />

fig : Automatic generation of TCL run files and SDC files for each timing combination and for each RTL variant. After generation of sdc consraint and the tcl run file, Cadence genus is called and the design is Synthesised to obtain power area and timing reports.
The top-level script runs the complete flow:

-------------

## REPORT PARSING AND TABULATION, FOLLOWED BY CREATING HTML DASHBOARD
<img width="937" height="717" alt="image" src="https://github.com/user-attachments/assets/2a7fd893-7321-43e8-a0cc-48900aced7cc" />




--------------
# DOWLOADING THE DASHBOARD

<img width="773" height="295" alt="image" src="https://github.com/user-attachments/assets/610c32b5-df8b-4ff6-956c-46b65e34883e" />

<img width="1918" height="1137" alt="image" src="https://github.com/user-attachments/assets/78308249-db12-4b33-8914-dd923958440d" />

<img width="1911" height="943" alt="image" src="https://github.com/user-attachments/assets/74765232-271f-4d54-b091-f51f002518d3" />

---------------




```text
main.py
    ↓
parse_and_analyze.py
    ↓
dashboard.py
```

## Main Scripts

### `main.py`

Creates individual run folders, generates SDC/TCL files, and runs Cadence Genus.

Each run folder contains:

```text
constraints.sdc
run_genus.tcl
genus.log
timing.rpt
area.rpt
power.rpt
```

### `parse_and_analyze.py`

Parses Genus reports and creates:

```text
outputs/qor_summary.csv
```

### `dashboard.py`

Reads `qor_summary.csv` and generates:

```text
outputs/dashboard/dashboard.html
```

The dashboard includes:

- WNS comparison
- Area comparison
- Cell count comparison
- Dynamic power comparison
- Leakage power comparison
- Total power comparison
- Full QoR result table

## Output CSV Format

The final QoR CSV contains:

```csv
run_name,wns_ns,timing_status,final_status,cell_count,cell_area,total_area,leakage_power_W,internal_power_W,switching_power_W,dynamic_power_W,total_power_W
```

Example:

```csv
SPI_Master_1_aggressive_300MHz,2.657,MET,PASS,110,476.64,476.64,4.14584e-07,0.000117973,1.07301e-05,0.0001287031,0.000129118
```

## Viewing the Dashboard

After running the full flow, the dashboard is generated at:

```text
outputs/dashboard/dashboard.html
```



Then open it locally:

```bash
explorer.exe dashboard.html
```

or on Windows PowerShell:

```powershell
start dashboard.html
```

## Example Dashboard

The dashboard visually compares synthesis results across different RTL variants and timing constraints.

It helps quickly identify:

- Best timing implementation
- Lowest area implementation
- Lowest power implementation
- Passing and failing synthesis runs

## Tool Requirements

- Python 3
- Cadence Genus
- Access to standard cell `.lib` file
- `csh` environment with `suite` command configured

No external Python packages are required for the dashboard.  
The dashboard uses only built-in Python libraries and HTML/CSS.

## Current Design Case Study

This project was tested using multiple SPI Master RTL implementations under three timing constraints:

- Relaxed: 100 MHz
- Nominal: 200 MHz
- Aggressive: 300 MHz

The purpose was to compare different implementations of the same design functionality under identical synthesis conditions.

## Why This Project Matters

Manual synthesis comparison is repetitive and error-prone. GenusHelper makes the process:

- Faster
- Repeatable
- Organized
- Easier to analyze
- Suitable for RTL design exploration and QoR comparison

This project demonstrates automation of a real ASIC digital design flow using Cadence Genus.

## Future Improvements

Possible future additions:

- Support for more EDA tools
- Automatic PDF report generation
- GitHub Actions-style local run summary
- More detailed timing path extraction
- Multi-corner multi-mode synthesis support
- Interactive dashboard with filtering
- Automatic best-design recommendation

## Author

Developed as part of an RTL synthesis automation and QoR analysis project.
