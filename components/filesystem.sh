#-------------------------------------------------
# Configure filesystem
# Filesystem is BTRFS
#-------------------------------------------------

# Snapshots management tool
install_package snapper snapper-gui

# Create a snapshot before each pacman intervention on the system
install_package snap-pac

# Create snapshot configurations
# By default, Snapper will create a snapshot for each config every hour
sudo snapper -c root create-config /
sudo snapper -c home create-config /home
