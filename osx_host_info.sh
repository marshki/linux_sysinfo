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
    echo "DNS Domain : $(hostname -d)"
    echo "Fully-qualified Domain Name (FQDN) : $(hostname -f)"
    echo "Network Address (IP) : $(hostname -i)"
    echo "DNS name servers (DNS IP) : ${dnsips}"


host_info 
