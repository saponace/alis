#-------------------------------------------------
# Configure VPN client
#-------------------------------------------------


${INSTALL} python3 python-pip
sudo pip install pypia

# Install Networkmanager applet and all PIA servers as VPN entries in Networkmanager
    pypia -i

# Prepare NetworkManager connections directory to be readable by all (pypia needs read access to that directory)
    sudo mkdir -p /etc/NetworkManager/system-connections/
    sudo chmod a+r /etc/NetworkManager/system-connections/

# WIll then need to manually configure pypia (validate packages installation and input PIA creadentials)
