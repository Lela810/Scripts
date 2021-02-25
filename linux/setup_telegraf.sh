#!/bin/bash 

echo "Enter Database name to be created! default:virtual :"
read database
if [ "$database" == "" ]; then
database="virtual"
fi

# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi

systemctl stop telegraf


# Add Add the InfluxData repository with the following commands:
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/lsb-release
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

#  install the Telegraf service
apt update && apt -y install telegraf


# Create Telegraf Config
systemctl stop telegraf
cd /etc/telegraf
rm telegraf.conf
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/telegraf.conf
sed -i "s/__database__/$database/g" telegraf.conf
rm /root/Telegraf_Database.txt
echo "$database" > /root/Telegraf_Database.txt


systemctl enable telegraf
systemctl start telegraf
