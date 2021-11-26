#-------------------------------------------------
# Install various desktop programs with GUI
#-------------------------------------------------


# Web browsers
    ${INSTALL} google-chrome
# Media player
    ${INSTALL} vlc
# Disks management (useful for S.M.A.R.T. tests)
    ${INSTALL} gnome-disk-utility
# Image viewer
    ${INSTALL} sxiv
# PDF viewer
    ${INSTALL} evince
# Music streaming
    ${INSTALL} spotify
# Budget manager
    ${INSTALL} homebank
# Skype
    ${INSTALL} skypeforlinux-stable-bin
# Transmission (torrenting) daemon (and CLI and web-UI)
    ${INSTALL} transmission-cli
    transmission-remote-cli --create-config   # Make transmission detect config file
