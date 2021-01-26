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
rm *_updater.sh
rm up.sh


#Update

apt -y updater
apt -y upgrade

wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/installer_updater.sh



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/up.sh
chmod +x *


./installer_updater.sh
./up.sh