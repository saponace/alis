#-------------------------------------------------
# Configure VPN client
#-------------------------------------------------


# Install package
    install_package piavpn-bin

# Configure
    sudo systemctl enable piavpn.service
    cp -r components/vpn-client/config/privateinternetaccess ${USER_HOME}/.config  # Copy instead of link since PIA client constantly updates this file, and I don't want the repo file to be changed
    create_manual_todo 'VPN client' 'Log in with PIA account in app "Private Internet Access"'
