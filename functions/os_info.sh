#!/bin/bash 

#### Display header message ####
# $1 - message

function write_header(){
    local h="$@"
    printf "%s\n" "------------------------------"
    printf "%s\n" "  ${h}"
    printf "%s\n" "------------------------------"
}

#### Get info about Operating System ####

function  os_info(){
        
    write_header "System Info"
    printf "%s\n" "Operating System : $(uname --kernel-name)"                # uname -s 
    printf "%s\n" "Kernel Version   : $(uname --kernel-release)"             # uname -r
    printf "%s\n" "Name             : $(cat /etc/*-release |grep --word-regexp "NAME="   |sed 's/NAME=//g; s/"//g')"
    printf "%s\n" "Version          : $(cat /etc/*-release |grep --word-regexp "VERSION="|sed 's/VERSION=//g; s/"//g')" 

}                                                                      
    
os_info 
