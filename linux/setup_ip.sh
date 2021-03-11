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




#For if static ip


apt -y install net-tools network-manager



cat /etc/netplan/00-installer-config.yaml
echo
echo
echo "What Interface should get it? default:eth0 :"
read interface
echo
echo

if [ "$interface" == "" ]; then
interface=eth0
fi


ifconfig $interface | grep "inet"

echo
echo
echo "What IP should it get?:"
read ip
echo
echo

if [ "$ip" == "" ]; then
echo "An empty IP is not legal!"
exit 1
fi

echo
echo "What Subnetmask should it get? default:24 :"
read sm
echo
echo

if [ "$sm" == "" ]; then
sm=24
fi

echo
echo "What Gateway should it get? default:192.168.1.1 :"
read gw
echo
echo

if [ "$gw" == "" ]; then
gw=192.168.1.1
fi



if grep -q "dhcp4: no" /etc/netplan/00-installer-config.yaml; then
rm /etc/netplan/00-installer-config.yaml
cp ./config/00-installer-config.yaml /etc/netplan/
fi

#Set Fixed ip

echo "Your System will be available under: $ip/$sm"
echo

        sed -i "s/$interface:/$interface:\n      dhcp4: no\n      dhcp6: no\n      addresses: [$ip\/$sm]\n      gateway4: $gw\n      nameservers:\n        search: [klaus.local]\n        addresses: [192.168.1.112, 192.168.1.110]/" /etc/netplan/00-installer-config.yaml
        sed -i "s/dhcp4: true//" /etc/netplan/00-installer-config.yaml
		sed -i "s/dhcp6: true//" /etc/netplan/00-installer-config.yaml


