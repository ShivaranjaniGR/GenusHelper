import csv
import os

CSV_PATH = "qor_summary.csv"
OUT_DIR = "dashboard"

os.makedirs(OUT_DIR, exist_ok=True)

rows = []

with open(CSV_PATH, "r") as f:
    reader = csv.DictReader(f)
    for row in reader:
        rows.append(row)

def to_float(value):
    try:
        return float(value)
    except:
        return 0.0

def make_bar_chart(rows, label_col, value_col, title, unit=""):
    values = [abs(to_float(r[value_col])) for r in rows]
    max_val = max(values) if values and max(values) != 0 else 1

    html = f"<h2>{title}</h2>"
    html += '<div class="chart">'

    for r in rows:
        label = r[label_col]
        value = to_float(r[value_col])
        width = abs(value) / max_val * 100

        html += f"""
        <div class="bar-row">
            <div class="bar-label">{label}</div>
            <div class="bar-wrap">
                <div class="bar" style="width:{width}%"></div>
            </div>
            <div class="bar-value">{value:.6g} {unit}</div>
        </div>
        """

    html += "</div>"
    return html

best_timing = max(rows, key=lambda x: to_float(x["wns_ns"]))
best_area = min(rows, key=lambda x: to_float(x["total_area"]))
best_power = min(rows, key=lambda x: to_float(x["total_power_W"]))

headers = rows[0].keys()

table_html = "<table><tr>"
for h in headers:
    table_html += f"<th>{h}</th>"
table_html += "</tr>"

for row in rows:
    table_html += "<tr>"
    for h in headers:
        value = row[h]
        if h == "final_status":
            css = "pass" if value == "PASS" else "fail"
            table_html += f'<td class="{css}">{value}</td>'
        else:
            table_html += f"<td>{value}</td>"
    table_html += "</tr>"

table_html += "</table>"

html = f"""
<html>
<head>
<title>Genus QoR Dashboard</title>

<style>
body {{
    font-family: Arial, sans-serif;
    background: #f4f6f8;
    padding: 30px;
    color: #222;
}}

h1 {{
    margin-bottom: 5px;
}}

.subtitle {{
    color: #555;
    margin-bottom: 25px;
}}

.card {{
    background: white;
    padding: 22px;
    margin-bottom: 24px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}}

.summary-grid {{
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
}}

.summary-box {{
    background: #f9fafb;
    padding: 16px;
    border-radius: 12px;
    border-left: 5px solid #2563eb;
}}

.summary-box h3 {{
    margin: 0;
    font-size: 16px;
    color: #374151;
}}

.summary-box p {{
    margin: 8px 0 0 0;
    font-size: 14px;
}}

.chart {{
    width: 100%;
}}

.bar-row {{
    display: flex;
    align-items: center;
    margin: 12px 0;
}}

.bar-label {{
    width: 270px;
    font-size: 13px;
    font-weight: bold;
    word-break: break-word;
}}

.bar-wrap {{
    flex: 1;
    background: #e5e7eb;
    height: 24px;
    border-radius: 12px;
    overflow: hidden;
}}

.bar {{
    height: 100%;
    background: #2563eb;
    border-radius: 12px;
}}

.bar-value {{
    width: 120px;
    text-align: right;
    font-size: 13px;
}}

table {{
    border-collapse: collapse;
    width: 100%;
    background: white;
    font-size: 13px;
}}

th, td {{
    border: 1px solid #ccc;
    padding: 8px;
    text-align: center;
}}

th {{
    background: #111827;
    color: white;
}}

.pass {{
    color: green;
    font-weight: bold;
}}

.fail {{
    color: red;
    font-weight: bold;
}}
</style>
</head>

<body>

<h1>Genus QoR Dashboard</h1>
<p class="subtitle">Automatic visual summary of timing, area, and power results.</p>

<div class="card">
<h2>Best Results</h2>

<div class="summary-grid">
    <div class="summary-box">
        <h3>Best Timing</h3>
        <p>{best_timing["run_name"]}</p>
        <p><b>WNS:</b> {best_timing["wns_ns"]} ns</p>
    </div>

    <div class="summary-box">
        <h3>Lowest Area</h3>
        <p>{best_area["run_name"]}</p>
        <p><b>Area:</b> {best_area["total_area"]}</p>
    </div>

    <div class="summary-box">
        <h3>Lowest Power</h3>
        <p>{best_power["run_name"]}</p>
        <p><b>Power:</b> {best_power["total_power_W"]} W</p>
    </div>
</div>
</div>

<div class="card">
{make_bar_chart(rows, "run_name", "wns_ns", "WNS Comparison", "ns")}
</div>

<div class="card">
{make_bar_chart(rows, "run_name", "total_area", "Area Comparison")}
</div>

<div class="card">
{make_bar_chart(rows, "run_name", "cell_count", "Cell Count Comparison")}
</div>

<div class="card">
{make_bar_chart(rows, "run_name", "dynamic_power_W", "Dynamic Power Comparison", "W")}
</div>

<div class="card">
{make_bar_chart(rows, "run_name", "leakage_power_W", "Leakage Power Comparison", "W")}
</div>

<div class="card">
{make_bar_chart(rows, "run_name", "total_power_W", "Total Power Comparison", "W")}
</div>

<div class="card">
<h2>Full QoR Table</h2>
{table_html}
</div>

</body>
</html>
"""

with open(f"{OUT_DIR}/dashboard.html", "w") as f:
    f.write(html)

print("Dashboard created successfully!")
print("Open: dashboard/dashboard.html")
