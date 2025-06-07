#!/bin/dash
for jpg_image in *.jpg; do
    if [ -f "$jpg_image" ]; then
        file_name=$(basename "$jpg_image" .jpg)
        if [ -e "${file_name}.png" ]; then
            echo "${file_name}.png already exists"
            exit 1
        fi
     
        convert "$jpg_image" "${file_name}.png"
        if [ $? -eq 0 ]; then
   
            rm "$jpg_image"
        else
            echo "Error: Conversion of $jpg_image to PNG failed."
            exit 1
        fi
    fi
done

