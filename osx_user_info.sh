#!/bin/bash 

# Display a list of users currently logged on & a list of recently logged in users

function user_info(){
    local cmd="$1"
    case "$cmd" in
        who) write_header " Who is online? "; who -H; pause ;;
        last) write_header " Last 10 logged in users "; last -10; pause ;;
    esac
}

