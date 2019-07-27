#-------------------------------------------------
# Install various desktop programs with GUI
#-------------------------------------------------


# Web browsers
    ${INSTALL} google-chrome
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
# Budget manager
    ${INSTALL} homebank
# Skype
    ${INSTALL} skypeforlinux-stable-bin
# Transmission (torrenting) daemon (and CLI and web-UI)
    ${INSTALL} transmission-cli
    transmission-remote-cli --create-config   # Make transmission detect config file

# Link configuration files
    create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/gtk-3.0 ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
    create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/gtk-3.0 ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config

    create_link ${HOMEDIR_DOTFILES_SOURCE}/.gtkrc-2.0 ${USER_HOMEDIR_DOTFILES_DESTINATION}
    create_link ${HOMEDIR_DOTFILES_SOURCE}/.gtkrc-2.0 ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
