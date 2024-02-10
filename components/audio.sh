#-------------------------------------------------
# Sound server
#-------------------------------------------------

# Sound server
install_package pipewire wireplumber

install_package helvum

install_package pipewire-alsa  # Alsa connector
install_package pipewire-pulse # Compatibility layer for pulseaudio applications
install_package pipewire-jack  # Compatibility layer for JACK applications

## Pulseaudio stuff (pulseaudio is used as a controller for pipewire)
install_package pavucontrol # PulseAudio mixer
install_package pasystray   # Pulseaudio system tray
create_finalize_startup_entry "Pulse audio tray icon" "pasystray &"
