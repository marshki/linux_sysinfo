#!/usr/bin/bash

write_info() { 
  # header 

  local name=$1; shift; 
  printf "%s" "$name%s" 
  printf "%s\\n" "$@"  
}

disk_hogs() {
  # Retrieve top 10 disk-eating directories

  printf "%s\\n" "Searching..."

  # scan file system from / for directories; output background noise to: /dev/null; pv for progress 
  local largestdirs=$(find / -type d -exec du --max-depth=2 --human-readable {} + 2>/dev/null |pv)
  
  # local largestdirs=$(find / -type d -exec du --separate-dirs --human-readable {} + 2>/dev/null |pv)
  
  #local largestdirs=$(find /home -type d -exec du --separate-dirs --human-readable {} + 2>/dev/null |pv) 

  printf "%s\\n" "${largestdirs}" |sort --reverse --human |head --lines=10 

} 

disk_hogs 
