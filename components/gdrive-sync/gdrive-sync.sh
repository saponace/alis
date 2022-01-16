#-------------------------------------------------
# Synchronize files between Google drive and this local machine
#-------------------------------------------------


# Install sync utility
    ${INSTALL} rclone

# Auto-mount the distant directro at startup
    mkdir -p /mnt/google-drive
    create_link ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config/rclone /etc  # Systemd unit file looks for configuration in /etc/rclone
    create_link components/gdrive-sync/gdrive-sync.service ${SYSTEMD_UNITS_DIRECTORY}
    sudo systemctl enable gdrive-sync.service


# MANUAL-TODO: Create a connection to Google drive: `rclone config`. Name the remote "gdrive"

# TODO: When rclone version 1.58 is released, use `rclone bisync` instead of `rclone mount`
