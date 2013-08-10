#!/bin/bash

source ./files/aoback.cfg

function add_arch()
{
archive=$(whiptail --inputbox "Enter path to file/folder you want to backup \nLater you can edit archive.lst file line-by-line \nfor your backup list\nex. /home/user/folder or /var/log/main.log" 10 60 --title "$progname" 3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ] && [ ! -z "$archive" ]; then
    echo $archive >> ./files/$lst
else
    message "You have to enter at least one file or dir to backup"
    add_arch
fi
}

function yesno()
{
whiptail --title "$progname" --yesno "Do you want to add one more item to backup?" --defaultno 10 60 
 
exitstatus=$?
if [ $exitstatus = 0 ]; then

    add_arch
    yesno
else
    echo "User selected No."
fi
}

function message()
{
whiptail  --msgbox "$1" 8 60 --title "$progname"
}

add_arch 
yesno


