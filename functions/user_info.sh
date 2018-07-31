#!/bin/bash
 
#### Print header ####

write_header() {
  local name=$1; shift;
  printf "%s""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s" "$@"
}

#### Print info ####

write_info() {
  local name=$1; shift;
  printf "%s""$name%s"
  printf "%s\\n" "$@"
}

# TODO: Refactor 
# TODO: Works as part of the entire program, should modify to stand on its own 
 

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
