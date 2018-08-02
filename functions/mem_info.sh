#!/bin/bash 

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

#### Describe function ####

ram_stats() {
  # free & used memory 

  local freey=$(free --giga --human) 
  write_info "Free & Used Memory: ${freey}"
}

#### Display used and free memory info ####
function mem_info(){
    local processes=$(ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu) 
    # regex ps to define, extract, and sort top memory (then cpu) consuming processes  
        
    write_header "Free & Used Memory "        
    free --giga --human                                                 # free -gh  
    
    printf "%s\n" "------------------------------"
    printf "%s\n" "  Virtual Memory Statistics   "
    printf "%s\n" "------------------------------"
    vmstat
    
    printf "%s\n" "------------------------------"
    printf "%s\n" " Top 10 Memory Eating Process "
    printf "%s\n" "------------------------------"
    printf "%s\n" "${processes}" | head -11 |awk '{print $1, $2, $3, $4, $5, $6, $7}'
    
    # pause
}

mem_info 


mem_info() { 
  # wrapper function 

  write_header "MEMORY INFO" "${mem_info}" 


}

mem_info
