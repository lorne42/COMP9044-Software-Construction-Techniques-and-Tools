#!/usr/bin/python3
import sys
import re
import glob

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python frequency.py <word>")
        sys.exit(1)
    
    word = sys.argv[1]
    artist_word_counts = {}

    for file in glob.glob("lyrics/*.txt"):
        with open(file, 'r') as f:
            artist = file.split('/')[-1].split('.')[0].replace('_', ' ')
            text = f.read()
            total_words = len(re.findall(r'[a-zA-Z]+', text))
            occurrences = re.findall(r'\b' + re.escape(word) + r'\b', text, re.IGNORECASE)
            word_counts = len(occurrences)
            frequency = (word_counts / total_words)
            artist_word_counts[artist] = (word_counts, total_words, frequency)
    sorted_artists = sorted(artist_word_counts.items())
    for artist, (word_counts, total_words, frequency) in sorted_artists:
        print(f"{word_counts:4}/{total_words:6} = {frequency:.9f} {artist}")
