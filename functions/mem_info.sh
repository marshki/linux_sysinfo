#!/bin/bash 
#Template for creation of header and function 

#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    printf "%s\n" "------------------------------"
    printf "%s\n" "  ${h}"
    printf "%s\n" "------------------------------"
}

#### Display used and free memory info ####
function mem_info(){
    local processes=$(ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu) 
    # regex ps to define, extract, and sort top memory (then cpu) consuming processes  
        
    write_header "Free & Used Memory "        
    free --giga --human                                                 # free -gh  
    
    printf "%s\n" "------------------------------"
    printf "%s\n" "  Virtual Memory Statistics   "
    printf "%s\n" "------------------------------"
    vmstat
    
    printf "%s\n" "------------------------------"
    printf "%s\n" " Top 10 Memory Eating Process "
    printf "%s\n" "------------------------------"
    printf "%s\n" "${processes}" | head -11 |awk '{print $1, $2, $3, $4, $5, $6, $7}'
    
    # pause
}

mem_info 
