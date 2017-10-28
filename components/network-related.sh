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
    # Disable NetworkManager /etc/resolv.conf DNS IP address dynamic updates
    # to ISP own DNS servers and manually set Google's DNS servers IPs
        su -c "echo -e '[main]\ndns=none' >> /etc/NetworkManager/NetworkManager.conf"
        su -c "echo -e 'nameserver 8.8.8.8\nnameserver 8.8.8.4' > /etc/resolv.conf"
