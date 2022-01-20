#-------------------------------------------------
# Specific configurations for a Thinkpad T550
#-------------------------------------------------


# Generic to all laptops
    # Battery state indicator
        ${INSTALL} acpi
    # Suspend tool
        ${INSTALL} pm-utils
    # Change behavior of system depending on AC state
        ${INSTALL} laptop-mode-tools
        sudo systemctl enable laptop-mode.service
    # Touchpad drivers
        ${INSTALL} xf86-input-synaptics
    # Brightness control (backlight)
        # Used to get brightness percenage from i3status
            ${INSTALL} light
        # Used to set brightness percenage from i3 key binding
            ${INSTALL} brightnessctl
        # Allow user to set brightness
            sudo usermod -a -G video ${USERNAME}
    # Enable laptop-only configuration configurations
        sed -i "s/# order += 'backlight'.*/order += 'backlight'/g" ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config/i3status/config
        sed -i "s/# order += 'battery_level'.*/order += 'battery_level'/g" ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config/i3status/config

# Specific to thinkpads
    # Start and stop charging batteries at given values (preserve batteries health on the long term)
        ${INSTALL} tp-battery-mode
        sudo systemctl enable tp-battery-mode

# Specific to laptops with two batteries (get combined battery level and notify if it is too low)
    # Get battery level script
        create_link components/hardware-specific/t550/scripts/battery-level /usr/local/bin
    # Link systemd service and timer units
        create_link components/hardware-specific/t550/systemd-units/battery-level.service ${SYSTEMD_UNITS_DIRECTORY}
        create_link components/hardware-specific/t550/systemd-units/battery-level.timer ${SYSTEMD_UNITS_DIRECTORY}
    # Enable the timer
        sudo systemctl enable battery-level.timer
