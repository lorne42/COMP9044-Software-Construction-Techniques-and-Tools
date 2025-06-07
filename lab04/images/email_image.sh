#!/bin/dash
for image in "$@";do
	if [ -f "$image" ]; then
	       display "$image"
	       read -p "Address to e-mail this image to? " email
               if [ -z "$email" ]; then echo "No email sent" 
		       continue 
	       fi

    	       read -p "Message to accompany image? " message
  
    	       echo "$message" | mutt -s "Image: $image" -e "set copy=no" -a "$image" -- "$email" echo "$image sent to $email"
	
        else
	       echo "File '$image' not found."
	       continue
	fi
done
