#!/bin/bash
# Retrieve info about network interfaces & routing 

# TODO 
# Fix output for readability 


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

network_interfaces() { 
  # Display number of network interfaces 

  local devices=$(ip -oneline link show |wc --lines) 
  write_info "Total Network Interfaces Found: ${devices}"  	
}

ip_add_info() {
  # Display the IP protocol addresses

  local ip_add=$(ip --family inet address show)
  write_info "IP Address Info: ${ip_add}"  
} 

network_routing() {
  # Display the IP routing table  

  local route=$(netstat --route --numeric)
  write_info "Network Routing: ${traffic}" 
} 

interface_traffic() {
  # Display status of interfaces on the network 

  local traffic=$(netstat --interfaces)
  write_info "Interface Traffic Info: ${traffic}" 
} 

net_info() {
  # wrapper function 
  write_header "NETWORK INFO" "$net_info" 

  network_interfaces
  ip_add_info
  network_routing
  interface_traffic
} 
 
net_info
