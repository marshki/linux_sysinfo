#### Define Variables ####
# Linux Standard Base Module (LSB) provides distro-specific info

LSB=/usr/bin/lsb_release

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
    write_header "System Info"
    echo "Operating System : $(uname --kernel-name)"                # uname -s 
    echo "Kernel Version   : $(uname --kernel-release)"             # uname -r 
    awk '/^NAME=/||/^VERSION=/' /etc/os-release                     # Not perfect, but OK. Let's print output so that we 
                                                                    # match formatting for the earlier echo statements, e.g.
                                                                    # Name   :"Debian GNU/Linux"
                                                                    # Version:"8 (jessie)" 
    # [ -x $LSB ] && $LSB -a || echo "$LSB command is not installed (set \$LSB variable)"
    # cat /etc/os-release 
}

os_info 
