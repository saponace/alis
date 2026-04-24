#-------------------------------------------------
# Package managers
#-------------------------------------------------

sudo pacman --noconfirm -S yay

# Prevent yay from exceding sudo timeout during long builds
create_homedir_link components/package-manager/config/yay .config

# Non-AUR Package manager
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads.*/ParallelDownloads = 5/g' /etc/pacman.conf

# GUI package manager
if [ -f /etc/pamac.conf ]; then
	sudo sed -i 's/#EnableAUR/EnableAUR/g' /etc/pamac.conf
else
	echo "Skipping pamac configuration because /etc/pamac.conf is missing"
fi
