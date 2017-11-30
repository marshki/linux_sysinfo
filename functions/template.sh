#!/bin/bash 
#Template for creation of header and function 

#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    printf "%s\n" "------------------------------"
    printf "%s\n" "  ${h}"
    printf "%s\n" "------------------------------"
}

#### Describe function ####

template(){

    write_header "Template"
    # pause 
}

template
