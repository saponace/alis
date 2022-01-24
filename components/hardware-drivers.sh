#-------------------------------------------------
# Install hardware drivers
#-------------------------------------------------


# Video drivers
    # TODO: Check if xf86-video-vesa is reauired, and if other open source drivers should be installed on a
    # per-target-hardware basis
    install_package mesa xf86-video-vesa
