#!/bin/dash
path="./*"
if [ "$#" != 1 ] || ! echo "$1" | grep -qE '^[0-9]+$';then
	exit 1
else
	num=0
	while [ -d ".snapshot.$num" ];do
		num=$((num+1))
	done
	dir=".snapshot.$num"
	mkdir "$dir"
	echo "Creating snapshot $num"
	for file in $path
	do
		if [ -f "$file" ];then
			
			if [ "$file" != "./snapshot-save.sh" ] && [ "$file" != "./snapshot-load.sh" ] ; then
				cp "$file" "$dir"
			fi
		fi
	done

	rdir=".snapshot.$1/*"
	for file in $path 
	do
		if [ -f "$file" ];then
			if [ "$file" != "./snapshot-save.sh" ] && [ "$file" != "./snapshot-load.sh" ]; then
				rm "$file"
			fi
		fi
	done
	for rfile in $rdir
	do
		cp "$rfile" "./"
	done
	echo "Restoring snapshot $1"
fi
