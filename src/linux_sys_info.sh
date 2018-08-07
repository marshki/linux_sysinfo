#!/usr/bin/env bash 
# v.2.0 
# mjk 2018.08.07

######################################################
# Bash shell script to extract useful information    #
# from a Linux box using a text-based interface.     #
#                                                    #
# Tested to run on the following distros:            #
# Ubuntu 16.04 LTS "Xenial Xerus"                    # 
######################################################

######################################################
# This script builds on, and improves grabsysinfo.sh #
# attributed to Vivek Gite circa 2007.09.12.         #
######################################################

#################
#### PRELIMS ####
#################

function pv_check(){
  # (`pv` is used in `disk_hogs` for progress bar) 
  # `which` to check for `pv` --> output to /dev/null
  # exit program if not installed 

  if ! which pv &> /dev/null; then 
  printf "%s\n" "ERROR: Please install pv or add it to your path." 
  exit 1
fi 
} 

#################
#### HEADERS #### 
#################

write_header() {
  # print header 

  local name=$1; shift;
  printf "%s""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s" "$@"
}

write_info() {
  # print info 

  local name=$1; shift;
  printf "%s""$name%s"
  printf "%s\\n" "$@"
}

##############
#### MENU ####
##############

show_menu() { 
  # display on screen menu 

  date
  printf "%s\n" "------------------------------"
  printf "%s\n" "  LINUX SYSTEM INFO           " 
  printf "%s\n" "  MAIN MENU                   "
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

read_input(){
  # get user input via keyboard and make a decision using case...esac 
  ##-->UPDATE TO REFLECT NEW FUNCTION NAMES<--##

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

pause() {
  # pause prompt 
  # suspend processing of script; display message prompting user to press [Enter] key to continue
  # $1-> Message (optional)
  
  local message="$@"
  [ -z $message ] && message="Press [Enter] key to continue:  "
  read -p "$message" readEnterKey            
}

trap '' SIGINT SIGQUIT SIGTSTP
  # ignore CTRL+C, CTRL+Z and quit signals using the trap 

##################
#### SYS INFO ####
##################

#### OS INFO  ####
# kernel and operating system info

kernel_name() {
  # kernel name 

  local kern=$(uname --kernel-name)
  write_info "Kernel Name: ${kern}" 
} 

kernel_release	() { 
  # kernel release
 
  local kernr=$(uname --kernel-release)
  write_info "Kernel Release: ${kernr}" 
} 

os_name() {
  # relase name  

  local name=$(awk '/^NAME=/' /etc/*-release |cut --delimiter=\" --field=2)
  write_info "OS Name: ${name}" 
}  

os_version() {
  # release version

  local version=$(awk '/^VERSION=/' /etc/*-release |cut --delimiter=\" --field=2)
  write_info "OS Version: ${version}" 
} 

os_info() { 
  # wrapper function

  write_header "SYSTEM INFO"   
  kernel_name
  kernel_release 
  os_name
  os_version

  pause
} 

#### HOST INFO ####
# host & DNS info 

host_name() { 
  local host=$(hostname --short) 
  write_info "Hostname: ${host}" 
}

dns_domain() { 
  local dns=$(hostname --domain)
  write_info "DNS Domain: ${dns}" 
} 

fully_qualified() {
  local fqdn=$(hostname --fqdn) 
  write_info "Fully-qualified Domain Name: ${fqdn}"
} 

ip_address() { 
  local ip=$(hostname --ip-address) 
  write_info "Network Address (IP): ${ip}"
} 

dns_name() { 
  local search=$(awk '/^search/ {print $2}' /etc/resolv.conf)
  write_info "Domain Name Servers (DNS name): ${search}"
} 

dns_ips() { 
  local name_serv=$(awk '/^nameserver/ {print $2}' /etc/resolv.conf)
  write_info "Domain Name Servers (DNS IPs): ${name_serv}"
} 

host_info() { 
  # wrapper function 

  write_header "HOSTNAME & DNS INFO" 
  host_name
  dns_domain
  fully_qualified
  ip_address
  dns_name
  dns_ips
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



#### Main logic ####

# Run pv check;  
# clear screen; 
# display menu and process user input 

pv_check 
while true 
do 
    clear 
    show_menu   
    read_input  
done 
