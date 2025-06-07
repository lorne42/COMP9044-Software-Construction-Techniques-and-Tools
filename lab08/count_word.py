#!/usr/bin/python3
import sys
import re
word = sys.argv[1]

input_text = sys.stdin.read()
occurrences = re.findall(r'\b' + re.escape(word) + r'\b', input_text, re.IGNORECASE)
times=len(occurrences)
print(f"{word} occurred {times} times")