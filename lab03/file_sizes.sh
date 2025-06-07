#!/bin/dash
files=$(find . -maxdepth 1 -type f -name "*" | sort)
Smallfiles=""
Mediumfiles=""
Largefiles=""
for file in $files
do
	if [ -f "$file" ]; then
		line_num=$(wc -l < "$file")
		filename=$(basename "$file")
		if [ "$line_num" -lt 10 ]
		then
			Smallfiles="$Smallfiles $filename"
		elif [ "$line_num" -ge 10 ] && [ "$line_num" -lt 100 ]
		then
			Mediumfiles="$Mediumfiles $filename"
		else
			Largefiles="$Largefiles $filename"
		fi
	fi
done

echo "Small files:$Smallfiles"
echo "Medium-sized files:$Mediumfiles"
echo "Large files:$Largefiles"
	
