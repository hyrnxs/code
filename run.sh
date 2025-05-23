# Running update
sudo apt update && sudo apt upgrade -y
# Install essential apps
sudo apt install qemu-system uml-utilities virt-manager git wget libguestfs-tools p7zip-full make tesseract-ocr tesseract-ocr-eng genisoimage vim net-tools screen neofetch -y
# Getting virtual machine packages
sudo wget -O bios.fd "https://archive.org/download/qemu_bios/bios.fd" # Getting Bios
sudo wget -O loader.qcow2 "https://archive.org/download/qemu_bios/loader.qcow2" # Getting Loader
sudo wget -O win.iso "https://archive.org/download/win-10-superlite-v.-6/Win10SUPERLITE%20V.6.iso" # Getting Windows ISO
git clone https://github.com/novnc/noVNC.git noVNC
qemu-img create -f qcow2 win.img 64G
# Launching VM
clear
echo Launching VM...
echo "To run the VM again, type "sudo bash vm.sh""
sudo bash vm.sh
