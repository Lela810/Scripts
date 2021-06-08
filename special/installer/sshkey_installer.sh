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

su administrator
ssh-keygen -b 4096 -C $HOSTNAME
exit

cat /home/administrator/.ssh/id_rsa.pub >> /home/administrator/.ssh/authorized_keys
cp /home/administrator/.ssh/id_rsa* /home/administrator
chmod 777 /home/administrator/id_rsa*
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config
echo "IgnoreUserKnownHosts no" >> /etc/ssh/sshd_config
echo "StrictModes yes" >> /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config


echo ""
echo ""
echo ""
echo "Download your Keys now from /home/administrator before pressing ENTER!"
echo "Download these files:"
ls /home/administrator/id_rsa*
echo ""
read -s

rm /home/administrator/id_rsa*
systemctl restart sshd