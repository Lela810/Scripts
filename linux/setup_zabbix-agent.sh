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




apt install zabbix-agent -y

wget https://raw.githubusercontent.com/lela810/Scripts/master/config/zabbix_agentd.conf
rm /etc/zabbix/zabbix_agentd.conf
mv zabbix_agentd.conf /etc/zabbix/

systemctl restart zabbix-agent
systemctl enable zabbix-agent