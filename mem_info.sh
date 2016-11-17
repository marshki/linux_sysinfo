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
        #ps -Ao user,pid,pcpu,pmem,stat,command --sort=-%mem,-%cpu | head -6 | awk '{print $1, $2, $3, $4, $5, $6, $6, $7}'

        #ps aux |awk 'NR==1{print $0}'                                   # get header row from ps
        #ps auxf |sort --numeric-sort --reverse --key=4 |head -5|awk '{ print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13}'
        # sort -nr -k 4 | head -5           
        #pause
}

mem_info 
