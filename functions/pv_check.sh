#!/bin/bash 
# Check if pv is installed 

if ! which pv &> /dev/null; then
printf "%s\n" “Please install pv or make sure it is in your path”
exit
fi
