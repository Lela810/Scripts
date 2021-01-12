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


#Download AMP-Overlays
cd /opt/cubecoders/amp/shared/overlays/
rm -r *
git clone https://github.com/Lela810/AMP-overlays
mv ./AMP-overlays/* ./
rm -r ./AMP-overlays

echo
echo "Your New Overlays:"
ls 
echo
echo

