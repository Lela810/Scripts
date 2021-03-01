#!/bin/bash 


# Clear Current Screen
clear






# Update
systemctl stop telegraf
cd /etc/telegraf
rm telegraf.conf
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/telegraf.conf



systemctl enable telegraf
systemctl start telegraf

echo
echo
echo "Your Telegraf-Config is now up to date!"
echo
echo

