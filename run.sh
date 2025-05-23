# Running update
sudo apt update && sudo apt upgrade -y
# Install essential apps
sudo apt install qemu-system uml-utilities virt-manager git wget libguestfs-tools p7zip-full make tesseract-ocr tesseract-ocr-eng genisoimage vim net-tools screen neofetch -y
# Getting virtual machine packages
sudo wget -O bios.fd "https://archive.org/download/qemu_bios/bios.fd" # Getting Bios
sudo wget -O loader.qcow2 "https://archive.org/download/qemu_bios/loader.qcow2" # Getting Loader
sudo wget -O win.iso "https://archive.org/download/en-us_windows_10_iot_enterprise_ltsc_2021_x64_dvd_257ad90f_202211/en-us_windows_10_iot_enterprise_ltsc_2021_x64_dvd_257ad90f.iso" # Getting Windows ISO
# Launching VM
clear
echo Launching VM...
echo "To run the VM again, type "sudo bash vm.sh""
sudo bash vm.sh
