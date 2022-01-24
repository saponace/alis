#-------------------------------------------------
# Install and configure virtualisation engine virtualbox
#-------------------------------------------------


# Install virtualbox
    install_package virtualbox
# Install required modules for virtualbox
    install_package virtualbox-host-dkms
# Enable virtualbox driver module
    sudo modprobe vboxdrv
