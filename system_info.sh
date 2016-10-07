#!/bin/bash
# This script allows you to extract useful information from a *NIX host using a menu-driven interface. 

# Define Variables 
LSB=/usr/bin/lsb_release 

# Display pause prompt
# $1-> Message
function pause(){
    local message="$@"
    [ -z $message ] && message="Press [Enter] key to continue..."
    read -p "$message" readEnterKey
}

# Display on-screen menu
function show_menu(){
    date
    echo ""
    echo "  Main Menu   "
    echo ""
        echo "1. OS Info ;;" 
}

# Display header message 
# $1 - message 
function write_header(){
    local h="$@"
    echo ""
    echo "  ${h}    "
    echo ""
}

# Get info about OS 
function  os_info(){
    write_header "System Information"
    echo "Operating System : $(uname)"
    [ -x $LSB ] && $LSB -a || echo "$LSB command is not installed (set \$LSB variable)"
    # pause "Press [Enter] key to continue..."
    pause 
}

# Ignore CTRL+C, CTRL+Z and quit singles using the trap 
trap '' SIGINT SIGQUIT SIGTSTP

# Main logic 
while true 
do 
    clear 
    show_menu   # Display menu
    read_input  # Wait for user input
done 
