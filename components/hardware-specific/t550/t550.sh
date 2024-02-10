#-------------------------------------------------
# Specific configurations for a Thinkpad T550
#-------------------------------------------------

## Generic to all laptops
install_package acpi     # Battery state indicator
install_package pm-utils # Suspend tool

install_package laptop-mode-tools # Change behavior of system depending on AC state
sudo systemctl enable laptop-mode.service

install_package libinput # Touchpad drivers
create_finalize_startup_entry "Disale touchpad while typing on keyboard" "syndaemon -i 0.2 -d &"

# Brightness control (backlight)
install_package light         # Used by i3status to get brightness percenage
install_package brightnessctl # Used by i3 keybindings to set brightness

sed -i "s/# order += 'backlight'.*/order += 'backlight'/g" ${USER_HOME}/.config/i3status/config
sed -i "s/# order += 'battery_level'.*/order += 'battery_level'/g" ${USER_HOME}/.config/i3status/config

## Specific to thinkpads
install_package tp-battery-mode # Start and stop charging batteries at given values (preserve batteries health on the long term)
sudo systemctl enable tp-battery-mode

## Specific to laptops with two batteries (get combined battery level and notify if it is too low)
create_link components/hardware-specific/t550/scripts/battery-level /usr/local/bin # Get battery level script

# Manipulte brightness
create_link components/hardware-specific/t550/scripts/increase-brightness /usr/local/bin
create_link components/hardware-specific/t550/scripts/decrease-brightness /usr/local/bin

# Link systemd service and timer units
sudo cp components/hardware-specific/t550/systemd-units/battery-level.service ${SYSTEMD_UNITS_DIRECTORY} # Copy instead of link since Systemd cannot read uints which are symbolic links accross partitions at startup
sudo cp components/hardware-specific/t550/systemd-units/battery-level.timer ${SYSTEMD_UNITS_DIRECTORY}   # Copy instead of link since Systemd cannot read uints which are symbolic links accross partitions at startup
sudo systemctl enable battery-level.timer                                                                # Enable the timer
