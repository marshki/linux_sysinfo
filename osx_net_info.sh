#!/bin/bash 

#Info about Network Interface and Routing 

function net_info(){
    devices=$(netstat -i | cut -d" " -f1 | egrep -v "Kernel|Iface|lo")
    write_header "  Network Info"
    echo "Total network interfaces found : $(wc -w <<<${devices})"
    
    echo "*** IP Addresses Info ***"
    ip -4 address show      # os x doesn't like this command  

    echo "**************************"
    echo "**** Network Routing  ****"
    echo "**************************"
    netstat -nr 

    echo "**************************"
    echo "* Interface traffic Info *"
    echo "**************************"
    netstat -i 

    pause 
}


net_info
