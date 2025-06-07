#!/bin/dash
find "$@" -type f -name "*.mp3" | while read -r music_file;do
	if [ -f "$music_file" ]; then
	filename=$(basename "$music_file")
	Album=$(echo "$music_file" | awk -F '/' '{print $(NF-1)}')
	year=$(echo "$music_file" | awk -F '/' '{print $(NF-1)}' | awk -F ', ' '{print $2}')	track=$(echo "$filename" | awk -F ' - ' '{print $1}')
	title=$(echo "$filename" | awk -F ' - ' '{print $2}')
	artist=$(echo "$filename" | awk -F ' - ' '{print $3}' | awk -F '.' '{print $1}')	
	id3 -t "$title" -T "$track" -a "$artist" -A "$Album" -y "$year" "$music_file">/dev/null 2>&1
	fi
done
