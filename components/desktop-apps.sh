#-------------------------------------------------
# Install various desktop programs with GUI
#-------------------------------------------------


# Web browser and flash extension
    ${INSTALL} google-chrome
# Media player
    ${INSTALL} vlc
    # vlc dependency to have a GUI
        ${INSTALL} qt4
# Disks management (useful for S.M.A.R.T. tests)
    ${INSTALL} gnome-disk-utility
# Image viewer
    ${INSTALL} feh
# PDF viewer
    ${INSTALL} evince
# Music streaming
    ${INSTALL} spotify
# Budget manager
    ${INSTALL} homebank
# Skype
    ${INSTALL} ghetto-skype
