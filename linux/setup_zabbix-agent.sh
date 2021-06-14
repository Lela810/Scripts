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

systemctl restart zabbix-agent

cd /temp
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/zabbix_agentd.conf
rm /etc/zabbix/zabbix_agentd.conf
mv zabbix_agentd.conf /etc/zabbix/
mkdir /etc/zabbix/zabbix_agentd.d


cd /etc/zabbix/zabbix_agentd.d/
rm apt.conf
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/apt.conf

cd /tmp
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/02periodic
rm /etc/apt/apt.conf.d/02periodic
mv 02periodic /etc/apt/apt.conf.d/02periodic
systemctl restart zabbix-agent.service



systemctl stop zabbix-agent
systemctl enable zabbix-agent