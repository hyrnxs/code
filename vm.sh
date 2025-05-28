# QEMU options (change your settings here.)

MY_OPTIONS="+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"

# Tip: These are the recommend CPU for VM
# AMD: EPYC-Genoa-v1
# Intel: Cascadelake-Server
# If you want full CPU feature use options "host" but use it with risk.

ALLOCATED_RAM="4096" # MiB
RAM_SLOTS="2"
MAX_RAM="8192" # MiB

CPU_MODEL="host"
CPU_SOCKETS="1"
CPU_CORES="2"
CPU_THREADS="4"

# shellcheck disable=SC2054
args=(
  -enable-kvm -m "$ALLOCATED_RAM"M,slots="$RAM_SLOTS",maxmem="$MAX_RAM"M -cpu "$CPU_MODEL",kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,"$MY_OPTIONS"
  -machine q35
  -device qemu-xhci,id=xhci
  -device usb-kbd,bus=xhci.0 -device usb-tablet,bus=xhci.0
  -smp "$CPU_THREADS",cores="$CPU_CORES",sockets="$CPU_SOCKETS"
  -device usb-ehci,id=ehci
  # -device usb-kbd,bus=ehci.0
  # -device usb-mouse,bus=ehci.0
  # -device nec-usb-xhci,id=xhci
  # -global nec-usb-xhci.msi=off
  # -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
  # -device usb-host,vendorid=0x8086,productid=0x0808  # USB Sound Card
  # -device usb-host,vendorid=0x1b3f,productid=0x2008  # Other USB Sound Card
  -drive if=pflash,format=raw,readonly=on,file="./OVMF_CODE.fd"
  -smbios type=2
  -device ich9-intel-hda -device hda-duplex
  -device ich9-ahci,id=sata
  -drive id=OpenCoreBoot,if=none,snapshot=on,format=qcow2,file="./OpenCore.qcow2"
  -device ide-hd,bus=sata.2,drive=OpenCoreBoot
  -drive id=HDD,if=none,file="./hdd.img",format=qcow2
  -device ide-hd,bus=sata.4,drive=HDD
  -cdrom "./cd.iso"
  # -netdev tap,id=net0,ifname=tap0,script=no,downscript=no -device virtio-net-pci,netdev=net0,id=net0,mac=52:54:00:c9:18:27
  # -netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-pci,netdev=net0,id=net0,mac=52:54:00:c9:18:27
  # -netdev user,id=net0 -device vmxnet3,netdev=net0,id=net0,mac=52:54:00:c9:18:27  # Note: Use this line for High Sierra
  -monitor stdio
  -device vmware-svga,id=video0,vgamem_mb=8192,bus=pcie.0,addr=0x10 # Prefer VMWare-SVGA
  # -device qxl-vga,id=video0,vgamem_mb=8192,ram_size=8192,vram_size=8192,bus=pcie.0,addr=0x10 # Prefer QXL-VGA
  # -spice port=5900,addr=127.0.0.1,disable-ticketing=on
  -vnc 127.0.0.1:1
)

qemu-system-x86_64 "${args[@]}" & ./noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:80
