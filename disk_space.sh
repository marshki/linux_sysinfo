#!/bin/bash 
# Function to retrieve disk space and 10 largest files on system 

# Bare-bones 

function disk_space(){
    echo "Retrieving results..."
    local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | sort --reverse --human |
    head --lines=10)
       
    echo "${largestfiles}"   
 
    # find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | sort --reverse --human | head --lines=10 
    # find / -type f -exec du -Sh {} + | sort -rh | head -n 10
}

disk_space
