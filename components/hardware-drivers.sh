#-------------------------------------------------
# Install hardware drivers
#-------------------------------------------------


# Video drivers
    # TODO: Check if xf86-video-vesa is required, and if other open source drivers should be installed on a
    # per-target-hardware basis
    install_package mesa xf86-video-vesa

# Bluetooth
    install_package bluez blueman
    sudo systemctl enable bluetooth.service


