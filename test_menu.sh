#!/bin/bash 

OPTION=$(whiptail --title "Bash System Info" --menu "Select an option" 15 60 4 \ 
"1." "OS Info" \                                                                                                                      
"2." "Some Other Function" \ 

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $OPTION
else
    echo "You chose Cancel."
fi
