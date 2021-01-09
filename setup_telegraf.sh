#!/bin/bash 

echo "Enter Database name to be created:"
read database


# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi

# Update Local System Packages 
apt update && apt -y upgrade

# Add Add the InfluxData repository with the following commands:
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

#  install the Telegraf service
apt update && apt -y install telegraf


# Create Telegraf Config
cd /etc/telegraf
rm telegraf.conf
wget https://raw.githubusercontent.com/lela810/Scripts/master/telegraf.conf
sed -i "s/__database__/$database/g" telegraf.conf


systemctl enable telegraf
systemctl start telegraf
