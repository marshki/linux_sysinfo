#!/bin/bash
# This script allows you to extract useful information from a *NIX host using a menu-driven interface. 

# Define variables 

LSB=/usr/bin/lsb_release 

# Display pause prompt
# $1-> Message (optional)

function pause(){
    local message="$@"
    [ -z $message ] && message="Press [Enter] key to continue:  "
    read -p "$message" readEnterKey
}

# Display on-screen menu

function show_menu(){
    date
    echo "--------------------------"
    echo "      Main Menu"
    echo "--------------------------"
        echo "  1. OS Info" 
        echo "  2. Hostname & DNS Info"
        echo "  3. Network Info"
        echo "  4. Who is Online"
        echo "  5. Last Logged in Users"
        echo "  6. Free & Used Memory Info"
        echo "  7. Exit" 
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

# Get info about Network Interface and Routing 

function net_info(){
    devices=$(netstat -i | cut -d" " -f1 | egrep -v "Kernel|Iface|lo")
    write_header "  Network Info"
    echo "Total network interfaces found : $(wc -w <<<${devices})"
    
    echo "*** IP Addresses Info ***"
    ip -4 address show 

    echo "**************************"
    echo "**** Network Routing  ****"
    echo "**************************"
    netstat -nr 

    echo "**************************"
    echo "* Interface traffic Info *"
    echo "**************************"
    netstat -i 

    pause 
}

# Display a list of users currently logged on & a list of recently logged in users

function user_info(){
    local cmd="$1"
    case "$cmd" in
        who) write_header " Who is online? "; who -H; pause ;;
        last) write_header " List of last logged in users "; last; pause ;;
    esac
}

# Display used and free memory info 

function mem_info(){
        write_header "Free & Used Memory "
        free --giga --human                         # free -gh  

    echo "**************************"
        echo "*** Virtual Memory Statistics ***"
    echo "**************************"
        vmstat
echo "**************************"
        echo "*** Top 5 Memory Eating Process ***"
echo "**************************"
        ps auxf |sort --numeric-sort --reverse --key=4 |head -5  # sort -nr -k 4 | head -5           
        pause
}

# Get input via the keyboard and make a decision using case..esac 

function read_input(){
    local c
    read -p "Enter your choice [ 1-7 ]:  " c
    case $c in
        1) os_info ;;
        2) host_info ;;
        3) net_info ;; 
        4) user_info "who" ;;
        5) user_info "last" ;;
        6) mem_info ;;
        7) echo "Ciao!"; exit 0 ;;
        *)
            echo "Select an Option (1 to 7):  "
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
