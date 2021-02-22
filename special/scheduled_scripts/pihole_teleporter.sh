#!/bin/bash 


# Clear Current Screen
clear



#Create Teleporter Backup
set -e
backupfolder="/mnt/backup"
DATE=$(date "+%Y-%m-%d_%H-%M-%S")
php /var/www/html/admin/scripts/pi-hole/php/teleporter.php > "$backupfolder/pi-hole-teleporter_$DATE.tar.gz"
find "$backupfolder" -mtime +7 -delete
echo $DATE

