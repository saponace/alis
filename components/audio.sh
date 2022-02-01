#-------------------------------------------------
# Install Sound servers, and DAW
#-------------------------------------------------


# Sound server
    install_package pipewire wireplumber
# GUI patchbay
    install_package helvum
    # Pulseaudio (used as a controller for pipewire)
    # Tray icon
        install_package pasystray
    # Mixer
        install_package pavucontrol
# Alsa connector
    install_package pipewire-alsa
# Compatibility layer for pulseaudio applications
    install_package pipewire-pulse
# Compatibility layer for JACK applications
    install_package pipewire-jack
