#!/bin/bash 
# Display used and free memory info

function mem_info(){
        write_header "Free & Used Memory "
        free -m
    echo "**************************"
        echo "*** Virtual Memory Statistics ***"
    echo "**************************"
        vmstat
echo "**************************"
        echo "*** Top 5 Memory Eating Process ***"
echo "**************************"
        ps auxf | sort -nr -k 4 | head -5
        pause
}

