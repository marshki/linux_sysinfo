#!/bin/bash 

#### Display header message ####                                                                                                      
# $1 - message                                                                                                                        
                                                                                                                                      
function write_header(){                                                                                                              
    local h="$@"                                                                                                                      
    echo "------------------------------"                                                                                             
    echo "  ${h}"                                                                                                                     
    echo "------------------------------"                                                                                             
}

# Get information about hostname 

function host_info(){

    write_header "Hostname and DNS Info"
    echo "Hostname                              : $(hostname --short)"          # hostname -s
    echo "DNS Domain                            : $(hostname --domain)"         # hostname -d
    echo "Fully-qualified Domain Name (FQDN)    : $(hostname --fqdn)"           # hostname -f
    echo "Network Address (IP)                  : $(hostname --ip-address)"     # hostname -i
    echo "Domain Name Servers (DNS name)        : $(grep --word-regexp 'search' /etc/resolv.conf |sed 's/search //g')"  # grep -w 
    echo "Domain Name Servers (DNS IPs)         : $(grep --word-regexp 'nameserver' /etc/resolv.conf |sed 's/nameserver //g')"  

    # pause
}

host_info
