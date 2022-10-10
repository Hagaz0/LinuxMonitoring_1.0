#!/bin/bash

if [[ $# != 4 ]]
then
	echo "Invalid number of arguments (expected 4, input $#)"
	exit 1
fi

re='^[1-6]$'

if [[ !($1 =~ $re) || !($2 =~ $re ) || !($3 =~ $re) || !($4 =~ $re) ]]
then
	echo "Incorrect input"
	exit 1
fi

if [[ ($1 == $2) || ($3 == $4) ]]
then
	echo "The font and background colors match. Call the script again"
	exit 1
fi

WHITE='\033[37'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m' 
PURPLE='\033[0;35m'
BLACK='\033[0;30m'

NC='\033[0m'

ON_WHITE='\033[47m'
ON_RED='\033[41m'
ON_GREEN='\033[42m'
ON_BLUE='\033[44m'
ON_PURPLE='\033[45m'
ON_BLACK='\033[40m'

case $1 in
	1)
		FIRST_FON=$ON_WHITE
		;;
	2)
		FIRST_FON=$ON_RED
		;;
	3)
		FIRST_FON=$ON_GREEN
		;;
	4)
		FIRST_FON=$ON_BLUE
		;;
	5)
		FIRS_FON=$ON_PURPLE
		;;
	6)
		FIRST_FON=$ON_BLACK
		;;
esac

case $2 in
	1)
		FIRST_FRONT=$WHITE
		;;
	2)
		FIRST_FRONT=$RED
		;;
	3)
		FIRST_FRONT=$GREEN
		;;
	4)
		FIRST_FRONT=$BLUE
		;;
	5)
		FIRST_FRONT=$PURPLE
		;;
	6)
		FIRST_FRONT=$BLACK
		;;
esac

case $3 in
	1)
		SECOND_FON=$ON_WHITE
		;;
	2)
		SECOND_FON=$ON_RED
		;;
	3)
		SECOND_FON=$ON_GREEN
		;;
	4)
		SECOND_FON=$ON_BLUE
		;;
	5)
		SECOND_FON=$ON_PURPLE
		;;
	6)
		SECOND_FON=$ON_BLACK
		;;
esac

case $4 in
	1)
		SECOND_FRONT=$WHITE
		;;
	2)
		SECOND_FRONT=$RED
		;;
	3)
		SECOND_FRONT=$GREEN
		;;
	4)
		SECOND_FRONT=$BLUE
		;;
	5)
		SECOND_FRONT=$PURPLE
		;;
	6)
		SECOND_FRONT=$BLACK
		;;
esac

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
ALL="${FIRST_FRONT}${FIRST_FON}HOSTNAME${NC} = ${SECOND_FRONT}${SECOND_FON}$HOSTNAME${NC}
${FIRST_FRONT}${FIRST_FON}TIMEZONE${NC} = ${SECOND_FRONT}${SECOND_FON}$TIMEZONE${NC}
${FIRST_FRONT}${FIRST_FON}USER${NC} = ${SECOND_FRONT}${SECOND_FON}$USER${NC}
${FIRST_FRONT}${FIRST_FON}OS${NC} = ${SECOND_FRONT}${SECOND_FON}$OS${NC}
${FIRST_FRONT}${FIRST_FON}DATE${NC} = ${SECOND_FRONT}${SECOND_FON}$DATE${NC}
${FIRST_FRONT}${FIRST_FON}UPTIME${NC} = ${SECOND_FRONT}${SECOND_FON}$UPTIME${NC}
${FIRST_FRONT}${FIRST_FON}UPTIME_SEC${NC} = ${SECOND_FRONT}${SECOND_FON}$UPTIME_SEC${NC}
${FIRST_FRONT}${FIRST_FON}IP${NC} = ${SECOND_FRONT}${SECOND_FON}$IP${NC}
${FIRST_FRONT}${FIRST_FON}MASK${NC} = ${SECOND_FRONT}${SECOND_FON}$MASK${NC}
${FIRST_FRONT}${FIRST_FON}GATEWAY${NC} = ${SECOND_FRONT}${SECOND_FON}$GATEWAY${NC}
${FIRST_FRONT}${FIRST_FON}RAM_TOTAL${NC} = ${SECOND_FRONT}${SECOND_FON}$RAM_TOTAL${NC}
${FIRST_FRONT}${FIRST_FON}RAM_USED${NC} = ${SECOND_FRONT}${SECOND_FON}$RAM_USED${NC}
${FIRST_FRONT}${FIRST_FON}RAM_FREE${NC} = ${SECOND_FRONT}${SECOND_FON}$RAM_FREE${NC}
${FIRST_FRONT}${FIRST_FON}SPACE_ROOT${NC} = ${SECOND_FRONT}${SECOND_FON}$SPACE_ROOT${NC}
${FIRST_FRONT}${FIRST_FON}SPACE_ROOT_USED${NC} = ${SECOND_FRONT}${SECOND_FON}$SPACE_ROOT_USED${NC}
${FIRST_FRONT}${FIRST_FON}SPACE_ROOT_FREE${NC} = ${SECOND_FRONT}${SECOND_FON}$SPACE_ROOT_FREE${NC}
"
echo -en "$ALL"
