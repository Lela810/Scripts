#!/bin/bash 


# Clear Current Screen
clear



#TEMP

#TEMP



apt autoremove -y

#Remove old updater files
cd /root/updater/
rm *_updater.sh
rm up.sh

rm *.sh.*



#Update
apt-get update


wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/installer_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/ssh_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/ntp_updater.sh




wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/up.sh
chmod +x *

if [ ! "$HOSTNAME" = sshgateway ]; then
./ssh_updater.sh
fi


./ntp_updater.sh
./installer_updater.sh
./up.sh

