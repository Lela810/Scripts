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


ssh-keygen



sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config


echo ""
echo ""
echo ""
echo "Download your Keys now from /home/administrator before pressing ENTER!"
echo "Download these files:"
ls /home/administrator/id_rsa*
echo ""
read -s

systemctl restart sshd