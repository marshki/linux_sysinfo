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

function  os_info(){
    # local namevers=$(awk -F'[="]+' '/^(NAME|VERSION)=/{printf("%-17s: %s\n",$1,$2)}' /etc/os-release)  
        
    write_header "System Info"
    echo "Operating System : $(uname --kernel-name)"                # uname -s 
    echo "Kernel Version   : $(uname --kernel-release)"             # uname -r
    echo "Name             : $(cat /etc/*-release |grep --word-regexp "NAME="   |sed 's/NAME=//g; s/"//g')"
    echo "Version          : $(cat /etc/*-release |grep --word-regexp "VERSION="|sed 's/VERSION=//g; s/"//g')" 

}                                                                      
    
os_info 
