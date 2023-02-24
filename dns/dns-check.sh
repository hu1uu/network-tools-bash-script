#!/bin/bash

# Purpose:
# Using dig to check a DNS server and Views if configured forward zone records from a list of dictionary file of your custom fqdn  

# Usage:
# check that you have 774 or chmod 
# ./dns-check <text file list of fqdn>
# Followed by prompt to enter the IP specific DNS instead of using your local resolver

# Check if files is supplied. Currently not checking for formatting 
# sufficient to have your fqdn name like this: example.com 
if [ ! -f "$1" ]; then
    echo "File of FQDN not supplied. Usage: dns-check <text file list of fqdn>"
    exit 1
fi



# Prompt for IP of nameserver to Use
read -p "Enter the IP of the Nameserver to query (or leave blank for default): " nameserver


# Loop through the line(s) of the text file containing the fqdn 
while read -r fqdn || [[ -n "$fqdn" ]]
do 
    # If $nameserver is provided then use the option @$nameserver
    if [ -n "$nameserver" ]; then
        dig "$fqdn" "@$nameserver"
    else
        dig "$fqdn"
    fi
done < "$1"