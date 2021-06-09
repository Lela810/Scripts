
echo
echo "Do you wanna migrate to Proxmox? y/n:"
read proxmig
echo
echo




if [ "$proxmig" == "y" ]; then
head -n -4 /etc/initramfs-tools/modules > tmp.txt && mv tmp.txt /etc/initramfs-tools/modules
update-initramfs -u

apt install qemu-guest-agent -y

systemctl disable hv-kvp-daemon.service

echo
echo
echo "Linux migrated to Proxmox!"
fi

