#!/bin/bash

# Get info about Host (DNS, IP, Hostname)

function write_header(){
    local h="$@"
    echo "--------------------------"
    echo "  ${h}"
    echo "--------------------------"
}

function host_info(){
    local dnsdomain=$(hostname -f | sed -e 's/^[^.]*\.//')
    local netaddr=$(ifconfig lo0 |awk '/inet / {print $2; }')
    local dnsips=$(sed -e '/^$/d' /etc/resolv.conf |awk '{if (tolower($1)=="nameserver") print $2}')

    write_header "  Hostname and DNS Info"
    echo "Hostname : $(hostname -s)"
    echo "DNS Domain : $(dnsdomain)"    
    echo "Fully-qualified Domain Name (FQDN) : $(hostname -f)"
    echo "Network Address (IP): ${netaddr}"     
    echo "DNS name servers (DNS IP) : ${dnsips}"
    pause 
}

host_info 
