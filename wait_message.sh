#!/bin/bash
# Function to provide user feedback  

function disk_use() { 
    find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null
} 

function wait_message() { 
    echo -n "Please wait..."
    while true
    do
        echo -n "."
        sleep .2
    done
} 

disk_use & 

