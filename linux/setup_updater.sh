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
mkdir /root/updater
cd /root/updater
rm updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/updater.sh
chmod +x updater.sh

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
sed -i "/updater.sh/d" mycron
sed -i "/autoupdate.sh/d" mycron
sed -i "/installer_updater.sh/d" mycron
echo "*/5 * * * * /root/updater/updater.sh > /dev/null 2>&1" >> mycron
#install new cron file
crontab mycron
rm mycron


#create new command
ln -s /root/updater/updater.sh /bin/update-script