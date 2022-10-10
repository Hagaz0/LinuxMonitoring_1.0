#!/bin/bash

source config.txt

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

re='^[1-6]$'

if [[ $# != 0 ]]
then
	echo "Don't input arguments"
	exit 1
fi

if [[ !($column1_background =~ $re || $column1_background == "") || 
	!($column1_font_color =~ $re || $column1_font_color == "") ||
       	!($column2_background =~ $re || $column2_background == "") ||
       	!($column2_font_color =~ $re || $column2_font_color == "") ]]
then
	echo "Incorrect input"
	exit 1
fi

if [[ $column1_background == "" ]]
then
	column1_background="default"
fi

if [[ $column1_font_color == "" ]]
then
	column1_font_color="default"
fi

if [[ $column2_background == "" ]]
then
	column2_background="default"
fi

if [[ $column2_font_color == "" ]]
then
	column2_font_color="default"
fi

case $column1_background in
	1)
		FIRST_FON=$ON_WHITE
		first_fon_name="white"
		;;
	2)
		FIRST_FON=$ON_RED
		first_fon_name="red"
		;;
	3)
		FIRST_FON=$ON_GREEN
		first_fon_name="green"
		;;
	4)
		FIRST_FON=$ON_BLUE
		first_fon_name="blue"
		;;
	5)
		FIRST_FON=$ON_PURPLE
		first_fon_name="purple"
		;;
	6 | default)
		FIRST_FON=$ON_BLACK
		first_fon_name="black"
		;;
esac

case $column1_font_color in
	1 | default)
		FIRST_FRONT=$WHITE
		first_front_name="white"
		;;
	2)
		FIRST_FRONT=$RED
		first_front_name="red"
		;;
	3)
		FIRST_FRONT=$GREEN
		first_front_name="green"
		;;
	4)
		FIRST_FRONT=$BLUE
		first_front_name="blue"
		;;
	5)
		FIRST_FRONT=$PURPLE
		first_front_name="purple"
		;;
	6)
		FIRST_FRONT=$BLACK
		first_front_name="black"
		;;
esac

case $column2_background in
	1)
		SECOND_FON=$ON_WHITE
		second_fon_name="white"
		;;
	2)
		SECOND_FON=$ON_RED
		second_fon_name="red"
		;;
	3)
		SECOND_FON=$ON_GREEN
		second_fon_name="green"
		;;
	4)
		SECOND_FON=$ON_BLUE
		second_fon_name="blue"
		;;
	5 | default)
		SECOND_FON=$ON_PURPLE
		second_fon_name="purple"
		;;
	6)
		SECOND_FON=$ON_BLACK
		second_fon_name="black"
		;;
esac

case $column2_font_color in
	1 | default)
		SECOND_FRONT=$WHITE
		second_front_name="white"
		;;
	2)
		SECOND_FRONT=$RED
		second_front_name="red"
		;;
	3)
		SECOND_FRONT=$GREEN
		second_front_name="green"
		;;
	4)
		SECOND_FRONT=$BLUE
		second_front_name="blue"
		;;
	5)
		SECOND_FRONT=$PURPLE
		second_front_name="purple"
		;;
	6)
		SECOND_FRONT=$BLACK
		second_front_name="black"
		;;
esac

if [[ ($first_fon_name == $first_front_name) || ($second_fon_name == $second_front_name) ]]
then
	echo "The font and background colors match. Call the script again"
	exit 1
fi

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
${FIRST_FRONT}${FIRST_FON}SPACE_ROOT_FREE${NC} = ${SECOND_FRONT}${SECOND_FON}$SPACE_ROOT_FREE${NC}"

COLORS="Column 1 background = ${column1_background} (${first_fon_name})
Column 1 font color = ${column1_font_color} (${first_front_name})
Column 2 background = ${column2_background} (${second_fon_name})
Column 2 font color = ${column2_font_color} (${second_front_name})"

echo -en "$ALL

$COLORS
"
