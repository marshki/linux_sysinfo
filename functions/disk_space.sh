#!/bin/bash 
#Need to run as root 

#### Display header message ####                                                                                                      
# $1 - message                                                                                                                        
function write_header(){                                                                                                              
    local h="$@"                                                                                                                      
    printf "%s\n" "------------------------------"                                                                                             
    printf "%s\n" "  ${h}"                                                                                                                     
    printf "%s\n" "------------------------------"                                                                                             
} 

# Get information about free and used disk space 

function disk_space(){

    printf "%s\n" "Searching..." 

    local largestfiles=$(find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | pv)
    
    # find largest files by disk space; output background noise to /dev/null 
    # find / -type f -exec du -Sh {} + 2>/dev/null
             
    write_header "Disk Usage" 
    df --human-readable --total | awk 'NR==1; END{print}'                                          # df -h --total   
        
    printf "%s\n" "------------------------------" 
    printf "%s\n" "   Top 10 Disk Eating Files   " 
    printf "%s\n" "------------------------------"     
    printf "%s\n" "${largestfiles}" | pv | sort --reverse --human | head --lines=10                # sort -rh | head -n 10
 
    # find / -type f -exec du --separate-dirs --human-readable {} + 2>/dev/null | sort --reverse --human | head --lines=10 
    # find / -type f -exec du -Sh {} + 2>/dev/null | sort -rh | head -n 10
}

disk_space
