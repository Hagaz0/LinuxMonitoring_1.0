#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3$4 $5}')
USER=$(whoami)
OS=$(head -1 /etc/issue | awk '{print $1" "$2" "$3}')
DATE=$(date | awk '{print $3" "$2" "$6" "$4}')
UPTIME=$(uptime -p)
UPTIME_SEC="$(cat /proc/uptime | awk '{print $1}') seconds"
IP=$(ifconfig | grep -m1 inet | awk '{print $2}')
MASK=$(ifconfig | grep -m1 inet | awk '{print $4}')
GATEWAY=$(ip r | grep default | awk '{print $3}')
RAM_TOTAL="$(free | grep Mem | awk '{print $2}'| awk '{printf("%.3f", $1/1024/1024)}') GB"
RAM_USED="$(free | grep Mem | awk '{print $3}'| awk '{printf("%.3f", $1/1024/1024)}') GB"
RAM_FREE="$(free | grep Mem | awk '{print $4}'| awk '{printf("%.3f", $1/1024/1024)}') GB"
SPACE_ROOT="$(df / | grep dev | awk '{printf("%.2f", $2/1024)}') MB"
SPACE_ROOT_USED="$(df / | grep dev | awk '{printf("%.2f", $3/1024)}') MB"
SPACE_ROOT_FREE="$(df / | grep dev | awk '{printf("%.2f", $4/1024)}') MB"
ALL="HOSTNAME = $HOSTNAME
TIMEZONE = $TIMEZONE
USER = $USER
OS = $OS
DATE = $DATE
UPTIME = $UPTIME
UPTIME_SEC = $UPTIME_SEC
IP = $IP
MASK = $MASK
GATEWAY = $GATEWAY
RAM_TOTAL = $RAM_TOTAL
RAM_USED = $RAM_USED
RAM_FREE = $RAM_FREE
SPACE_ROOT = $SPACE_ROOT
SPACE_ROOT_USED = $SPACE_ROOT_USED
SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
echo "$ALL"
read -r -p "Do you want to write the data to a file? (Y/N): " answer
yes='[yY]'
if [[ ($answer =~ $yes) ]]
then
	DATE=$(date | awk '{print $3"_"$2"_"$6"_"$4}')
	DATE=${DATE//:/_}
	file="$DATE.status.txt"
	touch $file
	echo "$ALL" >> $file
fi

