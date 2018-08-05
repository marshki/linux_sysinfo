#!/bin/bash 

# TODO: 
# --> FIX ME, PLEASE!!! <--

#### Print header ####

write_header() {
  local name=$1; shift;
  printf "%s""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s" "$@"
}

#### Print info ####

info() {
  local name=$1; shift;
  printf "%s""$name%s"
  printf "%s\\n" "$@"
}

#### Describe function ####

ram_stats() {
  # display free & used memory 

  local ram=$(free --giga --human) 
  write_info "Free & Used Memory: ${ram}"
}

vram_stats() {
  # display virtual memory 

  local vram=$(vmstat) 
  write_info "Virtual Memory Statistics: ${vram}"
}

# --> NEED TO FIX <--

top_ram_eaters() {
  # regex ps to define, extract, and sort top memory (then cpu) consuming processes  

  processes=$(ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu) 
  # |head -11 |awk '{print $1, $2, $3, $4, $5, $6, $7}') 
  
  write_info "Top 10 Memory Eating Process: ${top_ten}"
}

mem_info() { 
  # wrapper function 

  write_header "MEMORY INFO" "${mem_info}" 

  ram_stats
  vram_stats
  #top_ram_eaters
}

mem_info
