#!/bin/bash 

function host_info(){
    # local dnsips=$(sed --expression='/^$/d' /etc/resolv.conf |awk '{if (tolower($1)=="nameserver") print $2}') # sed -e
    # regex /etc/resolv.conf to retrieve DNS resolver info

    write_header "Hostname and DNS Info"
    echo "Hostname                              : $(hostname --short)"          # hostname -s
    echo "DNS Domain                            : $(hostname --domain)"         # hostname -d
    echo "Fully-qualified Domain Name (FQDN)    : $(hostname --fqdn)"           # hostname -f
    echo "Network Address (IP)                  : $(hostname --ip-address)"     # hostname -i
    echo "$(grep --extended-regexp --word-regexp 'search|nameserver' /etc/resolv.conf)"

    # pause
}

host_info
