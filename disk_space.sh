#!/bin/bash 
# Function to retrieve disk space and 10 largest files on system 


function disk_space(){
    find / -type f -exec du -Sh {} + | sort -rh | head -n 10 
}
disk_space
