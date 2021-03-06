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
    systemd_units_directory=/etc/systemd/system/
    create_link components/battery-management/battery-level.service ${systemd_units_directory}
    create_link components/battery-management/battery-level.timer ${systemd_units_directory}
# Enable the timer
    sudo systemctl enable battery-level.timer
