#!/bin/bash

hostname=($1)

vim /etc/locale.gen
    -> uncomment fr_FR... lines
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --localtime
echo  $hostname > /etc/hostname
systemctl enable dhcpcd.service
mkinitcpio -p linux
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

