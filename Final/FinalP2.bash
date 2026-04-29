#!/bin/bash

# Challenge-2: Search Apache access logs for indicators of compromise (IOC)
# Usage: bash scanLogs.bash <log_file> <ioc_file>
# Output: report.txt  (IP, Date/Time, Page Accessed)

LOG_FILE="$1"
IOC_FILE="$2"
REPORT_FILE="report.txt"

# ── Input validation ──────────────────────────────────────────────────────────
if [[ -z "$LOG_FILE" || -z "$IOC_FILE" ]]; then
    echo "Usage: $0 <log_file> <ioc_file>"
    exit 1
fi

if [[ ! -f "$LOG_FILE" ]]; then
    echo "[-] Log file not found: $LOG_FILE"
    exit 1
fi

if [[ ! -f "$IOC_FILE" ]]; then
    echo "[-] IOC file not found: $IOC_FILE"
    exit 1
fi

# ── Scan ──────────────────────────────────────────────────────────────────────
> "$REPORT_FILE"   # clear / create report

echo "[*] Scanning $LOG_FILE against IOCs in $IOC_FILE ..."

while IFS= read -r ioc; do
    # Skip blank lines or comment lines in the IOC file
    [[ -z "$ioc" || "$ioc" == \#* ]] && continue

    # Search the log for lines that contain this IOC
    grep -F "$ioc" "$LOG_FILE" | while IFS= read -r line; do

        # Apache Combined Log Format:
        # IP - user [DD/Mon/YYYY:HH:MM:SS +ZZZZ] "METHOD /page HTTP/x.x" status size ...
        ip=$(echo "$line"      | awk '{print $1}')
        datetime=$(echo "$line" | awk '{print $4, $5}' | tr -d '[]')
        page=$(echo "$line"    | awk '{print $7}')

        echo "$ip  $datetime  $page" >> "$REPORT_FILE"
    done
done < "$IOC_FILE"

# ── Summary ───────────────────────────────────────────────────────────────────
if [[ -s "$REPORT_FILE" ]]; then
    count=$(wc -l < "$REPORT_FILE")
    echo "[+] $count matching log entries saved to $REPORT_FILE"
else
    echo "[!] No IOC matches found in $LOG_FILE"
fi
