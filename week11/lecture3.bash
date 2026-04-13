#!/bin/bash

# Parse access log for page2.html entries
# Display only IP address and page name
grep "page2.html" /var/log/apache2/access.log | cut -d'"' -f1,2 | grep -oE "([0-9]+\.){3}[0-9]+" | while read ip; do
    echo "$ip page2.html"
done
