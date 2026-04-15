#! /bin/bash

# This is the link we will scrape
link="10.0.17.6/Courses.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \

# If table is one div deep:
xmlstarlet select --template --copy-of "//html//body//div//table//tr")

# If table has a specifc class or id, target directly:
# xmlstarlet select --template --copy-of "//table//tr"

# Processing HTML with sed
# 1- Replacing every </tr> with a line break
echo "$toolOutput" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g' \
		      > courses.txt
