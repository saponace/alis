#-------------------------------------------------
# Install hardware drivers
#-------------------------------------------------


# Graphic drivers
    ${INSTALL} mesa xf86-video-vesa
# Touchpad drivers
    ${INSTALL} xf86-input-synaptics
# Brightness control (backlight)
    # Used to get brightness percenage from i3status
        ${INSTALL} light
    # Used to set brightness percenage from i3 key binding
        ${INSTALL} brightnessctl
    # Allow user to set brightness
        sudo usermod -a -G video ${USERNAME}
