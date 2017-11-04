#!/bin/bash 

OPTION=$(whiptail --title "Bash System Info" --menu "Select an option" 15 60 4 \
"1." "OS Info" \
"2." "Hostname & DNS Info" \
"3." "Network Info" \
"4." "Who is Online" \
"5." "Last Logged in Users" \
"6." "CPU Info" \
"7." "Free & Used Memory Info" \
"8." "Disk Usage"  3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your chosen option:" $OPTION
else
    echo "You chose Cancel."
fi




#whiptail --title "Test Message Box" --msgbox "Create a message box with whiptail. Choose OK to continue." 10 60
#whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
#"<-- Back" "Return to the main menu." \
#"Add User" "Add a user to the system." \
#"Modify User" "Modify an existing user." \
#"List Users" "List all users on the system." \
#"Add Group" "Add a user group to the system." \
#"Modify Group" "Modify a group and its list of members." \
#"List Groups" "List all groups on the system."


#whiptail --title "Example Dialog" --msgbox "This is an example of a message box. You must hit OK to continue." 8 78

#whiptail --title "Example Dialog" --infobox "This is an example of an info box." 8 78
