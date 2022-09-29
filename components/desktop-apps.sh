#-------------------------------------------------
# Install various desktop programs with GUI
#-------------------------------------------------


# Web browsers
    install_package brave-browser
# Media player
    install_package vlc
# Disks management (useful for S.M.A.R.T. tests)
    install_package gnome-disk-utility
# Image viewer
    install_package sxiv
# PDF viewer
    install_package evince
# Music streaming
    install_package spotify
    create_manual_todo 'Music streaming' 'Log in with Spotify account in app "Spotify"'
# Budget manager
    install_package homebank
# Skype
    install_package skypeforlinux-stable-bin
    create_manual_todo 'Skype' 'Log in with Skype account in app "Skype"'
# Transmission (torrenting) daemon (and CLI and web-UI)
    install_package transmission-cli transmission-remote-gtk
