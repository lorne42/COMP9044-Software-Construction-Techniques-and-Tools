#!/usr/bin/python3
import sys
import re
import glob
import math
if __name__ == "__main__":

    
    words = sys.argv[1:]
    artist_word_counts = {}

    for file in glob.glob("lyrics/*.txt"):
        with open(file, 'r') as f:
            artist = file.split('/')[-1].split('.')[0].replace('_', ' ')
            text = f.read()
            total_words = len(re.findall(r'[a-zA-Z]+', text))
            result=0
            for word in words:
                occurrences = re.findall(r'\b' + re.escape(word) + r'\b', text, re.IGNORECASE)
                word_counts = len(occurrences)
                frequency = ((word_counts+1) / total_words)
                result=math.log(frequency)+result
            artist_word_counts[artist] = result
    sorted_artists = sorted(artist_word_counts.items())
    for artist, result in sorted_artists:
        print(f"{result:10.5f} {artist}")
