#!/bin/bash 


# Clear Current Screen
clear

if [ ! -d /root/updater-data ]; then
	mkdir /root/updater-data
fi

if [ -f /root/updater-data/Telegraf_Database.txt ]; then
	database=$(cat /root/updater-data/Telegraf_Database.txt)
else
	database="virtual"
	echo "$database" > /root/updater-data/Telegraf_Database.txt
fi


if [ "$database" == "" ]; then
database="virtual"
fi



# Update
systemctl stop telegraf
cd /etc/telegraf
rm telegraf.conf
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/telegraf.conf
sed -i "s/__database__/$database/g" telegraf.conf


systemctl enable telegraf
systemctl start telegraf

echo
echo
echo "Your Telegraf-Config is now up to date!"
echo
echo

