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


#load variables if available
if [ -f /root/updater/updater.conf ]; then
source /root/updater/updater.conf
fi


clear




echo
echo "Do you wanna to set a Static IP? y/n:"
if [ "$static" ]; then 
echo "(Press RETURN for saved configuration: "$static" )"
fi
read static
echo
echo

if [ ! "$static" ]; then 
source /root/updater/updater.conf
fi
if [ ! "$static" == "y" ] && [ ! "$static" == "n" ]; then 
static="n"
fi

sed -i "/static/d" /root/updater/updater.conf
echo "static=\""$static"\"" > /root/updater/updater.conf

if [ "$static" == "y" ]; then 
./linux/setup_ip.sh
echo
echo
echo "Your IP is now set Static!"
fi
 







if ! dpkg -s unattended-upgrades &> /dev/null; then
echo
echo "Do you wanna install Auto-update? y/n:"
if [ "$autoupdate" ]; then 
echo "(Press RETURN for saved configuration: "$autoupdate" )"
fi
read autoupdate
echo
echo
fi

if [ ! "$autoupdate" ]; then 
source /root/updater/updater.conf
fi
if [ ! "$autoupdate" == "y" ] && [ ! "$autoupdate" == "n" ]; then 
autoupdate="n"
fi

sed -i "/autoupdate/d" /root/updater/updater.conf
echo "autoupdate=\""$autoupdate"\"" > /root/updater/updater.conf






if ! dpkg -s zabbix-agent zabbix-agent2 &> /dev/null; then
echo
echo "Do you wanna install Zabbix Agent? y/n:"
if [ "$zabbix" ]; then 
echo "(Press RETURN for saved configuration: "$zabbix" )"
fi
read zabbix
echo
echo
fi

if [ ! "$zabbix" ]; then 
source /root/updater/updater.conf
fi
if [ ! "$zabbix" == "y" ] && [ ! "$zabbix" == "n" ]; then 
zabbix="n"
fi

sed -i "/zabbix/d" /root/updater/updater.conf
echo "zabbix=\""$zabbix"\"" > /root/updater/updater.conf








if ! dpkg -s zabbix-agent2 zabbix-agent &> /dev/null; then
echo
echo "Do you wanna install Zabbix Agent2? y/n:"
if [ "$zabbix2" ]; then 
echo "(Press RETURN for saved configuration: "$zabbix2" )"
fi
read zabbix2
echo
echo

fi
if [ ! "$zabbix2" ]; then 
source /root/updater/updater.conf
fi
if [ ! "$zabbix2" == "y" ] && [ ! "$zabbix2" == "n" ]; then 
zabbix2="n"
fi

sed -i "/zabbix2/d" /root/updater/updater.conf
echo "zabbix2=\""$zabbix2"\"" > /root/updater/updater.conf







if [ /etc/init/ttyS0.conf ]; then
echo 
echo
echo "Do you wanna install a Serial Terminal? y/n:"
if [ "$serial" ]; then 
echo "(Press RETURN for saved configuration: "$serial" )"
fi
read serial
echo
echo
fi

fi
if [ ! "$serial" ]; then 
source /root/updater/updater.conf
fi
if [ ! "$serial" == "y" ] && [ ! "$serial" == "n" ]; then 
serial="n"
fi

sed -i "/serial/d" /root/updater/updater.conf
echo "serial=\""$serial"\"" > /root/updater/updater.conf










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

if [ "$zabbix2" == "y" ]; then 
./linux/setup_zabbix-agent2.sh
echo
echo
echo "Zabbix Agent2 installed!"
fi


if [ "$serial" == "y" ]; then 
./linux/setup_serial.sh
echo
echo
echo "Serial Terminal installed!"
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


