#-------------------------------------------------
# Specific configurations for desktops
#-------------------------------------------------


# Manage external i2c monitors brightness
    install_package ddcutil
    # Load i2c-dev module
        sudo modprobe i2c-dev
    create_link components/hardware-specific/desktop/scripts/set-external-monitors-brightness /usr/local/bin
    create_link components/hardware-specific/desktop/scripts/increase-brightness /usr/local/bin
    create_link components/hardware-specific/desktop/scripts/decrease-brightness /usr/local/bin
