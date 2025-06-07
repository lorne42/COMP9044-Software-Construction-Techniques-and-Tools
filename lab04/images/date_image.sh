#!/bin/dash
text=$(ls -l "$1" | sed -E 's/^.* ([A-Za-z]+ [0-9]+ [0-9:]+).*$/\1/')
convert -gravity south -pointsize 36 -draw "text 0,10 '$text'" penguins.jpg temporary_file.jpg
