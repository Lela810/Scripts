#!/bin/bash 


# Clear Current Screen
clear






# Update
cd /etc

if [ ! -f /etc/hosts.allow.old ]; then
mv /etc/hosts.allow /etc/hosts.allow.old
fi
if [ ! -f /etc/hosts.deny.old ]; then
mv /etc/hosts.allow /etc/hosts.deny.old
fi
rm hosts.allow
rm hosts.deny


wget https://raw.githubusercontent.com/lela810/Scripts/master/config/hosts.allow
wget https://raw.githubusercontent.com/lela810/Scripts/master/config/hosts.deny




echo
echo
echo "Your SSH Hosts are now up to date!"
echo
echo

