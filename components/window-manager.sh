#-------------------------------------------------
# Install window manager, login manager and lock-screen
#-------------------------------------------------


# Login manager
    ${INSTALL} slim
    sudo systemctl enable slim.service
    # Link config files
        create_link ${ADDITIONAL_CONFIG_FILES_DIR}/slim/slim.conf /etc/
        create_link ${ADDITIONAL_CONFIG_FILES_DIR}/slim/slim-minimal/ /usr/share/slim/themes/

# Windows manager
    ${INSTALL} i3-wm
    # Application launcher (rofi is a program launcher and window selector. Calls dmenu to start programs)
        ${INSTALL} rofi dmenu
    # Status bar
        ${INSTALL} py3status
    # py3status dependencies
        # Fontawesome for the icons in the status bar
            ${INSTALL} otf-font-awesome
        # Proc stats, for mpstat, proc stats
            ${INSTALL} sysstat
        # Communication interprotocoles i3wm, dependence de config py3status
            ${INSTALL} i3ipc-python
        # Send notifications via dbus
            ${INSTALL} python-pydbus
        # Get metrics for cpu & ram
            ${INSTALL} conky
        # Timezones for date
            ${INSTALL} python-tzlocal
        # Simple calendar
            ${INSTALL} gsimplecal
        # Pacman checkupdates tool
            ${INSTALL} pacman-contrib
        # Get metrics from internal sensors
            ${INSTALL} lm_sensors
        # Get WiFi status
            ${INSTALL} iw
        # Link py3status configuration files
            create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/i3status ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
        # Link i3 configuration files
            create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/i3 ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
    # Set background wallpaper
        ${INSTALL} feh


# Lock screen (take a screenshot, blur it and put it as the lack screen background)
    # Lock screen
    ${INSTALL} i3lock
    # Screenshot utility (take a screenshot of the active view)
        ${INSTALL} scrot
    # Image modifier, used to lock blur the screenshot
        ${INSTALL} imagemagick
    # Custom lock-screen script
        create_link ${EXTERNAL_SCRIPTS_DIR}/lock-screen /bin

# Notifications daemon
    ${INSTALL} dunst
    # Link configuration files
       create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/dunst ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config

# System initialisation
    create_link ${HOMEDIR_DOTFILES_SOURCE}/.xinitrc ${USER_HOMEDIR_DOTFILES_DESTINATION}
