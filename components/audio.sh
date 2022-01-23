#-------------------------------------------------
# Install Sound servers, and DAW
#-------------------------------------------------


# Sound server
    ${INSTALL} pipewire wireplumber
# GUI patchbay
    ${INSTALL} helvum
# Alsa connector
    ${INSTALL} pipewire-alsa
# Compatibility layer for pulseaudio applications
    ${INSTALL} pipewire-pulse
# Compatibility layer for JACK applications
    ${INSTALL} pipewire-jack
    # Avoid having to explicitely start Jack applications with a specific pipewire flag
        ${INSTALL} pipewire-jack-dropin
