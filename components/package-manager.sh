#-------------------------------------------------
# Configure package manager
#-------------------------------------------------

# Yay AUR helper should be pre-intalle. No need to install another AUR helper

# Sync packages and force refresh of package database
    sudo pacman -Syy

# Configure pacman
    sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
    sudo sed -i 's/#ParallelDownloads.*/ParallelDownloads = 5/g' /etc/pacman.conf

# Configure pamac
    sudo sed -i 's/#EnableAUR/EnableAUR/g' /etc/pamac.conf
