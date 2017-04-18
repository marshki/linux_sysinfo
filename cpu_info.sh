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
    local cpu=$()  
        
    write_header "CPU Info"
    #echo "CPU  : $(*)"          
    #echo "Cores: $(*)"  
    printf '%s\n' "$cpu"


}                                                                      
    
cpu_info 
