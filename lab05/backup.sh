#!/bin/dash
if [ "$#" != 1 ]; then
	exit 1
elif [ -f "$1" ]; then
	num=0
	while [ -f ".$1.$num" ];do
		num=$((num+1))
	done
	cp "$1" ".$1.$num"
	echo "Backup of '$1' saved as '.$1.$num'"
else
	exit 1
fi
