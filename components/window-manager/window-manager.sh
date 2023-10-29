#-------------------------------------------------
# configure window manager and desktop environment
#-------------------------------------------------


# Windows manager
    # Window manager
        install_package i3-gaps

    # i3 configuration files
        create_link components/window-manager/config/i3 ${USER_HOME}/.config
    # Application launcher (rofi is a program launcher and window selector
        install_package rofi
        create_link components/window-manager/config/rofi ${USER_HOME}/.config
    # Status bar
        install_package py3status
    # py3status
        # py3status configuration files
            create_link components/window-manager/config/i3status ${USER_HOME}/.config
        # py3status dependencies
            # Communication interprotocoles i3wm, dependence de config py3status
                install_package i3ipc-python
            # Send notifications via dbus
                install_package python-pydbus
            # Timezones for date
                install_package python-tzlocal python-pytz
            # Simple calendar
                install_package gsimplecal
            # Pacman checkupdates tool
                install_package pacman-contrib
            # Get WiFi status
                install_package iw
            # Show current volume status
                install_package pamixer
    # Set background wallpaper
        install_package nitrogen
        # Warning: nitrogen should be started AFTER autorandr. Make sure it is after autorandr in finalize-startup
        # (autaorandr is injected in finalize-startup by component "display")
        create_finalize_startup_entry "Restore wallpaper configuration and start windows compositor" "nitrogen --restore; sleep 1; picom -b"
    # Windows compositor
        install_package picom
        create_link components/window-manager/config/picom.conf ${USER_HOME}/.config
    # Conky: System information on the desktop
        install_package conky
        create_link components/window-manager/config/conky ${USER_HOME}/.config
        create_finalize_startup_entry "Show system informations on the desktop" "conky &"


# Enable numpad at startup
    install_package numlockx
    create_finalize_startup_entry "Enable numpad" "numlockx"


# Handle screen lock after timeout, sleep, hibernate, etc.
    install_package xss-lock
    create_finalize_startup_entry "Use i3lock as a screen saver" "xss-lock --transfer-sleep-lock -- i3exit lock &"


# Display manager (assume LightDM installed and configured by manjaro-i3)
    # execute .xinitrc instead of i3 straight
        install_package xinit-xsession
        sudo sed -i "s/user-session=i3/user-session=xinitrc/g" /etc/lightdm/lightdm.conf


# System initialisation
    create_link components/window-manager/config/.xinitrc ${USER_HOME}

