#!/bin/bash
# This script allows you to extract useful information from a *NIX host using a menu-driven interface. 

# Define variables 
LSB=/usr/bin/lsb_release 

# Display pause prompt
# $1-> Message (optional)
function pause(){
    local message="$@"
    [ -z $message ] && message="Press [Enter] key to continue."
    read -p "$message" readEnterKey
}

# Display on-screen menu
function show_menu(){
    date
    echo "--------------------------"
    echo "      Main Menu"
    echo "--------------------------"
        echo "  1. OS Info" 
        echo "  2. Hostname and DNS Info"
        echo "  E. Exit " 
}

# Display header message 
# $1 - message 
function write_header(){
    local h="$@"
    echo "--------------------------"
    echo "  ${h}"
    echo "--------------------------"
}

# Get info about Operating System 
function  os_info(){
    write_header "  System Info"
    echo "Operating System : $(uname)"
    [ -x $LSB ] && $LSB -a || echo "$LSB command is not installed (set \$LSB variable)"
    # pause "Press [Enter] key to continue..."
    pause 
}

# Get info about Host(DNS, IP, Hotname)
function host_info(){
    local dnsips=$(sed -e '/^$/d' /etc/resolv.conf |awk '{if (tolower($1)=="nameserver") print $2}')
    write_header "  Hostname and DNS Info"
    echo "Hostname : $(hostname -s)"
    echo "DNS Domain : $(hostname -d)"
    echo "Fully-qualified Domain Name (FQDN) : $(hostname -f)"
    echo "Network Address (IP) : $(hostname -i)"
    echo "DNS name servers (DNS IP) : ${dnsips}"
    pause
}

# Get input via the keyboard and make a decision using case..esac 
function read_input(){
    local c
    read -p "Enter your choice [ 1-2 ] " c
    case $c in
        1) os_info ;;
        2) host_info ;;
        E) echo "Ciao!"; exit 0 ;;
        *)
            echo "Please select between 1 and E."
            pause
    esac 
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
