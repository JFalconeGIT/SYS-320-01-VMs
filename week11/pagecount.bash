#!/bin/bash

# Function to count how many times a page was accessed

pageCount() {
    cat /var/log/apache2/access.log | \
    cut -d' ' -f7 | \
    sort | \
    uniq -c | \
    sort -n
}

# Call Function

pageCount
