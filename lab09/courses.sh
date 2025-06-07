#!/bin/dash

# Check if course prefix is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <course_prefix>"
    exit 1
fi

# Fetch the webpage content for the given course prefix
web_content=$(curl --location --silent "http://www.timetable.unsw.edu.au/2024/$1KENS.html")

# Extract course codes and names
course_list=$(echo "$web_content" | grep -E "$1[0-9]{4}.*" | grep -oP '(?<=>).*?(?=<)' | paste -d' ' - - | sort | uniq)

# Print the course codes and names
echo "$course_list"

