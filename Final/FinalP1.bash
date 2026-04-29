#!/bin/bash

# Challenge-1: Scrape IOC indicators from the team's web page
# Saves results to IOC.txt

IOC_URL="http://10.0.17.6/IOC.html"
OUTPUT_FILE="IOC.txt"

echo "[*] Fetching IOC list from $IOC_URL ..."

# Download the page and parse out IOC entries from the HTML table
# Strips HTML tags, removes blank lines, and trims whitespace

    curl -s "$IOC_URL" \
        | grep -oP '(?<=<td>)[^<]+' \
        | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' \
        | grep -v '^$' \
            > "$OUTPUT_FILE"

    if [[ $? -eq 0 && -s "$OUTPUT_FILE" ]]; then
        echo "[+] IOC list saved to $OUTPUT_FILE"
        echo "[+] Entries found:"
        cat "$OUTPUT_FILE"
    else
        echo "[-] Failed to retrieve IOC list or page is empty."
        exit 1
    fi
