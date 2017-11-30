#!/bin/bash 

#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    printf "%s\n" "------------------------------"
    printf "%s\n" "  ${h}"
    printf "%s\n" "------------------------------"
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

    # pause 
}

net_info
