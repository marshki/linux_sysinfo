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
    
    write_header "CPU Info"
    lscpu |grep --ignore-case 'model name'
    lscpu |grep --ignore-case 'socket(s)'          
    lscpu |grep --ignore-case 'core(s) per socket'     
    # Query lscpu for: `model name`, `sockets`, and `numb

    # pause 

}                                                                      
    
cpu_info 
