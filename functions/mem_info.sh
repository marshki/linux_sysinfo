#!/bin/bash 
#Template for creation of header and function 

#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    echo "------------------------------"
    echo "  ${h}"
    echo "------------------------------"
}

#### Display used and free memory info ####
function mem_info(){
    local processes=$(ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu) 
    # regex ps to define, extract, and sort top memory (then cpu) consuming processes  
        
    write_header "Free & Used Memory "        
    free --giga --human                                                 # free -gh  
    
    echo "------------------------------"
    echo "  Virtual Memory Statistics   "
    echo "------------------------------"
    vmstat
    
    echo "------------------------------"
    echo " Top 10 Memory Eating Process "
    echo "------------------------------"
    echo "${processes}" | head -11 |awk '{print $1, $2, $3, $4, $5, $6, $7}'
    
    # pause
}

mem_info 
