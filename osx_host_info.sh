#!/bin/bash

# Get info about Host (DNS, IP, Hostname)
# Working to get this going in the least obtrusive way possible. 
# Still not there yet 10.24.2016

function write_header(){
    local h="$@"
    echo "--------------------------"
    echo "  ${h}"
    echo "--------------------------"
}

function host_info(){
    local dnsips=$(sed -e '/^$/d' /etc/resolv.conf |awk '{if (tolower($1)=="nameserver") print $2}')
    local dnsdomain=$(hostname -f | sed -e 's/^[^.]*\.//')
    local netaddr=$(ifconfig lo0 |awk '/inet / {print $2; }')
    write_header "  Hostname and DNS Info"
    echo "Hostname : $(hostname -s)"
    echo "DNS Domain : $(dnsdomain)"    
    echo "Fully-qualified Domain Name (FQDN) : $(hostname -f)"
    echo "Network Address (IP): ${netaddr}"     
    echo "DNS name servers (DNS IP) : ${dnsips}"
    pause 
}

host_info 
