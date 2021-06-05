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
apt update && apt -y upgrade
apt -y install git grep


#install script installer in /root
cd /root
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/installer/script_installer.sh
chmod +x script_installer.sh



#Download Scripts Repo
cd /tmp/
git clone https://github.com/Lela810/Scripts
cd ./Scripts/linux
chmod +x *
cd /tmp/Scripts





clear




echo
echo
echo "Your Scrips are now located in /home/administrator"
echo 
echo


echo
echo "Do you wanna to set a Static IP? y/n:"
read static
echo
echo

if [ "$static" == "y" ]; then 
./linux/setup_ip.sh
echo
echo
echo "Your IP is now set Static!"
fi




if ! dpkg -s unattended-upgrades &> /dev/null; then
echo
echo "Do you wanna install Auto-update? y/n:"
read autoupdate
echo
echo
fi

if ! dpkg -s zabbix-agent &> /dev/null; then
echo
echo "Do you wanna install Zabbix Agent? y/n:"
read zabbix
echo
echo
fi

echo
echo "Do you wanna migrate to Proxmox? y/n:"
read proxmig
echo
echo







if [ "$proxmig" == "y" ]; then
head -n -4 /etc/initramfs-tools/modules > tmp.txt && mv tmp.txt /etc/initramfs-tools/modules
update-initramfs -u

apt install qemu-guest-agent -y
apt remove linux-virtual linux-cloud-tools-virtual linux-tools-virtual -y
echo
echo
echo "Linux migrated to Proxmox!"
fi



if [ "$autoupdate" == "y" ]; then 
./linux/setup_autoupdate.sh
echo
echo
echo "Auto-update installed!"
fi

if [ "$zabbix" == "y" ]; then 
./linux/setup_zabbix-agent.sh
echo
echo
echo "Zabbix Agent installed!"
fi


./linux/setup_updater.sh



cd /root
rm -r /tmp/Scripts


if [ "$zabbix" == "y" ]; then 
if [ "$static" == "n" ]; then 
systemctl restart zabbix-agent
fi
fi



if [ "$static" == "y" ]; then 
echo
echo "Do you wanna set the IP now?(Connection loss in most cases) y/n:"
read netplanapply
echo
echo


if [ "$netplanapply" == "y" ]; then 
echo
cat /etc/netplan/00-installer-config.yaml
echo
echo
echo "Setting IP now!"
echo
netplan apply
exit 0
fi
fi


#reboot
if [ -f /var/run/reboot-required ]; then
echo ***System needs to be rebooted***
echo
echo "Do you wanna Reboot now? y/n:"
read reboot
echo
echo
fi


echo "Installation finished Successfully!"



if [ "$reboot" == "y" ]; then 
echo "Rebooting Now!"
echo
reboot
fi


