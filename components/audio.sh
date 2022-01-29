#-------------------------------------------------
# Install Sound servers, and DAW
#-------------------------------------------------


# Sound server
    install_package pipewire wireplumber
# GUI patchbay
    install_package helvum
# Tray icon
    install_package pasystray
# Alsa connector
    install_package pipewire-alsa
# Compatibility layer for pulseaudio applications
    install_package pipewire-pulse
# Compatibility layer for JACK applications
    install_package pipewire-jack
    # Avoid having to explicitely start Jack applications with a specific pipewire flag
        install_package pipewire-jack-dropin
