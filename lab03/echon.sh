#!/bin/dash
if [ $# -ne 2 ]
then
    echo "Usage: ./echon.sh <number of lines> <string>"
elif echo "$1" | grep -q "[^0-9]"
then
    echo "./echon.sh: argument 1 must be a non-negative integer"
else
	i=1
	while [ $i -le $1 ]
	do
		echo "$2"
		i=$(expr $i + 1)
	done	
fi


