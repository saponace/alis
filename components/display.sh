#-------------------------------------------------
# Install display dependencies
#-------------------------------------------------


# X server
    ${INSTALL} xorg-server xorg-server-utils xorg-xinit
# Multi-monitor management
    ${INSTALL} xrandr arandr
# Color shifter, reduce blue emission
    ${INSTALL} redshift
