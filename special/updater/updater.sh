#!/bin/bash 


# Clear Current Screen
clear


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