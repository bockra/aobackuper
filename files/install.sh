#!/bin/bash

function add_arch()
{
archive=$(whiptail --inputbox "Enter path to file/folder you want to backup \nLater you can edit archive.lst file line-by-line \nfor your backup list\nex. /home/user/folder or /var/log/main.log" 10 60 --title "Aobackup" 3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then

    echo $archive >> archive.lst
    
else
    echo "User selected Cancel."
fi
 
echo "(Exit status was $exitstatus)"
}

function yesno()
{
whiptail --title "Aobackup" --yesno "Do you want to add one more item to backup?" 10 60 
 
exitstatus=$?
if [ $exitstatus = 0 ]; then

    add_arch
    yesno
else
    echo "User selected No."
fi
}

add_arch 
yesno
