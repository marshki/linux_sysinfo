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
# A note on comments in this script:                       # 
# When you see a verbose command FOLLOWED BY #,            #
# the content to the right of the # is the abridged version# 
# of same command.                                         # 
# When you see a command with a # BELOW the command,       #
# the information to the right of the # usually            #
# describes  what the command above it does.               #
############################################################

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
    echo "------------------------------"
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

#### Get info about Host(DNS, IP, Hostname) ####

function host_info(){
    local dnsips=$(sed --expression='/^$/d' /etc/resolv.conf |awk '{if (tolower($1)=="nameserver") print $2}') # sed -e 
    # regex /etc/resolv.conf to retrieve DNS resolver info  
    
    write_header "Hostname and DNS Info"
    echo "Hostname : $(hostname --short)"                               # hostname -s 
    echo "DNS Domain : $(hostname --domain)"                            # hostname -d 
    echo "Fully-qualified Domain Name (FQDN) : $(hostname --fqdn)"      # hostname -f 
    echo "Network Address (IP) : $(hostname --ip-address)"              # hostname -i 
    echo "DNS name servers (DNS IP) : ${dnsips}"                            
    
    pause
}

#### Get info about Network Interface and Routing ####

function net_info(){
    local devices=$(netstat --interfaces | cut --delimiter=" " --fields=1 | egrep --invert-match "Kernel|Iface|lo")   
    # regex netstat to list network interfaces 
    # devices=$(netstat -i | cut -d" " -f1 | egrep -v "Kernel|Iface|lo")
    
    write_header "Network Info"
    echo "Total network interfaces found : 
    $(wc --words <<<${devices})"                                        # $(wc --words <<<${devices})"
    
    echo "------------------------------"
    echo "  IP Addresses Info           "
    echo "------------------------------"
    ip -family inet address show                                        # ip -4 address show 

    echo "------------------------------"
    echo "  Network Routing             "
    echo "------------------------------"
    netstat --numeric --route                                           # netstat -nr 

    echo "------------------------------"
    echo "  Interface traffic info      "
    echo "------------------------------"
    netstat --interfaces                                                # netstat -i  

    pause 
}

#### Display list of users currently logged on & a list of recently logged in users ####

function user_info(){
    local cmd="$1"
    case "$cmd" in
        who) write_header "Who is online? "; who --heading;;                # who -H 
        last) write_header "Last 10 logged in users "; last -n 10 -a -d;;   # last -num 10 -a -d   
    esac
    
    pause 
}

### Display CPU info ### 

function cpu_info(){

    write_header "CPU Info"

    lscpu |grep --ignore-case 'model name'
    lscpu |grep --ignore-case 'socket(s)'
    lscpu |grep --ignore-case 'core(s) per socket'
    # Query lscpu for: `model name`, `sockets`, and `numb

    pause
    
}

#### Display used and free memory info ####

function mem_info(){
    local processes=$(ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu) 
    # regex ps to define, extract, and sort top memory (then cpu) consuming processes  
        
    write_header "Free & Used Memory "        
    free --giga --human                                                 # free -gh  
    
    echo "------------------------------"
    echo "  Virtual Memory Statistics   "
    echo "------------------------------"
    vmstat
    
    echo "------------------------------"
    echo " Top 10 Memory Eating Process "
    echo "------------------------------"
    echo "${processes}" | head -11 |awk '{print $1, $2, $3, $4, $5, $6, $6, $7}'
    
    pause
}

#### Display information on disk space usage ####

function disk_space(){
    local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null)
    # find largest files by disk space; output background noise to /dev/null 
    # find / -type f -exec du -Sh {} + 2>/dev/null

    write_header "Disk Usage"
    df --human-readable --total | awk 'NR==1; END{print}'                           # df -h --total   

    # echo "Retrieving largest files..."

    echo "------------------------------" 
    echo "   Top 10 Disk Eating Files   " 
    echo "------------------------------"     
    echo "${largestfiles}" |sort --reverse --human | head --lines=10                # sort -rh | head -n 10

    # find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | sort --reverse --human | head --lines=10 
    # find / -type f -exec du -Sh {} + 2>/dev/null | sort -rh | head -n 10

    pause 
}

#### Get input via the keyboard and make a decision using case..esac ####

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
