#-------------------------------------------------
# Set up music production environment
#-------------------------------------------------


# Install DAW and dependencies
    install_package bitwig-studio
    create_manual_todo 'Music production' 'Log in with Bitwig account in app "Bitwig Studio"'

# Configue bitwig desktop entry to start with pipewire jack bridge. This desktop file has to have the same name as the
# one creatd in /usr/share/applications in order to override it
    create_link components/music-production/config/com.bitwig.BitwigStudio.desktop ${USER_HOMEDIR_DOTFILES_DESTINATION}/.local/share/applications/

# Add user to audio group
    sudo usermod -a -G audio ${USERNAME}

# Give user write permission on Ableton push 2 USB device
    sudo cp components/music-production/config/10-ableton-push.rules /etc/udev/rules.d/
