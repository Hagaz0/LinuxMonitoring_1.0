#!/bin/bash

re='^[0-9]+$'
if [[ ($1 =~ $re) || ($# != 1) ]]
then
	echo "Incorrect input"
else
	echo "$1"
fi
