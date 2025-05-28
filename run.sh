# Running update
sudo apt update && sudo apt upgrade -y

# Install essential apps
sudo apt install qemu-system uml-utilities virt-manager git \
    wget libguestfs-tools p7zip-full make dmg2img tesseract-ocr \
    tesseract-ocr-eng genisoimage vim net-tools screen -y # Some of them are require

# Getting virtual machine packages
sudo wget -O OVMF_CODE.fd "https://archive.org/download/qemu_bios/bios.fd" # Getting BIOS
sudo wget -O OpenCore.qcow2 "https://archive.org/download/qemu_bios/loader.qcow2" # Getting Loader
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
read -p "Do you want to modify your VM options? (y/n): " MODIFY_VM

if [[ "$MODIFY_VM" == "y" || "$MODIFY_VM" == "Y" ]]; then
    echo "Modifying vm.sh"
    sleep 3
    sudo nano ./vm.sh
    echo "Modified"
else
    echo "Skipping modify..."
fi
sleep 6
echo "Launching VM..."
sleep 3
echo "To run the VM again, type \"sudo bash vm.sh\""
sudo bash vm.sh
