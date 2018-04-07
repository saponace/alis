#-------------------------------------------------
# Configure VPN
#-------------------------------------------------


${INSTALL} openvpn
# Auto generate OpenVPN config files for VPN Private Internet Access (pia)
    ${INSTALL} pia-tools
    sudo pia-tools --setup
# Enable OpenVPN, the config file is one of the config files generated by pia-tools
    sudo systemctl enable pia@France
# Update openVPN config files
    sudo systemctl start pia-tools-update.timer