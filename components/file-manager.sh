#-------------------------------------------------
# Install file managers
#-------------------------------------------------


# Install Nautilus (GUI file explorer)
    ${INSTALL} nautilus

# Install ranger (file explorer)
    ${INSTALL} ranger
    # Link configuration files
       create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/ranger ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
       create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/ranger ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config
    # Install ranger dependencies
        ${INSTALL} libcaca  # ASCII image preview
        ${INSTALL} highlight  # Syntax highlight in preview
        ${INSTALL} mediainfo  # Audio and video files informations
        ${INSTALL} atool  # See archives content
    # Create ranger empty dotfiles (required)
        ranger --copy-config=all
