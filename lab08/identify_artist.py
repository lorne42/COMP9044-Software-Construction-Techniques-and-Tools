#!/usr/bin/python3
import sys
import re
import glob
import math

if __name__ == "__main__":

    for file0 in sys.argv[1:]:
        with open(file0, 'r') as f:
            text = f.read()
            words = re.findall(r'[a-zA-Z]+', text)
            artist_word_counts = {}

            for file in glob.glob("lyrics/*.txt"):
                with open(file, 'r') as f:
                    artist = file.split('/')[-1].split('.')[0].replace('_', ' ')
                    text = f.read()
                    total_words = len(re.findall(r'[a-zA-Z]+', text))
                    result = 0
                    for word in words:
                        occurrences = re.findall(r'\b' + re.escape(word) + r'\b', text, re.IGNORECASE)
                        word_counts = len(occurrences)
                        frequency = ((word_counts + 1) / total_words)
                        result = math.log(frequency) + result
                    artist_word_counts[artist] = result
            most_likely_artist = max(artist_word_counts, key=artist_word_counts.get)
            print(f"{file0} most resembles the work of {most_likely_artist} (log-probability={artist_word_counts[most_likely_artist]:.1f})")