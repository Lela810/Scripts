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

echo
echo
echo "For which Domain should the script be configured?"
read Domain
echo
echo

echo
echo "Which Hostname should be targeted? default:@ :"
read hostname
echo
echo

if [ "$hostname" == "" ]; then
hostname="@"
fi



#install godaddy_ip_renew_domain
cd /root
rm godaddy_ip_renew_domain.com.sh
wget https://raw.githubusercontent.com/lela810/Scripts/master/special/scheduled_scripts/godaddy_ip_renew_domain.com.sh

FILE="godaddy_ip_renew_domain.com.sh"

find . -type f -name '*domain.com.sh' | while read FILE ; do
    newfile="$(echo ${FILE} |sed -e "s/domain.com/$Domain/" |sed -e 's/\.\///')" ;
    mv "${FILE}" "${newfile}" ;

	sed -i "s/__domain.com__/$Domain/g" "${newfile}"
	sed -i "s/__hostname__/$hostname/g" "${newfile}"
	
	chmod +x "${newfile}"
	
	#write out current crontab
	crontab -l > mycron
	#echo new cron into cron file
	sed -i "/${newfile}/d" mycron
	echo "*/5 * * * * /root/${newfile} > /dev/null 2>&1" >> mycron
	#install new cron file
	crontab mycron
	rm mycron
done	
	