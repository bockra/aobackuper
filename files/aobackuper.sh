#!/bin/bash
####################################
###     part of Aobackuper       ###
###      for details goto        ###
### github.com/bockro/aobackuper ###
####################################
###     bockra         2013      ###
####################################
source ./aoback.cfg

#lst (def archive.lst) - list of dirs and files to backup
#dir (def $HOME) - dir to store backups
#name (def `date +%d-%m-%y`-aob.tar.gz) - archive filename (ex 08-08-13-aob.tar.gz)

case "$1" in
        -a) 
		if [ $# -gt 1 ]
		then
			for i in $(seq 2 $#); do
			#variable from variable :)
			echo "Adding item ${!i} to backup list $lst"
			echo "${!i}" >> ./$lst
			done	
			exit 0	
		fi
	        ;;
        -b) echo "noooo"
        ;;
esac



for i in `uniq $lst`
	do
	if [ -e "$i" ]; then
		list=$list" "$i
	else
		echo "$i is not exists"
	fi
	done;

$list=$list" "$lst
echo $list

tar -pzcvf $dir/$name $list

