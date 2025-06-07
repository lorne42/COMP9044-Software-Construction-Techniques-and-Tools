#!/usr/bin/env python3
import re
import sys

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python whale_summary.py <filename1> [<filename2> ...]")
    else:
        species_counts = {}
        species_num={}
        for filename in sys.argv[1:]:
            with open(filename) as f:
                for line in f:
                    parts = line.split()
                    name=''
                    for i in range(2,len(parts)):
                        name=name+' '+parts[i]
                    name=name.lower().strip()
                    if name.endswith('s'):
                        name=name[:-1]
                    species = name
                    species_counts[species] = species_counts.get(species, 0) + 1
                    species_num[species] = species_num.get(species, 0) + int(parts[1])
        sorted_species = sorted(species_counts.items())
        for species, count in sorted_species:
            print(f"{species} observations: {count} pods, {species_num[species]} individuals")

                    