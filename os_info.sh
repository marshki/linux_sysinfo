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
    echo "Operating System : $(uname)"
    [ -x $LSB ] && $LSB -a || echo "$LSB command is not installed (set \$LSB variable)"

    pause
}
