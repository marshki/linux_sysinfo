#!/usr/bin/bash

write_info() { 
  # header 

  local name=$1; shift; 
  printf "%s" "$name%s" 
  printf "%s\\n" "$@"  
}

disk_hogs() {
  # Retrieve top 10 disk-eating files  

  printf "%s\\n" "Searching..."

  # scan file system from / for files; output background noise to: /dev/null; pv for progress 
  local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null |pv)
  
  printf "%s\\n" "${largestfiles}" |sort --reverse --human |head --lines=10 

} 

disk_hogs 
