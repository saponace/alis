#-------------------------------------------------
# configure window manager and desktop environment
#-------------------------------------------------


# Windows manager
    # i3 configuration files
        create_link components/window-manager/config/i3 ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
    # Application launcher (rofi is a program launcher and window selector
        install_package rofi
        create_link components/window-manager/config/rofi ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
    # Status bar
        install_package py3status
    # py3status
        # py3status configuration files
            create_link components/window-manager/config/i3status ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
        # py3status dependencies
            # Fontawesome for icons (in status bar, app launcher, etc.
                install_package otf-font-awesome
            # Proc stats, for mpstat, proc stats
                install_package sysstat
            # Communication interprotocoles i3wm, dependence de config py3status
                install_package i3ipc-python
            # Send notifications via dbus
                install_package python-pydbus
            # Get metrics for cpu & ram
                install_package conky
            # Timezones for date
                install_package python-tzlocal
            # Simple calendar
                install_package gsimplecal
            # Pacman checkupdates tool
                install_package pacman-contrib
            # Get metrics from internal sensors
                install_package lm_sensors
            # Get WiFi status
                install_package iw
    # Set background wallpaper
        install_package feh



# System initialisation
    create_link components/window-manager/config/.xinitrc ${USER_HOMEDIR_DOTFILES_DESTINATION}
    # Link script to initialize user session (called from .xinitrc)
        create_link components/window-manager/scripts/finalize-startup /usr/local/bin

# Enable blur for transparent backgrounds in picom
    sed -i 's/# blur-background =.*/blur-background = true/g' ${USER_HOMEDIR_DOTFILES_DESTINATION}/picom.conf
