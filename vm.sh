# QEMU options (change your settings here.)

OTHER="+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check"
RAM="8192" # MiB
SOCKETS="1"
CORES="2"
THREADS="2"

PATH="."

args=(
  -enable-kvm -m "$RAM" -cpu host,kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on,"$OTHER"
  -machine q35
  -device qemu-xhci,id=xhci
  -device usb-kbd,bus=xhci.0 -device usb-tablet,bus=xhci.0
  -smp "$THREADS",cores="$CORES",sockets="$SOCKETS"
  -device usb-ehci,id=ehci,addr=0x4 -device usb-tablet
  -device usb-kbd,bus=ehci.0
  -drive file="$PATH/win.iso",media=cdrom
  -device usb-host,vendorid=0x8086,productid=0x0808  
  # -device usb-host,vendorid=0x1b3f,productid=0x2008  # Other USB Sound Card
  -drive if=pflash,format=raw,readonly=on,file="$PATH/boot.fd"
  -smbios type=2
  -device ich9-intel-hda -device hda-duplex
  -device ich9-ahci,id=sata
# Disable by default, turn on Boot Loader if you want.
  # -drive id=Loader,if=none,snapshot=on,format=qcow2,file="$PATH/loader.qcow2"
  # -device ide-hd,bus=sata.2,drive=Loader
  -drive id=HDD,if=none,file="$PATH/win.img",format=qcow2
  -device ide-hd,bus=sata.4,drive=HDD
  -monitor stdio
  # -device vmware-svga,id=video0,vgamem_mb=8192,bus=pcie.0,addr=0x10 # Prefer VMWare-SVGA
  -device qxl-vga,id=video0,vgamem_mb=8192,ram_size=8192,vram_size=8192,bus=pcie.0,addr=0x10 # Prefer QXL-VGA
  # -spice port=5900,addr=127.0.0.1,disable-ticketing=on
  -vnc 127.0.0.1:1
)

qemu-system-x86_64 "${args[@]}" & ./noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:80
