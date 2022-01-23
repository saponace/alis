#-------------------------------------------------
# Set up music production environment
#-------------------------------------------------


# Install DAW and dependencies
    ${INSTALL} bitwig-studio
    # MANUAL-TODO: Dev: Log in with Bitwig account in app "Bitwig Studio"


# Add user to audio group
    sudo usermod -a -G audio ${USERNAME}
# Give user write permission on Ableton push USB device
    create_link components/music-production/config/10-ableton-push.rules /etc/udev/rules.d/
