#-------------------------------------------------
# Install and configure virtualisation engine virtualbox
#-------------------------------------------------


# Install virtualbox
    ${INSTALL} virtualbox
# Install required modules for virtualbox
    ${INSTALL} virtualbox-host-dkms
# Enable virtualbox driver module
    sudo modprobe vboxdrv
