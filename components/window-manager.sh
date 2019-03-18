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
    ${INSTALL} i3
    # Application launcher (rofi is a program launcher and window selector. Calls dmenu to start programs)
        ${INSTALL} rofi dmenu
    # Status bar
        ${INSTALL} i3blocks
    # i3blocks dependencies
        # Proc stats, for mpstat, proc stats
            ${INSTALL} sysstat
        # Fontawesome for the icons in the status bar
            ${INSTALL} otf-font-awesome

# Lock screen (take a screenshot, blur it and put it as the lack screen background)
    # Lock screen
    ${INSTALL} i3lock
    # Screenshot utility (take a screenshot of the active view)
        ${INSTALL} scrot
    # Image modifier, used to lock blur the screenshot
        ${INSTALL} imagemagick

# Notifications daemon
    ${INSTALL} dunst
