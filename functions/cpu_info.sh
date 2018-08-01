#!/bin/bash 

#### Print header ####

write_header() {
  local name=$1; shift;
  printf "%s""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s" "$@"
}

#### Print info ####

write_info() {
  local name=$1; shift;
  printf "%s""$name%s"
  printf "%s\\n" "$@"
}

#### Get info about CPU ####

cpu_model() {
  # Query lscpu for: `Model name`
 
  local model=$() 
  write_info "Model name: ${model}"
}

cpu_socket() { 
  # query lscpu for: `Sockets`

  local socket=$()
  write_info "Socket(s): ${socket}" 
}

cpu_cores() { 
  # query lscpu for: `Cores`
  
  local cores=$()
  write_info "Core(s) per socket: ${cores}" 
} 

cpu_info() { 
  # wrapper function 

  write_header "CPU INFO" "${cpu_info}"
  
  cpu_socket
  cpu_cores
  cpu_info
} 

cpu_info 


# grep may be the best bet here
#function  cpu_info(){
    
#    write_header "CPU Info"
#    lscpu |grep --word-regexp 'Model name:'                 # grep -w 
#    lscpu |grep --word-regexp 'Socket(s):'                  # ""
#    lscpu |grep --word-regexp 'Core(s) per socket:'         # ""
    # Query lscpu for: `Model name`, `Sockets`, and `Core(s) per socket` 

    # pause 

#}                                                                      
    

