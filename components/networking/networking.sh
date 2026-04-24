#-------------------------------------------------
# Configure networking
#-------------------------------------------------

install_package networkmanager network-manager-applet

# Disable ipv6 in dhcpcd.conf
sudo su -c "echo -e 'noipv6rs\nnoipv6' >> /etc/dhcpcd.conf"

# Disable NetworkManager /etc/resolv.conf DNS automatic updates and manually set custom DNS servers
# If not disabled, NetworkManager will set arbitrary DNS (notably ISP DNS)
sudo mkdir -p /etc/NetworkManager
sudo touch /etc/NetworkManager/NetworkManager.conf
sudo su -c "echo -e '[main]\ndns=none' >> /etc/NetworkManager/NetworkManager.conf"

# In container-based tests we may bind-mount /etc/resolv.conf; don't fight it.
if command -v findmnt >/dev/null 2>&1 && findmnt -T /etc/resolv.conf >/dev/null 2>&1; then
	echo "Skipping resolv.conf link because /etc/resolv.conf is a mount"
else
	create_link components/networking/config/resolv.conf /etc
fi

# Allow DNS resolution by systemd sevices (to give services ability to resolve domain names)
sudo systemctl enable systemd-resolved.service

# Auto-start NetworkManager applet
create_finalize_startup_entry "Network manager applet tray icon" "nm-applet 2>&1 /dev/null &"
