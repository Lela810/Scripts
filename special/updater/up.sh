#!/bin/bash 


# Clear Current Screen
clear


#Remove old updater files
cd /root/updater
rm updater.sh



#Update
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/updater.sh
chmod +x updater.sh
