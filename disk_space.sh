#!/bin/bash 
# Function to retrieve disk space and 10 largest files on system 
# For this to work correctly, user needs elevated privileges?


function disk_space(){
    find / -type f -exec du --separate-dirs --human-readable {} + | sort --reverse --human | head --lines=10 
    # find / -type f -exec du -Sh {} + | sort -rh | head -n 10
}

disk_space
