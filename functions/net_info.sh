#!/bin/bash 

#### Display header message #### 
# $1 - message 

function write_header(){
    local h="$@"
    echo "------------------------------"
    echo "  ${h}"
    echo "------------------------------"
}

#### Get info about Network Interface and Routing ####

function net_info(){
    local devices=$(netstat --interfaces | cut --delimiter=" " --fields=1 | egrep --invert-match "Kernel|Iface|lo")   
    # regex netstat to list network interfaces 
    # devices=$(netstat -i | cut -d" " -f1 | egrep -v "Kernel|Iface|lo")
    
    write_header "Network Info"
    echo "Total Network Interfaces Found : 
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
    echo "  Interface Traffic Info      "
    echo "------------------------------"
    netstat --interfaces                                                # netstat -i  

    # pause 
}

net_info
