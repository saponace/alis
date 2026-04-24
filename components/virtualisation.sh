#-------------------------------------------------
# Virtualisation with Virtualbox
#-------------------------------------------------

install_package virtualbox

if pacman -Qq | grep -Eq '^linux[0-9]+-virtualbox-host-modules$'; then
	echo "Skipping virtualbox-host-dkms because kernel-specific VirtualBox host modules are already installed"
else
	install_package virtualbox-host-dkms # Install required modules for virtualbox
fi

if modinfo vboxdrv >/dev/null 2>&1; then
	sudo modprobe vboxdrv # Enable virtualbox driver module
else
	echo "Skipping vboxdrv modprobe because the module is unavailable"
fi
