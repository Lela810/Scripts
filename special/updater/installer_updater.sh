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


#short term
apt remove unattended-upgrades 


# Update
cd /home/administrator
rm script_installer.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/installer/script_installer.sh
chmod +x script_installer.sh


echo
echo
echo "Your Installer is now up to date!"
echo
echo
