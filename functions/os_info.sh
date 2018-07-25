#!/bin/bash 

#### Display header message ####

write_header() {
  local name=$1; shift;
  printf "%s\\n""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s\\n" "$@"
}

write_info(){
  local name=$1; shift; 
  printf "%s\\n""$name"
  printf "%s\\n" "$@"
} 

#### Get info about Operating System ####

function  os_info(){
  local os=$(uname --kernel-name)
  local kernel=$(uname --kernel-release)
  local name=$(awk '/^NAME=/' /etc/*-release |cut --delimiter=\" --field=2)        
  local version=$(awk '/^VERSION=/' /etc/*-release |cut --delimiter=\" --field=2)    

  write_header "System Info" "$os_info" 

  write_info "Operating System: " "$os"
  write_info "Kernel Version: " "$kernel"
  write_info "Name: " "$name"
  write_info "Version: " "$version"




  #printf "%s\\n" "Operating System : ${os}"                
  #printf "%s\\n" "Kernel Version   : ${kernel}"  
  #printf "%s\\n" "Name             : ${name}"  
  #printf "%s\\n" "Version          : ${version}"
}

os_info 
