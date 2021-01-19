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

#Remove old updater files
cd /root/updater
rm updater.sh



#Update
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/updater.sh
chmod +x updater.sh
