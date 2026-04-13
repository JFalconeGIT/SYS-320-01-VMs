#!/bin/bash

# Previous pageCount function

pageCount() {
    cat /var/log/apache2/access.log | \
    cut -d' ' -f7 | \
    sort | \
    uniq -c | \
    sort -n
}

# New function - counts curl access per IP address

countingCurlAccess() {
    grep "curl" /var/log/apache2/access.log | \
    cut -d ' ' -f1,12 | \
    sort | \
    uniq -c | \
    sort -n
}

# Calling the function

countingCurlAccess
