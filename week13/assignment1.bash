#! /bin/bash
clear

# filling courses.txt
bash Courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){
    echo -n "Please Input an Instructor Full Name: "
    read instName

    echo ""
    echo "Courses of $instName :"
    cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
    sed 's/;/ | /g'
    echo ""
}

function courseCountofInsts(){
    echo ""
    echo "Course-Instructor Distribution"
    cat "$courseFile" | cut -d';' -f7 | \
    grep -v "/" | grep -v "\.\.\." | \
    sort -n | uniq -c | sort -n -r
    echo ""
}

# TODO - 1
# Displays all courses in a given location
# Shows: course code, course name, course days, time, instructor
function displayCoursesofLocation(){
    echo -n "Please Input a Location: "
    read location

    echo ""
    echo "Courses in $location :"
    cat "$courseFile" | grep "$location" | cut -d';' -f1,2,4,5,7 | \
    sed 's/;/ | /g'
    echo ""
}

function displayCoursesofClassroom(){
    echo -n "Please Input Class Name: "
    read className

    echo ""
    echo "Courses in $className :"
    cat "$courseFile" | grep "$className" | cut -d';' -f1,2,5,6,7 | \
    sed 's/;/ | /g'
    echo ""
}

# TODO - 2
# Displays all courses with availability (seats > 0) for a given course code
function displayAvailableCourses(){
    echo -n "Please Input a Course Code: "
    read courseCode

    echo ""
    echo "Available Courses for $courseCode :"
    cat "$courseFile" | grep "$courseCode" | while read -r line;
    do
        seats=$(echo "$line" | cut -d';' -f6)
        if [[ "$seats" -gt 0 ]] 2>/dev/null; then
            echo "$line" | cut -d';' -f1,2,4,5,6,7 | sed 's/;/ | /g'
        fi
    done
    echo ""
}

function displayAvailableCourses(){
    echo -n "Please Input a Subject Name:"
    read subjectName

    echo ""
    echo "Available courses in $subjectName :"
    cat "$courseFile" | grep "^$subjectName" | while read -r line;
    do
        seats=$(echo "$line" | cut -d';' -f4)
        # Remove white space
        seats=$(echo "$seats" | tr -d ' ')
        if [[ "$seats" =~ ^[0-9]+$ ]] && [[ "$seats" -gt 0 ]]; then
            echo "$line" | sed 's/;/ | /g'
        fi
    done
    echo ""
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
        echo "[3] Display courses of a classroom"
        echo "[4] Display available courses of a subject"
	echo "[5] Exit"

    read userInput
    echo ""

    if [[ "$userInput" == "5" ]]; then
        echo "Goodbye"
        break

    elif [[ "$userInput" == "1" ]]; then
        displayCoursesofInst

    elif [[ "$userInput" == "2" ]]; then
        courseCountofInsts

    elif [[ "$userInput" == "3" ]]; then
                displayCoursesofClassroom

    elif [[ "$userInput" == "4" ]]; then
                displayAvailableCourses

# TODO - 3 Display a message, if an invalid input is given
    else
        echo "Invalid option. Please select one of the displayed items."
    fi
done
