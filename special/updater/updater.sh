#!/bin/bash 


# Clear Current Screen
clear


#TEMP
cd /etc/zabbix/zabbix_agentd.d/
rm apt.conf
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/apt.conf

cd /temp
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/02periodic
rm /etc/apt/apt.conf.d/02periodic
mv 02periodic /etc/apt/apt.conf.d/02periodic
systemctl restart zabbix-agent.service

#Remove old updater files
cd /root/updater
rm *_updater.sh
rm up.sh

rm *.sh.*



#Update



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/installer_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/ssh_updater.sh



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/up.sh
chmod +x *

if [ ! "$HOSTNAME" = sshgateway ]; then
./ssh_updater.sh
fi

./autoupdate_updater.sh
./installer_updater.sh
./up.sh

