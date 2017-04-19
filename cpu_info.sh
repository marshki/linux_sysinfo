#!/bin/bash 
#### Define Variables ####

#### Display header message ####
# $1 - message

function write_header(){
    local h="$@"
    echo "------------------------------"
    echo "  ${h}"
    echo "------------------------------"
}

#### Get info about Operating System ####

function  cpu_info(){
    local cpu=$(cat /proc/cpuinfo | grep -m 1 -i 'model name' | awk '{$1=$2=$3=""; print $0}')  
        
    write_header "CPU Info"
    echo "CPU  : ${cpu}"          
    echo "Number of Cores: $(getconf _NPROCESSORS_ONLN)"  
    # printf '%s\n' "$cpu"


}                                                                      
    
cpu_info 
