!/bin/bash 


# Clear Current Screen
clear

# Check Session Status
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
elif [[ $EUID -eq 0 ]]; then
   echo -e "Session Running as \e[36mROOT\e[0m"
fi

#install needed Tools
apt get update && apt get upgrade
apt -y install net-tools network-manager git


clear
echo
echo "Do you wanna to set a Static IP? y/n:"
read static
echo
echo

#For if static ip
if [ "$static" == "y" ]; then 



ip a
echo
echo
echo
echo
echo "What Interface should get it? default:eth0 :"
read interface
echo
echo

if [ "$interface" == "" ]; then
interface=eth0
fi

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




#Set Fixed ip

        sed -i "s/$interface:/$interface:\n      dhcp4: no\n      dhcp6: no\n      addresses: [$ip\/$sm]\n      gateway4: $gw\n      nameservers:\n        search: [klaus.local]\n        addresses: [192.168.1.112, 192.168.1.110]/" /etc/netplan/00-installer-config.yaml
        sed -i "s/dhcp4: true//" /etc/netplan/00-installer-config.yaml
		sed -i "s/dhcp6: true//" /etc/netplan/00-installer-config.yaml
netplan apply
fi

#Download Scripts Repo
cd /tmp/
git clone https://github.com/Lela810/Scripts
cd ./Scripts
cd ./linux
chmod +x *
mv * /home/administrator
cd /home/administrator
rm -r /tmp/Scripts

echo
echo
echo "Your Scrips are now located in /home/administrator"
echo 
echo
echo
echo "Do you wanna Reboot now? y/n:"
read reboot
echo
echo


if [ "$static" == "y" ]; then 
echo "Your System will be available under: $ip/$sm"
echo
echo
echo
fi


if [ "$reboot" == "y" ]; then 
echo "Rebooting Now!"
echo
reboot
fi

