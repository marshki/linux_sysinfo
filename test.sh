#!/usr/bin/env bash 

#### Display pause prompt ####
# Suspend processing of script; display message prompting user to press [Enter] key to continue

function pause(){
    local message="$@"
    [ -z $message ] && message="Press [Enter] key to continue:  "
    read -p "$message" readEnterKey
}

function show_menu(){
    date
    echo "------------------------------"
    echo "  Main Menu                   "
    echo "------------------------------"
        echo "  1. OS Info"
        echo "  2. Quit" 
} 

#### Display header message ####
# $1 - message

function write_header(){
    local h="$@"
    echo "------------------------------"
    echo "  ${h}"
    echo "------------------------------"
}

#### Get info about Operating System ####

function  os_info(){
    local namevers=$(awk -F'[="]+' '/^(NAME|VERSION)=/{printf("%-17s: %s\n",$1,$2)}' /etc/os-release)
    # regexp on /etc/os-release to extract name and version of OS

    write_header "System Info"
    echo "OPERATING SYSTEM : $(uname --kernel-name)"                    # uname -s
    echo "KERNEL VERSION   : $(uname --kernel-release)"                 # uname -r
    printf '%s\n' "$namevers"

    pause
}

#### Get input via the keyboard and make a decision using case..esac ####

function read_input(){
    local c
    read -p "Enter your choice [ 1-2 ]:  " c
    case $c in
        1) os_info ;;
        2) echo "Ciao!"; exit 0 ;;
        *)
            echo "Select an Option (1 or 2):  "
            pause
    esac
}
#### Ignore CTRL+C, CTRL+Z and quit signals using the trap ####

trap '' SIGINT SIGQUIT SIGTSTP

#### Main logic ####
# Display menu; wait for user input
while true
do
    clear
    show_menu
    read_input
done

