#!/usr/bin/env python3
import re
import sys
orca_count=0
for file in sys.argv[1:]:
    with open(file) as f:
        lines=f.readlines()
        for line in lines:
            parts=line.split()
            number_of_whales = int(parts[1])
            if "orca" in line.lower():
                orca_count += number_of_whales
if orca_count == 1:
    print (f'{orca_count} Orca reported')
else:
    print (f'{orca_count} Orcas reported')

