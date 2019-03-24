#-------------------------------------------------
# Configure VPN client
#-------------------------------------------------


${INSTALL} python3
sudo pip install pypia

# Install Networkmanager applet and all PIA servers as VPN entries in Networkmanager
    pypia -i

# WIll then need to manually configure pypia (validate packages installation and input PIA creadentials)
