#!/usr/bin/python3
import requests
from bs4 import BeautifulSoup
import sys

def get_unsw_courses(prefix):
    url = f"http://www.timetable.unsw.edu.au/2024/{prefix}KENS.html"
    
    response = requests.get(url)
    
    if response.status_code != 200:
        print("Failed to retrieve the web page.")
        return []
    
    soup = BeautifulSoup(response.text, 'html.parser')

    course_table = soup.find_all('tr', class_='rowLowlight') + soup.find_all('tr', class_='rowHighlight')

    courses = []

    for row in course_table:
        cells = row.find_all('td', class_='data')
        course_code = cells[0].a.text
        course_name = cells[1].a.text

        courses.append(f"{course_code} {course_name}")
    courses.sort()
    courses = list(set(courses))

    courses.sort()
    for course in courses:
        print(course)
    
    return courses

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: ./courses_requests.py <course_prefix>")
        sys.exit(1)
    
    prefix = sys.argv[1]
    courses = get_unsw_courses(prefix)
    
