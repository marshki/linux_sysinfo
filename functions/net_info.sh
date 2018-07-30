#!/bin/bash
# Retrieve info about network interfaces & routing 

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

#### Net Info ####

ip_add_info() {
  local ip_add=$(ip --family inet address show)
  write_info "IP Address Info: ${ip_add}"  
} 

network_routing() {
  local route=$(netstat --numeric --route)
  write_info "Network Routing: ${traffic}" 
} 

interface_traffic() {
  local traffic=$(netstat --interfaces)
  write_info "Interface Traffic Info: ${traffic}" 
} 

net_info() {
} 



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

    # pause 
}

net_info
