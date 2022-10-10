#!/bin/bash

start=`date +%s`

if [[ $# != 1 ]]
then
	echo "Invalid number of arguments (expected 1, input $#)"
	exit 1
fi

if [[ !(-d $1) ]]
then
	echo "it is not a directory"
	exit 1
fi

if [[ $1 != */ ]]
then
	echo "incorrect input"
	exit 1
fi

total_folders="$(find $1 -type d | wc -l)"
echo "Total number of folders (including all nested ones) = ${total_folders}"

big_folders="$(du -hx $1 | sort -rh | head -6 | tail -n 5| awk '{print $2", "$1}' | grep -n $1)"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):
$big_folders"

total_files="$(find $1 -type f | wc -l)"
echo "Total number of files = $total_files"

echo "Number of:  
Configuration files (with the .conf extension) = $(find $1 -name "*.conf" | wc -l)
Text files = $(find $1 -name "*.txt" | wc -l)
Executable files = $(find $1 -type f -perm /a=x | wc -l)
Log files (with the extension .log) = $(find $1 -name "*.log" | wc -l)
Archive files = $(find /etc/ -name "*.zip" -name "*.tar" -name "*.rar"|wc -l)
Symbolic links = $(find $1 -type l |wc -l)"

top_files=$(find $1 -xdev -type f -size -100G -print | xargs ls -lh | sort -k5,5 -h -r |
	head -10 | awk -F '[^[:alpha:]]' '{ print $0,$NF }' | awk '{print $9", "$5", "$10}' | grep -n $1)
echo "TOP 10 files of maximum size arranged in descending order (path, size and type): 
$top_files"

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
j="$(find $1 -type f -perm /a=x -size -100G | xargs ls -lh | sort -k5,5 -h -r | head -10 | wc -l)"
for ((i=1; i <= 10 && i <= j; i++))
do
	first="$(find $1 -type f -perm /a=x -size -100G | xargs ls -lh |
		sort -k5,5 -h -r | head -$i | tail -n 1 | awk '{print $9}' | xargs md5sum | awk '{print $1}')"
	echo "$i - $(find $1 -type f -perm /a=x -size -100G | xargs ls -lh | sort -k5,5 -h -r |
	       	head -$i | tail -n 1 | awk '{print $9", "$5", "}')$first" 
done

end=`date +%s`
runtime=$((end-start))

echo "Script execution time (in seconds) = $runtime"
