#!/usr/bin/python3
import sys
import re

input_text = sys.stdin.read() 
words = re.findall(r'[a-zA-Z]+', input_text)
num=len(words)
print(f"{num} words")
