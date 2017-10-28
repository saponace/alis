#-------------------------------------------------
# Install/configure networking related programs
#-------------------------------------------------


# Install Networkmanager packages
    # To access network state without root privileges
        ${INSTALL} wpa_supplicant
    # Network manager
        ${INSTALL} networkmanager
    # NetworkManager tray icon
        ${INSTALL} network-manager-applet gnome-keyring gnome-icon-theme

# Configure Networkmanager
    # Enable network manager
        sudo systemctl enable NetworkManager.service
    # Disable ipv6 in dhcpcd.conf
        su -c "echo -e 'noipv6rs\nnoipv6' >> /etc/dhcpcd.conf"
