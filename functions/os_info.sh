#!/bin/bash 

#### Display header message ####

os_values=(
"Operating System: " 
"Kernel Version: " 
"Name: " 
"Version: "
)


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

  write_info "${os_values[0]}" "$os"   
  write_info "${os_values[1]}" "$kernel"
  write_info "${os_values[2]}" "$name"
  write_info "${os_values[3]}" "$version"

  #printf "%s\\n" "Operating System : ${os}"                
  #printf "%s\\n" "Kernel Version   : ${kernel}"  
  #printf "%s\\n" "Name             : ${name}"  
  #printf "%s\\n" "Version          : ${version}"
}

os_info 
