#!/bin/bash
# TODO: echo user input to reflect selection 


#### Display on-screen menu ####

function show_menu(){
    date
    echo "------------------------------"
    echo "  Bash System Info            " 
    echo "  Main Menu                   "
    echo "------------------------------"
        echo "  1. OS Info" 
        echo "  2. Hostname & DNS Info"
        echo "  3. Network Info"
        echo "  4. Who is Online"
        echo "  5. Last Logged in Users"
        echo "  6. CPU Info" 
        echo "  7. Free & Used Memory Info"
        echo "  8. Disk Usage" 
        echo "  9. Exit" 
}

function read_input(){
    local c
    read -p "Enter your choice [ 1-9 ]:  " c
    case $c in
        1) os_info ;;
        2) host_info ;;
        3) net_info ;;
        4) user_info "who" ;;
        5) user_info "last" ;;
        6) cpu_info ;;
        7) mem_info ;;
        8) disk_space;;
        9) echo "Ciao!"; exit 0 ;;
        *)
            echo "Select an Option (1 to 9):  "
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

