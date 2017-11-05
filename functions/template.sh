#!/bin/bash 
#Template for creation of header and function 

#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    echo "------------------------------"
    echo "  ${h}"
    echo "------------------------------"
}

#### Describe function ####

template(){

    write_header "Template"
    # pause 
}

template
