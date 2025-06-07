#!/usr/bin/env python3
import sys
import re
total_sum = 0
filename = sys.argv[1]
with open(filename) as f:
    text = f.read()
    numbers = re.findall(r'\d+', text)
    for number in numbers:
        total_sum += int(number)
print(total_sum)