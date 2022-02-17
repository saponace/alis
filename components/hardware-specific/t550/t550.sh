#-------------------------------------------------
# Specific configurations for a Thinkpad T550
#-------------------------------------------------


# Generic to all laptops
    # Battery state indicator
        install_package acpi
    # Suspend tool
        install_package pm-utils
    # Change behavior of system depending on AC state
        install_package laptop-mode-tools
        sudo systemctl enable laptop-mode.service
    # Touchpad drivers
        install_package xf86-input-synaptics
    # Brightness control (backlight)
        # Used to get brightness percenage from i3status
            install_package light
        # Used to set brightness percenage from i3 key binding
            install_package brightnessctl
        # Allow user to set brightness
            sudo usermod -a -G video ${USERNAME}
    # Enable laptop-only configuration configurations
        sed -i "s/# order += 'backlight'.*/order += 'backlight'/g" ${USER_HOME}/.config/i3status/config
        sed -i "s/# order += 'battery_level'.*/order += 'battery_level'/g" ${USER_HOME}/.config/i3status/config

# Specific to thinkpads
    # Start and stop charging batteries at given values (preserve batteries health on the long term)
        install_package tp-battery-mode
        sudo systemctl enable tp-battery-mode

# Specific to laptops with two batteries (get combined battery level and notify if it is too low)
    # Get battery level script
        create_link components/hardware-specific/t550/scripts/battery-level /usr/local/bin
    # Link systemd service and timer units
        create_link components/hardware-specific/t550/systemd-units/battery-level.service ${SYSTEMD_UNITS_DIRECTORY}
        create_link components/hardware-specific/t550/systemd-units/battery-level.timer ${SYSTEMD_UNITS_DIRECTORY}
    # Enable the timer
        sudo systemctl enable battery-level.timer
