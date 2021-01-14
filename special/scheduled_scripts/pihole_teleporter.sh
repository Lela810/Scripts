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


#Create Teleporter Backup
set -e
backupfolder="/mnt/backup"
DATE=$(date "+%Y-%m-%d_%H-%M-%S")
php /var/www/html/admin/scripts/pi-hole/php/teleporter.php > "$backupfolder/pi-hole-teleporter_$DATE.tar.gz"
find "$backupfolder" -mtime +7 -delete
echo $DATE

