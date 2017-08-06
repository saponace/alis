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


# Configure VPN (auto generate OpenVPN config files for VPN Private Internet Access)
    ${INSTALL} private-internet-access-vpn
    # Write credentials in a file
        echo "Enter VPN login"
        read VPN_LOGIN
        echo "Enter VPN password"
        read -s VPN_PASSWORD
        vpn_credentials_file="etc/private-internet-access/login.conf"

        sudo echo ${VPN_LOGIN} > ${vpn_credentials_file}
        sudo echo ${VPN_PASSWORD} >> ${vpn_credentials_file}

        unset VPN_LOGIN
        unset VPN_PASSWORD
        sudo chown root:root ${vpn_credentials_file}
        sudo chmod 600 ${vpn_credentials_file}
    # Create OpenVPN config files
        sudo pia -a
