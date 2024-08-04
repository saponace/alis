#-------------------------------------------------
# configure window manager and desktop environment
#-------------------------------------------------

# Window manager
install_package i3-gaps
create_link components/window-manager/config/i3 ${USER_HOME}/.config

# Application launcher and window selector
install_package rofi
create_link components/window-manager/config/rofi ${USER_HOME}/.config

## Status bar
install_package py3status
create_link components/window-manager/config/py3status ${USER_HOME}/.config
# py3status dependencies
install_package i3ipc-python               # Communication interprotocoles i3wm, dependence de config py3status
install_package python-pydbus              # Send notifications via dbus
install_package python-tzlocal python-pytz # Timezones for date
install_package gsimplecal                 # Simple calendar
install_package pacman-contrib             # Pacman checkupdates tool
install_package iw                         # Get WiFi status
install_package pamixer                    # Show current volume status

# Windows compositor
install_package picom
create_link components/window-manager/config/picom.conf ${USER_HOME}/.config

# Show system information on the desktop
install_package conky
create_link components/window-manager/config/conky ${USER_HOME}/.config
create_finalize_startup_entry "Show system informations on the desktop" "conky &"

## Notifications
# Disable dunst notification daemon
sudo mv /usr/share/dbus-1/services/org.knopwob.dunst.service{,.disabled}
# Use xfce4-notifyd instead
install_package xfce4-notifyd
create_link components/window-manager/config/xfce4-notifyd/xfce4-notifyd.xml ${USER_HOME}/.config/xfce4/xfconf/xfce-perchannel-xml

# Enable numpad at startup
install_package numlockx
create_finalize_startup_entry "Enable numpad" "numlockx"

# Handle screen lock after timeout, sleep, hibernate, etc.
install_package xss-lock
create_finalize_startup_entry "Use i3lock as a screen saver" "xss-lock --transfer-sleep-lock -- i3exit lock &"

# Deploy wallpaper (used by LightDM and Nitrogen)
# Copy instead of symlink because lightDM does not handle symlinks for some reason
sudo cp components/window-manager/image/wallpaper.jpg /usr/share/backgrounds/

# Display manager (assume LightDM installed and configured by live USB Installer)
install_package xinit-xsession
sudo sed -i "s/user-session=i3/user-session=xinitrc/g" /etc/lightdm/lightdm.conf # Configure LightDM to start .xinitrc instead of i3
# Copy instead of symlink because lightDM does not handle symlinks for some reason
sudo cp components/window-manager/config/lightdm/slick-greeter.conf /etc/lightdm/

# Nitrogen should be started AFTER autorandr. Make sure it is after autorandr in finalize-startup
# (autaorandr is injected in finalize-startup by component "display")
install_package nitrogen
create_finalize_startup_entry "Restore wallpaper configuration and start windows compositor" "nitrogen --restore; sleep 1; picom -b"
nitrogen --save --set-scaled /usr/share/backgrounds/wallpaper.jpg

# System initialisation
create_link components/window-manager/config/.xinitrc ${USER_HOME}
