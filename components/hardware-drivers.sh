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
    create_finalize_startup_entry "Enable bluetooth" "dbus-update-activation-environment DISPLAY; blueman-applet &"


# Touchpad drivers (unused on platforms without a touchpad, but cqlled qnywqys in script "finalze-startup")
    install_package xf86-input-synaptics
