#!/bin/bash

logFile="/var/log/apache2/access.log"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
	cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f 7 | sort | uniq -c | sort -n
}

function histogram(){
	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '[' | sort \
                              | uniq)
	:> newtemp.txt
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d " " -f 1)
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done
	cat "newtemp.txt" | sort -n | uniq -c
}

function frequentVisitors(){
	# Call histogram and filter for counts greater than 10
	histogram | while read -r line;
	do
		local count=$(echo "$line" | cut -d ' ' -f 1)
		if [[ "$count" -gt 10 ]]; then
			echo "$line"
		fi
	done
}

function suspiciousVisitors(){
	# ioc.txt should contain indicators of attack, one per line
	# Example ioc.txt contents:
	# sqlmap
	# nikto
	# /etc/passwd
	# ../
	while read -r ioc;
	do
		grep "$ioc" "$logFile"
	done < ioc.txt | cut -d ' ' -f 1 | sort | uniq -c | sort -n
}

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display only Pages"
	echo "[4] Histogram"
	echo "[5] Frequent Visitors"
	echo "[6] Suspicious Visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	elif [[ "$userInput" == "3" ]]; then
		echo "Displaying only Pages:"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

	elif [[ "$userInput" == "5" ]]; then
		echo "Frequent Visitors:"
		frequentVisitors

	elif [[ "$userInput" == "6" ]]; then
		echo "Suspicious Visitors:"
		suspiciousVisitors

	else
		echo "Invalid option. Please select a valid menu item."
	fi
done
