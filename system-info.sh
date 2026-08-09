#!/bin/bash

set -o pipefail

VERSION=1.0.0

##validating input

if [ $# -eq 0 ]; then
	:
elif [ $# -eq 1 ]; then
	case $1 in
		-h|--help)
			echo -e "System Information Utility \n"
			echo -e "Description \n  A Bash utility that displays various system parameters such as hostname, operating system, kernel, CPU, memory, uptime, and disk usage.\n"
			echo -e "Usage:"
			echo -e "     ./system-info.sh \n         Executes the system information utility.\n"
			echo -e "     ./system-info.sh --help"
			echo -e "     ./system-info.sh -h \n        Displays this help message."
			exit 0
			;;
		-v|--version)
			echo "system-info $VERSION"
			exit 0
			;;
		*)
		echo "Invalid argument"
		exit 1
		;;
	esac
else
	echo "Too many arguments. Invalid usage"
	exit 1
fi

##Creating header

echo "=============================="
echo "      SYSTEM INFORMATION      "
echo "=============================="

get_hostname(){
	hostname
}

get_os(){
	grep "PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"'
}

get_kernel(){
	uname -r
}

get_uptime(){
	awk '{
	days=int($1/86400)
	hours=int(($1%86400)/3600)
	minutes=int((($1%86400)%3600)/60)
	printf "%d days, %d hours, %d minutes\n", days, hours, minutes
	}' /proc/uptime
}

get_cpu(){
	grep "model name" /proc/cpuinfo | sort | uniq | cut -d':' -f2 | sed 's/^ //'
}

get_memory(){
	awk '/MemTotal:/ {printf "%.2f\n", $2/1024/1024}' /proc/meminfo
}

get_disk_usage(){
	df -h / | awk 'NR==2 {print $5}'
}

##Calling the functions
HOSTNAME=$(get_hostname)
printf "%-10s : %s\n" "Hostname" "$HOSTNAME"

OS=$(get_os)
printf "%-10s : %s\n" "OS" "$OS"

KERNEL=$(get_kernel)
printf "%-10s : %s\n" "Kernel" "$KERNEL"

UPTIME=$(get_uptime)
printf "%-10s : %s\n" "Uptime" "$UPTIME"

CPU=$(get_cpu)
printf "%-10s : %s\n" "CPU" "$CPU"

MEM_GB=$(get_memory)
printf "%-10s : %s\n" "Memory" "${MEM_GB} GB"

if DISK=$(get_disk_usage); then
	printf "%-10s : %s\n" "Disk Usage" "$DISK"
else
	echo "Disk Usage : Unable to determine disk usage"
fi

echo "=============================="
