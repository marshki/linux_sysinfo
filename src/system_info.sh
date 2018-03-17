#!/usr/bin/env bash 
# mjk 2016.10.07

############################################################
#   Bash shell script to extract useful information        #
#   from a Linux box using a text-based interface.         #
#                                                          #
#   Tested to run on the following distros:                #
#   CentOS 7                                               #
#   Debian 8 "Jessie"                                      #
#   Ubuntu 16.04 LTS "Xenial Xerus"                        # 
############################################################

############################################################
# This script builds on, and improves grabsysinfo.sh       #
# attributed to Vivek Gite circa 2007.09.12.               #
############################################################

############################################################
# A note on comments in this script:                       # 
#                                                          # 
# When you see a verbose command FOLLOWED BY #,            #
# the content TO THE RIGHT of the # is the abridged version# 
# of same command.                                         # 
#                                                          # 
# When you see a command with a # BELOW the command,       #
# the information TO THE RIGHT of the # usually            #
# describes  what the command above it does.               #
############################################################

#### Check if pv is installed; exit if not. ####

function pv_check(){
    if ! which pv &> /dev/null; then 
    printf "%s\n" "Please install pv or make sure it is in your path." 
    exit 1
    fi 
} 

#### Display pause prompt ####
# Suspend processing of script; display message prompting user to press [Enter] key to continue
# $1-> Message (optional)

function pause(){
    local message="$@"
    [ -z $message ] && message="Press [Enter] key to continue:  "
    read -p "$message" readEnterKey            
}

#### Display on-screen menu ####

function show_menu(){
    date
    printf "%s\n" "------------------------------"
    printf "%s\n" "  Bash System Info            " 
    printf "%s\n" "  Main Menu                   "
    printf "%s\n" "------------------------------"
        printf "%s\n" "  1. OS Info" 
        printf "%s\n" "  2. Hostname & DNS Info"
        printf "%s\n" "  3. Network Info"
        printf "%s\n" "  4. Who is Online"
        printf "%s\n" "  5. Last Logged in Users"
        printf "%s\n" "  6. CPU Info" 
        printf "%s\n" "  7. Free & Used Memory Info"
        printf "%s\n" "  8. Disk Usage" 
        printf "%s\n" "  9. Exit" 
}

#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    printf "%s\n" "------------------------------"
    printf "%s\n" "  ${h}"
    printf "%s\n" "------------------------------"
}

#### Get info about Operating System ####

