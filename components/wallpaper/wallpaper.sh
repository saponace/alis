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
    systemd_units_directory=/etc/systemd/system/
    sudo cp components/wallpaper/generate-wallpaper.service ${systemd_units_directory}
    create_link components/wallpaper/generate-wallpaper.timer ${systemd_units_directory}
    # Set username in the service
        sudo sed -i 's/%USERNAME%/'${username}'/g' ${systemd_units_directory}/generate-wallpaper.service
# Enable the timer
    sudo systemctl enable generate-wallpaper.timer
