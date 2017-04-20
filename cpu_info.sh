#!/bin/bash 

#### Display header message ####
# $1 - message

function write_header(){
    local h="$@"
    echo "------------------------------"
    echo "  ${h}"
    echo "------------------------------"
}

#### Get info about CPU ####

function  cpu_info(){
    # local cpu=$(cat /proc/cpuinfo |grep --max-count=1 --ignore-case 'model name' |awk '{$1=$2=$3=""; print $0}') # grep -m 1 -i '' 
    # regexp on /proc/cpuinfo to extract 1st match of CPU `model name`, then print everything to the right of 3rd column     
    
    write_header "CPU Info"
    lscpu |grep --ignore-case 'model name'
    lscpu |grep --ignore-case 'socket(s)'          
    lscpu |grep --ignore-case 'core(s) per socket'     
    # Query system configuration for number of cores 

    # pause 

}                                                                      
    
cpu_info 
