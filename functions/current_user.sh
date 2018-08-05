#!/bin/bash
 
#### Print header ####

write_header() {
  local name=$1; shift;
  printf "%s""--------------------\\n$name%s\\n--------------------\\n"
  printf "%s" "$@"
}

who_is_on() { 
  # Display logged in users

  local whoo=$(who --heading) 
  printf "%s\\n" "${whoo}"
 
} 

current_user() { 
  # wrapper function 
  write_header "WHO IS ONLINE?"  

  who_is_on 
} 

current_user
