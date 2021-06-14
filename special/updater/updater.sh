#!/bin/bash 


# Clear Current Screen
clear

#TEMP

apt remove linux-virtual linux-cloud-tools-virtual linux-tools-virtual -y
systemctl disable hv-kvp-daemon.service

#TEMP



#Remove old updater files
cd /root/updater/
rm *_updater.sh
rm up.sh

rm *.sh.*



#Update



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/installer_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/ssh_updater.sh



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/up.sh
chmod +x *

if [ ! "$HOSTNAME" = sshgateway ]; then
./ssh_updater.sh
fi

./autoupdate_updater.sh
./installer_updater.sh
./up.sh

