#!/bin/bash 

#### Display header message ####

write_header() {
  local name=$1; shift;
  printf "%s\\n""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s\\n" "$@"
}

#### Get info about Operating System ####

function  os_info(){
  local os=$(uname --kernel-name)
  local kernel=$(uname --kernel-release)
  local name=$()        
  local version=$()    

printf "%s\n" "Operating System : $(uname --kernel-name)"                # uname -s 
printf "%s\n" "Kernel Version   : $(uname --kernel-release)"             # uname -r
printf "%s\n" "Name             : $(cat /etc/*-release |grep --word-regexp "NAME="   |sed 's/NAME=//g; s/"//g')"
printf "%s\n" "Version          : $(cat /etc/*-release |grep --word-regexp "VERSION="|sed 's/VERSION=//g; s/"//g')" 

  write_header "System Info" "$os_info" 
}                                                                      
# awk -F= '{print $2}' /etc/*release    
os_info 
