#!/bin/bash 
#### Display information on disk space usage ####

function disk_space(){
    local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null) 
    # find largest files by disk space; output background noise to /dev/null 
    # find / -type f -exec du -Sh {} + 2>/dev/null
          
    echo "Retrieving largest files..."
    echo "${largestfiles}" |sort --reverse --human | head --lines=10                # sort -rh | head -n 10
 
    # find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | sort --reverse --human | head --lines=10 
    # find / -type f -exec du -Sh {} + | sort -rh | head -n 10
}

disk_space
