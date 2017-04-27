#!/bin/bash 
# Possible progress basr 

BAR='####################'      # make it full, this is 15 chars
                                # but maybe you want 100 for 100%
for i in {1..20}; do
    echo -ne "\r${BAR:0:$i}"    # print $i chars of $BAR from 0 position
    sleep 0.5                   # sleep one second, por favor              
done
