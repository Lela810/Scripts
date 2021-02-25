#!/bin/bash 


# Clear Current Screen
clear


if [ -f /root/Telegraf_Database.txt ]; then
	database=$(cat /root/Telegraf_Database.txt)
else
	database="virtual"
	echo "$database" > /root/Telegraf_Database.txt
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

