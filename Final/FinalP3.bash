#!/bin/bash

# Challenge-3: Convert report.txt into an HTML report
# Usage: bash htmlReport.bash
# Reads report.txt, writes /var/www/html/report.html

INPUT_FILE="report.txt"
OUTPUT_HTML="/var/www/html/report.html"

# ── Input validation ──────────────────────────────────────────────────────────
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "[-] $INPUT_FILE not found. Run scanLogs.bash first."
    exit 1
fi

# ── Build the HTML file ───────────────────────────────────────────────────────
cat > "$OUTPUT_HTML" << 'HTML_HEADER'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IOC Incident Report</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #1a1a2e;
      color: #e0e0e0;
      margin: 40px;
    }
    h1 {
      color: #e64560;
      border-bottom: 2px solid #e94560;
      padding-bottom: 8px;
    }
    p.meta {
      color: #aaa;
      font-size: 0.9em;
      margin-top: -10px;
      margin-bottom: 20px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      background-color: #16213e;
    }
    thead tr {
      background-color: #e64560;
      color: #fff;
    }
    th, td {
      padding: 10px 14px;
      text-align: left;
      border: 1px solid #0f3460;
      font-size: 0.92em;
    }
    tbody tr:nth-child(even) {
      background-color: #0f3460;
    }
    tbody tr:hover {
      background-color: #e9456033;
    }
  </style>
</head>
<body>
  <h1>&#9888; IOC Incident Report</h1>
  <p class="meta">Generated: $(date '+%Y-%m-%d %H:%M:%S')</p>
  <table>
    <thead>
      <tr>
        <th>IP Address</th>
        <th>Date / Time</th>
        <th>Page Accessed</th>
      </tr>
    </thead>
    <tbody>
HTML_HEADER

# Re-write the header block so $(date) is evaluated (heredoc used 'HTML_HEADER' quoted = no expansion)
# Replace the placeholder with the real date
sed -i "s/Generated: \$(date '+%Y-%m-%d %H:%M:%S')/Generated: $(date '+%Y-%m-%d %H:%M:%S')/" "$OUTPUT_HTML"

# ── Loop through report.txt and add a table row per line ─────────────────────
while IFS= read -r line; do
    [[ -z "$line" ]] && continue

    # report.txt columns: IP  Date Time+offset  Page
    ip=$(echo "$line"       | awk '{print $1}')
    datetime=$(echo "$line" | awk '{print $2, $3}')
    page=$(echo "$line"     | awk '{print $4}')

    echo "      <tr><td>$ip</td><td>$datetime</td><td>$page</td></tr>" >> "$OUTPUT_HTML"
done < "$INPUT_FILE"

# ── Close the HTML ────────────────────────────────────────────────────────────
cat >> "$OUTPUT_HTML" << 'HTML_FOOTER'
    </tbody>
  </table>
</body>
</html>
HTML_FOOTER

echo "[+] Report written to $OUTPUT_HTML"
echo "[+] Open your browser and navigate to http://<10.0.17.14>/report.html"
