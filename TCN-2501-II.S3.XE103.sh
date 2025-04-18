#!/bin/bash

# function for network details
function net_det(){
	echo "private ip address : " 
	ifconfig | grep 'inet' | head -n 1 | awk '{print $2}' 
	echo "public ip address: "
	curl -s ifconfig.me 
	echo " "
	echo "default gateway: "
	netstat -ar | grep  UG | awk '{print $2}'
	echo " "
	echo "mac address(masked):"
	ifconfig | awk '/ether/ {gsub(/:.{2}/, ":**", $2); print $2}'
}

# functions for disk statistics
function memory(){
	echo "memory usage"
	free -h | grep -i mem | awk '{print "Total : "$2", Available :" $3}'
}

#function to find the 10 largest files in /home
function largest_files(){
		echo "the 10 largest files are :"
		find /home -type f -exec du -h {} + | sort -rh | head -n 10
}

#function for cpu usage
function cpu_usage(){
		echo "cpu usage:"
		ps aux --sort=-%cpu | head -n 6
}

function active_services(){
		echo "active services: "
		service --status-all | grep '+' 
		echo " "
}

while true; do
	clear
	echo "===INFO EXTRACTOR==="
	net_det
	memory
	largest_files
    	cpu_usage 
    	active_services
    	echo "Updating every 10 seconds"
    	sleep 10
done
