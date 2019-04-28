#-------------------------------------------------
# Enable automatic wallpapaer rotation
#-------------------------------------------------

-# Install cron scheduler if not already installed
-    ${INSTALL} cronie
-# Enable cron
-    sudo systemctl enable cronie.service


# Link systemd service and timer units
    systemd_units_directory=/etc/systemd/system/
    sudo cp components/wallpaper/wallpaper-rotation.service ${systemd_units_directory}
    create_link components/wallpaper/wallpaper-rotation.timer ${systemd_units_directory}
    # Set username in the service
        sudo sed -i 's/%USERNAME%/'${username}'/g' ${systemd_units_directory}/wallpaper-rotation.service
# Enable the timer
    sudo systemctl enable wallpaper-rotation.timer
