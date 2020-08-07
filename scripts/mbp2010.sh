#!/bin/sh
# Specific stuff to install Arch Linux on a 2010 MBP.

set -e

# Set up cable network as long as we don't have a WiFi driver or dhcpcd
# installed. Probably won't need this unless we restart in the middle of the
# installation w/o dhcpcd installed.
ip address add 192.168.0.133/24 broadcast + dev enp3s0
ip route add default via 192.168.0.2 dev enp3s0
ip link up enp3s0

# Install updates and necessary packages
pacman -Syu
pacman -S \
  cpupower \
  dhcpcd \
  dosfstools \
  efibootmgr \
  gptfdisk \
  netctl \
  wifi-menu \
  brightnessctl \

nvim /etc/dhcpcd.conf  # noarp
systemctl enable dhcpcd
systemctl start dhcpc

# Bootloader
bootctl install
nvim /boot/loader/entries/arch-uefi.conf
cp /boot/loader/entries/arch-uefi.conf /boot/loader/entries/arch-uefi-fallback.conf
nvim /boot/loader/entries/arch-uefi-fallback.conf
nvim /boot/loader/loader.conf
bootctl update

# Blacklist some drivers we're not using.
echo "blacklist bluetooth" >> /etc/modprobe.d/50-disabling.conf
echo "blacklist btusb" >> /etc/modprobe.d/50-disabling.conf
echo "blacklist uvcvideo" >> /etc/modprobe.d/50-disabling.conf

# Cpupower
systemctl enable cpupower
systemctl start cpupower
cpupower frequency-set -g powersave

# Install WiFi driver
mkdir .aur
pushd .aur
git clone https://aur.archlinux.org/b43-firmware.git
cd b43-firmware
mkpkg -s
pacman -S b43-firmware-*.tar.xz
popd

# Configure WiFi
wifi-menu
