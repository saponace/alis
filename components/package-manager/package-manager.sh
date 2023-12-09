#-------------------------------------------------
# Configure package manager
#-------------------------------------------------

# Yay AUR helper should be pre-intalle. No need to install another AUR helper

# Sync packages and force refresh of package database
    sudo pacman -Syy

# Update all installed packages
    sudo pacman -Syu

# Configure pacman
    sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads.*/ParallelDownloads = 5/g' /etc/pacman.conf

# Configure pamac
    sudo sed -i 's/#EnableAUR/EnableAUR/g' /etc/pamac.conf

# Prevent yay from exceding sudo timeout during long builds
    create_link components/package-manager/config/yay ${USER_HOME}/.config
    create_link components/package-manager/config/yay ${ROOT_HOME}/.config
