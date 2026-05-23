import os
import re
import csv

BASE_DIR = "/home/userdata/22bec0985/GenusHelper"
RUNS_DIR = os.path.join(BASE_DIR, "runs")
OUTPUTS_DIR = os.path.join(BASE_DIR, "outputs")
OUT_CSV = os.path.join(OUTPUTS_DIR, "qor_summary.csv")

os.makedirs(OUTPUTS_DIR, exist_ok=True)

def read_file(path):
    if not os.path.exists(path):
        return ""
    with open(path, "r", errors="ignore") as f:
        return f.read()

def parse_timing(text):
    slack = "-"
    status = "UNKNOWN"

    m = re.search(r"Path\s+1:\s+(\w+)\s+\(([-\d.]+)\s+ps\)", text)
    if m:
        status = m.group(1)
        slack_ps = float(m.group(2))
        slack = slack_ps / 1000.0

    return slack, status

def parse_area(text):
    cell_count = "-"
    cell_area = "-"
    total_area = "-"

    for line in text.splitlines():
        parts = line.split()
        if len(parts) >= 5 and parts[0] not in ["Instance", "---"]:
            try:
                cell_count = int(parts[1])
                cell_area = float(parts[2])
                total_area = float(parts[4])
                break
            except:
                pass

    return cell_count, cell_area, total_area

def parse_power(text):
    leakage = internal = switching = total = dynamic = "-"

    m = re.search(
        r"Subtotal\s+([\deE\+\-\.]+)\s+([\deE\+\-\.]+)\s+([\deE\+\-\.]+)\s+([\deE\+\-\.]+)",
        text
    )

    if m:
        leakage = float(m.group(1))
        internal = float(m.group(2))
        switching = float(m.group(3))
        total = float(m.group(4))
        dynamic = internal + switching

    return leakage, internal, switching, dynamic, total

rows = []

for run_name in sorted(os.listdir(RUNS_DIR)):
    run_dir = os.path.join(RUNS_DIR, run_name)
    if not os.path.isdir(run_dir):
        continue

    timing_text = read_file(os.path.join(run_dir, "timing.rpt"))
    area_text = read_file(os.path.join(run_dir, "area.rpt"))
    power_text = read_file(os.path.join(run_dir, "power.rpt"))

    wns_ns, timing_status = parse_timing(timing_text)
    cell_count, cell_area, total_area = parse_area(area_text)
    leakage, internal, switching, dynamic, total_power = parse_power(power_text)

    final_status = "PASS" if isinstance(wns_ns, float) and wns_ns >= 0 else "FAIL"

    rows.append({
        "run_name": run_name,
        "wns_ns": wns_ns,
        "timing_status": timing_status,
        "final_status": final_status,
        "cell_count": cell_count,
        "cell_area": cell_area,
        "total_area": total_area,
        "leakage_power_W": leakage,
        "internal_power_W": internal,
        "switching_power_W": switching,
        "dynamic_power_W": dynamic,
        "total_power_W": total_power
    })

headers = [
    "run_name",
    "wns_ns",
    "timing_status",
    "final_status",
    "cell_count",
    "cell_area",
    "total_area",
    "leakage_power_W",
    "internal_power_W",
    "switching_power_W",
    "dynamic_power_W",
    "total_power_W"
]

with open(OUT_CSV, "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=headers)
    writer.writeheader()
    writer.writerows(rows)

print("\nQoR Summary")
print("-" * 100)
for r in rows:
    print(
        f"{r['run_name']:35s} "
        f"WNS={r['wns_ns']} ns  "
        f"Status={r['final_status']:5s}  "
        f"Area={r['total_area']}  "
        f"Power={r['total_power_W']} W"
    )

print("\nSaved CSV:")
print(OUT_CSV)
