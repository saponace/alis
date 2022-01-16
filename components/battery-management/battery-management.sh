#-------------------------------------------------
# Install and configure utilities to save battery on a laptop
#-------------------------------------------------


# Battery state indicator
    ${INSTALL} acpi
# Suspend tool
    ${INSTALL} pm-utils
# Change behavior of system depending on AC state
    ${INSTALL} laptop-mode-tools
    sudo systemctl enable laptop-mode.service

# Link systemd service and timer units
    create_link components/battery-management/battery-level.service ${SYSTEMD_UNITS_DIRECTORY}
    create_link components/battery-management/battery-level.timer ${SYSTEMD_UNITS_DIRECTORY}
# Enable the timer
    sudo systemctl enable battery-level.timer
