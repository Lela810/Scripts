#!/bin/bash 


# Clear Current Screen
clear



#TEMP

timedatectl set-timezone Europe/Zurich
apt install chrony -y
systemctl enable --now chronydsystemctl enable --now chrony
cd /tmp/
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/chrony.conf
rm /etc/chrony/chrony.conf
mv /tmp/chrony.conf /etc/chrony/chrony.conf
systemctl restart chrony
rm /root/autoupdate.sh

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

