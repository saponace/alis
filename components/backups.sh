#-------------------------------------------------
# Install and configure backups utilities
#-------------------------------------------------

# Install Syncthing: file mirroring/backuping
    ${INSTALL} syncthing
    ${INSTALL} syncthingtray

    sudo systemctl enable syncthing@${username}.service

    echo "Manual setup required, please follow instructions in \"backup.sh\" after system reboot"
    # Setup instructions:
    # Once Syncthing is started (via systemd), go to http://localhost:8384, navigate to Actions>Advanced
    # Copy the API key
    # Click on the syncthing tray icon, "three dots" button, and input the following:
    # - Syncthing URL: http://localhost:8384
    # API Key: [PREVIOUSLY_COPIED_API_KEY]
