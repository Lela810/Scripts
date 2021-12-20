#!/bin/bash 


# Clear Current Screen
clear



#Download AMP-Overlays
mkdir /opt/cubecoders/amp/shared/overlays
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

