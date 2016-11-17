function mem_info(){
        local processes=$(ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu) 
        write_header "Free & Used Memory "
        free --giga --human                                         # free -gh  

    echo "******************************"
    echo "* Virtual Memory Statistics  *"
    echo "******************************"
        vmstat

echo "***********************************"
echo "*** Top 5 Memory Eating Process ***"
echo "***********************************"
        echo "${processes}" | head -6 |awk '{print $1, $2, $3, $4, $5, $6, $6, $7}'
        #pause
}
mem_info 
