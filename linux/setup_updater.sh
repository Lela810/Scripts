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


# install updater
cd /root
rm installer_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/installer_updater.sh
chmod +x installer_updater.sh

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "*/5 * * * * /root/installer_updater.sh" >> mycron
#install new cron file
crontab mycron
rm mycron