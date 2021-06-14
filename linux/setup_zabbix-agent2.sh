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


wget https://repo.zabbix.com/zabbix/5.2/debian/pool/main/z/zabbix-release/zabbix-release_5.2-1+debian10_all.deb
dpkg -i zabbix-release_5.2-1+debian10_all.deb
apt update

apt install zabbix-agent2 -y

systemctl restart zabbix-agent2

cd /tmp
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/zabbix_agent2.conf
rm /etc/zabbix/zabbix_agent2.conf
mv zabbix_agent2.conf /etc/zabbix/
mkdir /etc/zabbix/zabbix_agent2.d



cd /etc/zabbix/zabbix_agentd.d/
rm apt.conf
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/apt.conf

cd /tmp
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/02periodic
rm /etc/apt/apt.conf.d/02periodic
mv 02periodic /etc/apt/apt.conf.d/02periodic
systemctl restart zabbix-agent.service


systemctl stop zabbix-agent2
systemctl enable zabbix-agent2