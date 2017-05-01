#!/bin/bash 
# Possible progress bar function 

function progress_bar(){
    
    BAR='####################'      # make it full, this is 20 chars

    for i in {1..20}; do
        echo -ne "\r${BAR:0:$i}"    # print $i chars of $BAR from 0 position
        sleep 0.5                   # sleep one second, por favor              
    done
} 

progress_bar   

                                # echo -n - print without new line at the end
                                # echo -e - interpret special characters while printing
                                # "\r" - special char to return to the beginning of the line
