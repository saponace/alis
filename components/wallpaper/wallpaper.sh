#-------------------------------------------------
# Generate an abstract image and set is a wallpaper, periodically
#-------------------------------------------------

# Install dependencies
    # Cron scheduler if not already installed
        ${INSTALL} cronie
    # Generate-wallpaper script dependency to get the screen resolution
        ${INSTALL} xdpyinfo


# Enable cron
-   sudo systemctl enable cronie.service

# Install wallpaper generation script
    sudo pip install -e git+https://github.com/SubhrajitPrusty/wallgen#egg=wallgen

# Link script
create_link components/wallpaper/generate-wallpaper /bin


# Link systemd service and timer units
    sudo cp components/wallpaper/generate-wallpaper.service ${SYSTEMD_UNITS_DIRECTORY}
    create_link components/wallpaper/generate-wallpaper.timer ${SYSTEMD_UNITS_DIRECTORY}
    # Set username in the service
        sudo sed -i 's/%USERNAME%/'${USERNAME}'/g' ${systemd_units_directory}/generate-wallpaper.service
# Enable the timer
    sudo systemctl enable generate-wallpaper.timer
