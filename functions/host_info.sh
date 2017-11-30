#!/bin/bash 

#### Display header message ####                                                                                                      
# $1 - message                                                                                                                        
                                                                                                                                      
function write_header(){                                                                                                              
    local h="$@"                                                                                                                      
    printf "%s\n" "------------------------------"                                                                                             
    printf "%s\n" "  ${h}"                                                                                                                     
    printf "%s\n" "------------------------------"                                                                                             
}

# Get information about hostname 

function host_info(){

    write_header "Hostname and DNS Info"
    printf "%s\n" "Hostname                              : $(hostname --short)"          # hostname -s
    printf "%s\n" "DNS Domain                            : $(hostname --domain)"         # hostname -d
    printf "%s\n" "Fully-qualified Domain Name (FQDN)    : $(hostname --fqdn)"           # hostname -f
    printf "%s\n" "Network Address (IP)                  : $(hostname --ip-address)"     # hostname -i
    printf "%s\n" "Domain Name Servers (DNS name)        : $(grep --word-regexp 'search' /etc/resolv.conf |sed 's/search //g')"  # grep -w 
    printf "%s\n" "Domain Name Servers (DNS IPs)         : $(grep --word-regexp 'nameserver' /etc/resolv.conf |sed 's/nameserver //g')"  

    # pause
}

host_info
