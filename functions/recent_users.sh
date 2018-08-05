#!/bin/bash


 
#### Print header ####

write_header() {
  local name=$1; shift;
  printf "%s""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s" "$@"
}

#### Display a list of recently logged in users ####

ten_last() { 
  # `last` built-in; last 10 incl. host & dns 

  local lasty=$(last --limit 10 --hostlast --dns)  
  printf "%s\\n" "${lasty}"   
} 

recent_users() { 
  # wrapper function 

  write_header "LAST 10 LOGGED-IN USERS" "$user_info" 

  ten_last 
} 

recent_users
