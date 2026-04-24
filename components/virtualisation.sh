#-------------------------------------------------
# Virtualisation
#-------------------------------------------------

#-------------------------------------------------
# QEMU/KVM (for qcow2-based VM testing)
#-------------------------------------------------

install_package qemu-full
install_package libvirt
install_package virt-manager
install_package dnsmasq
install_package virt-viewer

# UEFI firmware for VMs
if pacman -Si edk2-ovmf >/dev/null 2>&1; then
	install_package edk2-ovmf
else
	install_package ovmf
fi

# Prefer nft backend for libvirt NAT on modern systems
if pacman -Si iptables-nft >/dev/null 2>&1; then
	install_package iptables-nft
fi

if [ -d /run/systemd/system ]; then
	sudo systemctl enable --now libvirtd.service
	# Ensure the default NAT network exists and is enabled.
	if command -v virsh >/dev/null 2>&1; then
		sudo virsh net-start default >/dev/null 2>&1 || true
		sudo virsh net-autostart default >/dev/null 2>&1 || true
	fi
else
	echo "Skipping libvirtd enable/start because systemd is not running"
fi

# Allow the current user to manage VMs without sudo (takes effect after re-login).
if command -v usermod >/dev/null 2>&1; then
	sudo usermod -aG libvirt,kvm "${USERNAME}" || true
fi

#-------------------------------------------------
# VirtualBox
#-------------------------------------------------

# Install VirtualBox and prefer DKMS modules to avoid provider prompts.
if pacman -Qq | grep -Eq '^linux[0-9]+-virtualbox-host-modules$'; then
	install_package virtualbox
	echo "Skipping virtualbox-host-dkms because kernel-specific VirtualBox host modules are already installed"
else
	install_package virtualbox virtualbox-host-dkms
fi

if modinfo vboxdrv >/dev/null 2>&1; then
	sudo modprobe vboxdrv # Enable virtualbox driver module
else
	echo "Skipping vboxdrv modprobe because the module is unavailable"
fi
