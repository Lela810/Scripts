#!/bin/bash 


# Clear Current Screen
clear


#Remove old updater files
cd /root/updater
rm *_updater.sh
rm up.sh

rm *.sh.*

apt remove snowl-sensor snort snort-* -y



#Update



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/installer_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/autoupdate_updater.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/ssh_updater.sh



wget https://raw.githubusercontent.com/lela810/Scripts/master/special/updater/up.sh
chmod +x *

if [ ! "$HOSTNAME" = sshgateway ]; then
./ssh_updater.sh
fi

./autoupdate_updater.sh
./installer_updater.sh
./up.sh

