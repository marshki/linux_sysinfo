#!/bin/bash 
# Need to run as root!!! 
# Retrieve disk space/usage info 

#### Print header ####

write_header() {
  local name=$1; shift;
  printf "%s""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s" "$@"
}

#### Get information about free and used disk space ####

disk_usage() {
  # Retrieve file system info re: disk space

  local disk=$(df --human-readable --total |awk 'NR==1; END{print}')
  printf "%s\\n" "${disk}"
}
# Top 10 disk-eating files 

  # Retrieve top 10 disk-eating files 

disk_hogs() { 
 
  printf "%s\\n" "Searching..." 
  
  # scan file system from / for files; output background noise to /dev/null; pv for progress 
  local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null |pv)

  printf "%s\n" "${largestfiles}" |sort --reverse --human | head --lines=10
} 

disk_space() { 
  # wrapper function 

  write_header "DISK INFO" 

  write_header "DISK USAGE" 
  disk_usage

  write_header "TOP 10 DISK-EATING FILES" 
  disk_hogs  
}

disk_space
