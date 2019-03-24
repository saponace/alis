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
    # to ISP own DNS servers and manually set custom DNS servers IPs
    # 192.168.0.20: personal DNS server
    # 1.1.1.1: CLoudflare DNS server
    # 8.8.8.8 Google DNS servers
        su -c "echo -e '[main]\ndns=none' >> /etc/NetworkManager/NetworkManager.conf"
        su -c "echo -e 'nameserver 192.168.0.20\nnameserver 1.1.1.1\nnameserver 8.8.8.8\nnameserver 8.8.8.4' > /etc/resolv.conf"
