#!/bin/bash 


# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi


cd  /etc/init/
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/ttys0.conf


touch /var/run/reboot-required

