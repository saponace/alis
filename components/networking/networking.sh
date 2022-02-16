#-------------------------------------------------
# Configure networking
#-------------------------------------------------

# Configure Networkmanager
    # Disable ipv6 in dhcpcd.conf
        sudo su -c "echo -e 'noipv6rs\nnoipv6' >> /etc/dhcpcd.conf"
    # Disable NetworkManager /etc/resolv.conf DNS automatic updates and manually set custom DNS servers
    # If not disabled; NetworkManager will set arbitrary DNS (notably ISP DNS)
        sudo su -c "echo -e '[main]\ndns=none' >> /etc/NetworkManager/NetworkManager.conf"
        create_link components/networking/config/resolv.conf /etc

# Allow DNS resolution by Systemd sevices (or else services wouldn't be able to resolve domain names)
    sudo systemctl enable systemd-resolved.service
