#!/bin/bash 

# TODO: Refactor 
# TODO: Works as part of the entire program, should modify to stand on its own 
 
#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    printf "%s\n" "------------------------------"
    printf "%s\n" "  ${h}"
    printf "%s\n" "------------------------------"
}

#### Display list of users currently logged on & a list of recently logged in users ####

function user_info(){

    write_header "User Info"

    local cmd="$1"
    case "$cmd" in
        who) write_header "Who is Online? "; who --heading;;                # who -H 
        last) write_header "Last 10 Logged in Users "; last -n 10 -a -d;;   # last -num 10 -a -d   
    esac
    
    # pause 
}

user_info
