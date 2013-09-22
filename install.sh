#!/bin/bash
####################################
###     part of Aobackuper       ###
###      for details goto        ###
### github.com/bockro/aobackuper ###
####################################
###     bockra         2013      ###
####################################

source ./files/aoback.cfg

function install()
{
whiptail --title "$progname" --yesno "Program will be installed in $inst_fldr dir\n If you want to use curent folder `pwd` for $progname select NO" 10 60
exitstatus=$?
if [ $exitstatus = 0 ]; then
	mkdir -p $inst_fldr
	cp -r ./files/* $inst_fldr
else
    echo "Install in curent dir"
    $inst_fldr=`pwd`
fi
}

function add_arch()
{
archive=$(whiptail --inputbox "Enter path to file/folder you want to backup \nLater you can edit archive.lst file line-by-line \nfor your backup list\nex. /home/user/folder or /var/log/main.log" 10 60 --title "$progname" 3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ] && [ ! -z "$archive" ] && [ -e "$archive" ]; then
    echo $archive >> $inst_fldr/$lst
else
    message "You have to enter at least one existing file or dir to backup"
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

function add_cron
{
cron=$(whiptail --title "$progname" --radiolist "Choose how often you want to make backups.\nInstaller will create sym link in /etc/cron.*\n\n select item with SPACE key" 15 45 3 \
"daily" ""  on \
"weekly" "" off \
"monthly" "" off \
3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
	ln -s $inst_fldr/$script /etc/cron.$cron/$script
else
    message "You can manually add $script to cron later"
fi

}

install
add_arch
yesno
add_cron

