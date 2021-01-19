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



#Download Premade Config Files
cd /root
rm autoupdate.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/scheduled_scripts/autoupdate.sh
chmod +x autoupdate.sh

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 * * * * /root/autoupdate.sh" >> mycron
#install new cron file
crontab mycron
rm mycron