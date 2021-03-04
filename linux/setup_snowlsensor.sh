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
cd /tmp
add-apt-repository ppa:snowl/snort
apt-get update
apt install -y snort
systemctl stop snort
systemctl disable snort
wget https://snowl.io/download/snowl-sensor_1.7.1_amd64.deb && dpkg -i ./snowl-sensor_1.7.1_amd64.deb
/opt/snowl-sensor/snowl-snort fix




