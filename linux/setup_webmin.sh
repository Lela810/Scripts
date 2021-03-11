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



#Download Premade Config Files
cd /tmp
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip -y
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.972_all.deb
dpkg --install webmin_1.972_all.deb


ufw allow 10000