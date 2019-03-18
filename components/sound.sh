#-------------------------------------------------
# Install Sound servers, and DAW
#-------------------------------------------------


# Sound server
    ${INSTALL} pulseaudio pulseaudio-alsa alsa-utils pavucontrol pasystray
    # Use bluetooth headphones with pulseaudio
        ${INSTALL} pulseaudio-bluetooth bluez bluez-utils bluez-firmware
