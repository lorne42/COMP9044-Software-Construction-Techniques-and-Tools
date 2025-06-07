#!/bin/dash
fetch_courses() {
    local year=$1
    local prefix=$2
local undergrad_courses=$(curl -s "https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$year%20+unsw_psubject.studyLevel:undergraduate%20+unsw_psubject.educationalArea:$prefix*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:ugrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0" | jq -r '.contentlets[] | "\(.code) \(.title)"')


    local postgrad_courses=$(curl -s "https://www.handbook.unsw.edu.au/api/content/render/false/query/+unsw_psubject.implementationYear:$year%20+unsw_psubject.studyLevel:postgraduate%20+unsw_psubject.educationalArea:$prefix*%20+unsw_psubject.active:1%20+unsw_psubject.studyLevelValue:pgrd%20+deleted:false%20+working:true%20+live:true/orderby/unsw_psubject.code%20asc/limit/10000/offset/0" | jq -r '.contentlets[] | "\(.code) \(.title)"')

    echo "$undergrad_courses"'\n'"$postgrad_courses" | sed 's/^ *//;s/  */ /g;/^$/d' | sort | uniq
}

if [ $# -ne 2 ]; then
    echo "Usage: $0 <year> <course-prefix>"
    exit 1
fi

year=$1
prefix=$2

if [ ${#year} -ne 4 ] || ! [ "$year" -eq "$year" ] 2>/dev/null || [ "$year" -lt 2019 ] || [ "$year" -gt 2023 ]; then
    echo "$0: argument 1 must be an integer between 2019 and 2023"
    exit 1
fi

fetch_courses "$year" "$prefix"
