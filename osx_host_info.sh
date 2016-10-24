#!/bin/bash

# Get info about Host (DNS, IP, Hostname)

function write_header(){
    local h="$@"
    echo "--------------------------"
    echo "  ${h}"
    echo "--------------------------"

function host_info(){
    local dnsips=$(sed -e '/^$/d' /etc/resolv.conf |awk '{if (tolower($1)=="nameserver") print $2}')
    write_header "  Hostname and DNS Info"
    
    echo "Hostname : $(hostname -s)"
    
    # echo "DNS Domain : $(hostname -d)" ## Will not work in OS X 
    # Try instead: 
    hostname -f | sed -e 's/^[^.]*\.//'

 
    echo "Fully-qualified Domain Name (FQDN) : $(hostname -f)"
    
    # echo "Network Address (IP) : $(hostname -i)" ## Will not work in OS X 
    # Try instead: 
    ifconfig en0 |awk '/inet / {print $2; }' # should add this higher up in the function 
					     # there should be a better way to get at this info

    
    echo "DNS name servers (DNS IP) : ${dnsips}"


host_info 
