#### Define Variables ####

#### Display header message ####
# $1 - message

function write_header(){
    local h="$@"
    echo "------------------------------"
    echo "  ${h}"
    echo "------------------------------"
}

#### Get info about Operating System ####

function  os_info(){
    #local namevers=$(awk -F'[="]+' '/^(NAME|VERSION)=/{printf("%-17s: %s\n",$1,$2)}' /etc/os-release)  
    local name=$(awk -F'[="]+' '/^(NAME)=/{printf("%-17s: %s\n",$1,$2)}' /etc/os-release)
    local vers=$(awk -F'[="]+' '/^(VERSION)=/{printf("%-17s: %s\n",$1,$2)}' /etc/os-release) # close, but can we clean this up?
    
    write_header "System Info"
    echo "Operating System : $(uname --kernel-name)"                # uname -s 
    echo "Kernel Version   : $(uname --kernel-release)"             # uname -r 
    #awk -F'[="]+' '/^(NAME|VERSION)=/{printf("%-17s: %s\n",$1,$2)}' /etc/os-release
    echo ${name}
    echo ${vers}
    #echo ${namevers}
}                                                                      
    
os_info 
