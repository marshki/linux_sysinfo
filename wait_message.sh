#!/bin/bash

function wait_message() { 
    echo -n "Please wait..."
    while true
    do
        echo -n "."
        sleep .2
    done
} 

wait_message 
