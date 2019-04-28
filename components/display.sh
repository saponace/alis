#-------------------------------------------------
# Install display dependencies
#-------------------------------------------------


# X server
    ${INSTALL} xorg-server xorg-server-utils xorg-xinit
# Multi-monitor management
    ${INSTALL} xrandr arandr
# Color shifter, reduce blue emission
    ${INSTALL} redshift
    # Switch redshift state script
        create_link ${SCRIPTS_DIR}/switch-redshift-state /bin

# Set backlight level script
    create_link ${SCRIPTS_DIR}/change-backlight-level /bin
