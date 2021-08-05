#!/bin/bash 


# Clear Current Screen
clear





# Update

timedatectl set-timezone Europe/Zurich
apt install chrony -y
systemctl enable --now chrony


cd /tmp/
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/chrony.conf

rm /etc/chrony/chrony.conf
mv /tmp/chrony.conf /etc/chrony/chrony.conf


systemctl restart chrony





echo
echo
echo "Your NTP is now up to date!"
echo
echo


