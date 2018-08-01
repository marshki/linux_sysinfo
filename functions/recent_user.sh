#!/bin/bash

#### Display a list of recently logged in users ####

# TODO: fix --> layout (aesthetic and functionality) <--

 
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

ten_last() { 
  # Display 10 last logged in users

  local lasty=$(last --limit 10 --hostlast --dns)  
  write_info "Last 10 logged in Users: ${lasty}"
} 

recent_user() { 
  # wrapper function 
  write_header "USER INFO" "$user_info" 

  ten_last 
} 

recent_user 
