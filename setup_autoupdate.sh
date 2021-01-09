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

# Update Local System Packages 
apt update && apt -y upgrade

#install Auto Update
apt -y install unattended-upgrades apt-listchanges bsd-mailx

#Enable Auto Update
dpkg-reconfigure -plow unattended-upgrades