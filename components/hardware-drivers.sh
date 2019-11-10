#-------------------------------------------------
# Install hardware drivers
#-------------------------------------------------


# Graphic drivers
    ${INSTALL} mesa xf86-video-vesa
# Touchpad drivers
    ${INSTALL} xf86-input-synaptics
# Brightness control (backlight)
    ${INSTALL} light
    # Allow user to set brightness
    sudo usermod -a -G video ${username}