function  os_info(){
    local name=$(cat /etc/*-release    |grep --word-regexp "NAME="   |sed 's/NAME=//g; s/"//g')        # grep -w     
    local version=$(cat /etc/*-release |grep --word-regexp "VERSION="|sed 's/VERSION=//g; s/"//g')     # ""  

    write_header "System Info"
    printf "%s\n" "OPERATING SYSTEM : $(uname --kernel-name)"                                          # uname -s
    printf "%s\n" "KERNEL VERSION   : $(uname --kernel-release)"                                       # uname -r
    printf "%s\n" "NAME             : ${name}" 
    printf "%s\n" "VERSION          : ${version}"
        
    pause                                                               
}

#### Get info about Host(DNS, IP, Hostname) ####

function host_info(){
    local dnsname=$(grep --word-regexp 'search' /etc/resolv.conf     |sed 's/search //g')       # grep -w
    local dnsips=$(grep --word-regexp 'nameserver' /etc/resolv.conf  |sed 's/nameserver //g')   # "
   
    write_header "Hostname and DNS Info"
    printf "%s\n" "Hostname                              : $(hostname --short)"                          # hostname -s 
    printf "%s\n" "DNS Domain                            : $(hostname --domain)"                         # hostname -d 
    printf "%s\n" "Fully-qualified Domain Name (FQDN)    : $(hostname --fqdn)"                           # hostname -f 
    printf "%s\n" "Network Address (IP)                  : $(hostname --ip-address)"                     # hostname -i 
    printf "%s\n" "Domain Name Servers (DNS name)        : ${dnsname}"    
    printf "%s\n" "Domain Name Servers (DNS IPs)         : ${dnsips}"
                           
    pause
}

#### Get info about Network Interface and Routing ####

function net_info(){
    local devices=$(netstat --interfaces | cut --delimiter=" " --fields=1 | egrep --invert-match "Kernel|Iface|lo")   
    # regex netstat to list network interfaces 
    # devices=$(netstat -i | cut -d" " -f1 | egrep -v "Kernel|Iface|lo")
    
    write_header "Network Info"
    printf "%s\n" "Total Network Interfaces Found : 
    $(wc --words <<<${devices})"                                        # $(wc --words <<<${devices})"
    
    printf "%s\n" "------------------------------"
    printf "%s\n" "  IP Addresses Info           "
    printf "%s\n" "------------------------------"
    ip -family inet address show                                        # ip -4 address show 

    printf "%s\n" "------------------------------"
    printf "%s\n" "  Network Routing             "
    printf "%s\n" "------------------------------"
    netstat --numeric --route                                           # netstat -nr 

    printf "%s\n" "------------------------------"
    printf "%s\n" "  Interface Traffic Info      "
    printf "%s\n" "------------------------------"
    netstat --interfaces                                                # netstat -i  

    pause 
}

#### Display list of users currently logged on & a list of recently logged in users ####

function user_info(){
    local cmd="$1"
    case "$cmd" in
        who) write_header "Who is Online? "; who --heading;;                # who -H 
        last) write_header "Last 10 Logged in Users "; last -n 10 -a -d;;   # last -num 10 -a -d   
    esac
    
    pause 
}

### Display CPU info ### 

function cpu_info(){

    write_header "CPU Info"

    lscpu |grep --word-regexp 'Model name:'                             # grep -w 
    lscpu |grep --word-regexp 'Socket(s)'                               # " 
    lscpu |grep --word-regexp 'Core(s) per socket'                      # " 
    # Query lscpu for: `Model name`, `Socket(s)`, and `Cores per socket`

    pause
    
}

#### Display used and free memory info ####

function mem_info(){
    local processes=$(ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu) 
    # regex ps to define, extract, and sort top memory (then cpu) consuming processes  
        
    write_header "Free & Used Memory "        
    free --giga --human                                                 # free -gh  
    
    printf "%s\n" "------------------------------"
    printf "%s\n" "  Virtual Memory Statistics   "
    printf "%s\n" "------------------------------"
    vmstat
    
    printf "%s\n" "------------------------------"
    printf "%s\n" " Top 10 Memory Eating Process "
    printf "%s\n" "------------------------------"
    printf "%s\n" "${processes}" | head -11 |awk '{print $1, $2, $3, $4, $5, $6, $7}'
    
    pause
}

#### Display information on disk space usage ####

############################################################
# A note about Top 10 Disk Eating Files:                   #
# This program is designed so that a non-root user can     #
# access all functions.If run as non-root,                 #
# you will be limited in what paths you will be able to    #
# to search, thereby impacting your results.               #
# If that's not acceptable, you can run this program with  #
# elevated privileges.                                     # 
############################################################

function disk_space(){

    printf "%s\n" "Processing ..."

    local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null |pv )
    # find largest files by disk space; pv to provide feedback 
    # find / -type f -exec du -Sh {} + 2>/dev/null

    write_header "Disk Usage"
    df --human-readable --total | awk 'NR==1; END{print}'                           # df -h --total   

    # printf "%s" "Retrieving largest files..."

    printf "%s\n" "------------------------------" 
    printf "%s\n" "   Top 10 Disk Eating Files   " 
    printf "%s\n" "------------------------------"     
    printf "%s\n" "${largestfiles}" |sort --reverse --human | head --lines=10       # sort -rh | head -n 10

    # find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | sort --reverse --human | head --lines=10 
    # find / -type f -exec du -Sh {} + 2>/dev/null | sort -rh | head -n 10

    pause 
}

#### Get input via the keyboard and make a decision using case...esac ####

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
        9) printf "%s\n" "Ciao!"; exit 0 ;;
        *)
           printf "%s\n" "Select an Option (1 to 9):  "

           pause
    esac 
}

#### Ignore CTRL+C, CTRL+Z and quit signals using the trap ####

trap '' SIGINT SIGQUIT SIGTSTP

#### Main logic ####
# Run pv check, then 
# display menu and wait for user input 

pv_check 
while true 
do 
    clear 
    show_menu   
    read_input  
done 
