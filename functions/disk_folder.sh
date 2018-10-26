#!/usr/bin/bash

write_info() { 
  # header 

  local name=$1; shift; 
  printf "%s" "$name%s" 
  printf "%s\\n" "$@"  
} 
