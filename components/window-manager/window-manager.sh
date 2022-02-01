#-------------------------------------------------
# configure window manager and desktop environment
#-------------------------------------------------


# Windows manager
    # Window manager
        install_package i3-gaps

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
            # Show currnet volume status
                install_package pamixer
    # Set background wallpaper
        install_package nitrogen
    # Windows compositor
        install_package picom
        create_link components/window-manager/config/picom.conf ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
    # Conky: System information on the desktop
        install_package conky
        create_link components/window-manager/config/conky ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config


# Used in script finalize-startup to enable numpad at startup
    install_package numlockx

# Handle screen lock after timeout, sleep, hibernate, etc.
    install_package xss-lock


# Display manager (assume LightDM installed and configured by manjaro-i3)
    # execute .xinitrc instead of i3 straight
        install_package xinit-xsession
        sudo sed -i "s/user-session=i3/user-session=xinitrc/g" /etc/lightdm/lightdm.conf


# System initialisation
    create_link components/window-manager/config/.xinitrc ${USER_HOMEDIR_DOTFILES_DESTINATION}
    create_link components/window-manager/config/.Xresources ${USER_HOMEDIR_DOTFILES_DESTINATION}
    # Link script to initialize user session (called from .xinitrc)
        create_link components/window-manager/scripts/finalize-startup /usr/local/bin

