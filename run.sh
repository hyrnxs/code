# Running update
sudo apt update && sudo apt upgrade -y

# Install essential apps
sudo apt install qemu-system uml-utilities git wget libguestfs-tools p7zip-full make tesseract-ocr tesseract-ocr-eng vim net-tools screen neofetch -y # Some of them are require

# Getting virtual machine packages
sudo wget -O bios.fd "https://archive.org/download/qemu_bios/bios.fd" # Getting BIOS
sudo wget -O loader.qcow2 "https://archive.org/download/qemu_bios/loader.qcow2" # Getting Loader
sudo wget -O OVMF_VARS.fd "https://archive.org/download/qemu_bios/OVMF_VARS.fd" # Getting BIOS Vars

# Prompt for ISO link, fuck windows (idk)
clear
echo Find a vaild link of OS ISO
read -p "ISO Link: " ISO_LINK
sudo wget -O cd.iso "$ISO_LINK" # Getting ISO ############################# done

git clone https://github.com/novnc/noVNC.git noVNC
qemu-img create -f qcow2 hdd.img 64G # 64 gigabyte? man.

# Modify & Launching VM
clear
echo "Modify your VM options, Exit to use default options." # modify the cpu and ram are recommended lol
sleep 6
sudo nano ./vm.sh
echo "Modified."
sleep 6
echo "Launching VM..."
sleep 3
echo "To run the VM again, type \"sudo bash vm.sh\""
sudo bash vm.sh
