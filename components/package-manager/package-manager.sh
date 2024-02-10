#-------------------------------------------------
# Package managers
#-------------------------------------------------

# Yay AUR helper should be pre-intalle. No need to install another AUR helper

# Prevent yay from exceding sudo timeout during long builds
create_homedir_link components/package-manager/config/yay .config

# Non-AUR Package manager
sudo pacman -Syy # Sync packages and force refresh of package database
sudo pacman -Syu # Update all installed packages
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads.*/ParallelDownloads = 5/g' /etc/pacman.conf

# GUI package manager
sudo sed -i 's/#EnableAUR/EnableAUR/g' /etc/pamac.conf
