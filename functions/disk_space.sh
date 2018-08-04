#!/bin/bash 
# Need to run as root!!! 

#### Get information about free and used disk space ####

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

#### meat & potatoes ####

disk_usage() {
  # Retrieve file system info re: disk space

  local disk=$(df --human-readable --total |awk 'NR==1; END{print}')
  write_info "Disk Usage: ${disk}"
}

#disk_hogs() {
  # Retrieve top 10 disk-eating files   

  # scan file system from / for files ; output background noise to /dev/null; pv for progress 
  #local sort_files=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | pv)  
  
  # take output from sort_files; show progress; sort files; show top 10 
  #local top_files$("${sort_files}" | pv | sort --reverse --human | head --lines=10 ) 
  
  #write_info "Top 10 Disk Eating Files: ${disk_hogs}"
#}

disk_space() { 
  # wrapper function 

  write_header "DISK INFO" "${disk_space}" 
  
  disk_usage
  # disk_hogs  
}

disk_space

#    printf "%s\n" "Searching..." 

#    local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | pv)
    
    # find largest files by disk space; output background noise to /dev/null 
    # find / -type f -exec du -Sh {} + 2>/dev/null
             
#    write_header "Disk Usage" 
#    df --human-readable --total | awk 'NR==1; END{print}'                                          # df -h --total   
        
#    printf "%s\n" "------------------------------" 
#    printf "%s\n" "   Top 10 Disk Eating Files   " 
#    printf "%s\n" "------------------------------"     
#    printf "%s\n" "${largestfiles}" | pv | sort --reverse --human | head --lines=10                # sort -rh | head -n 10
 
    # find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | sort --reverse --human | head --lines=10 
    # find / -type f -exec du -Sh {} + 2>/dev/null | sort -rh | head -n 10
#}
