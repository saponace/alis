#-------------------------------------------------
# Virtualisation with Virtualbox
#-------------------------------------------------

install_package virtualbox

install_package virtualbox-host-dkms # Install required modules for virtualbox
sudo modprobe vboxdrv                # Enable virtualbox driver module
