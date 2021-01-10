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

cd  /opt/cubecoders/amp/shared/overlays/
rm *
wget https://raw.githubusercontent.com/lela810/amp-overlays/master/
