#!/bin/bash

#### Display list of users currently logged on ####

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

who_is_on() { 
  # Display logged in users

  local whoo=$(who --heading) 
  write_info "Who is online?: ${whoo}"
} 

current_user() { 
  # wrapper function 
  write_header "USER INFO" "$current_user" 

  who_is_on 
} 

current_user
