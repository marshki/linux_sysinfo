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
    lscpu |grep --word-regexp 'Model name:'                 # grep -w 
    lscpu |grep --word-regexp 'Socket(s):'                  # ""
    lscpu |grep --word-regexp 'Core(s) per socket:'         # ""
    # Query lscpu for: `Model name`, `Sockets`, and `Core(s) per socket` 

    # pause 

}                                                                      
    
cpu_info 
