#!/bin/bash 
# Display used and free memory info

# This needs to be re-done :( There's no free command for starters. 
# There's also no vmstat command 
# ps doesn't accept -f as an option 

#################
### FUN TIMES ### 
#################


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

