#-------------------------------------------------
# Synchronize files between Google drive and this machine
#-------------------------------------------------

# Sync utility
install_package rclone

# Auto-mount the distant directrory at startup
sudo chown ${USERNAME}:${USERNAME} /mnt
mkdir -p /mnt/google-drive
create_link ${USER_HOME}/.config/rclone /etc                                                # Systemd unit file looks for configuration in /etc/rclone
sudo cp components/gdrive-sync/systemd-units/gdrive-sync.service ${SYSTEMD_UNITS_DIRECTORY} # This copies instead of link since Systemd cannot read units which are symbolic links accross partitions at startup
sudo systemctl enable gdrive-sync.service

create_manual_todo 'Google Drive sync' 'Create a connection to Google drive: `rclone config`. Name the remote "gdrive"'
