#!/bin/dash
path="./*"
num=0
while [ -d ".snapshot.$num" ];do
	num=$((num+1))
done
dir=".snapshot.$num"
mkdir "$dir"
echo "Creating snapshot $num"
for file in $path; 
do
	if [ -f "$file" ];then
		
		if [ "$file" != "./snapshot-save.sh" ] && [ "$file" != "./snapshot-load.sh" ]; then
			cp "$file" "$dir"
		fi
	fi
done




