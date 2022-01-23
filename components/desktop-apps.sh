#-------------------------------------------------
# Install various desktop programs with GUI
#-------------------------------------------------


# Web browsers
    ${INSTALL} brave-bin
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
    create_manual_todo 'Music streaming' 'Log in with Spotify account in app "Spotify"'
# Budget manager
    ${INSTALL} homebank
# Skype
    ${INSTALL} skypeforlinux-stable-bin
    create_manual_todo 'Skype' 'Log in with Skype account in app "Skype"'
# Transmission (torrenting) daemon (and CLI and web-UI)
    ${INSTALL} transmission-cli
    transmission-remote-cli --create-config   # Make transmission detect config file
