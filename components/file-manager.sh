#-------------------------------------------------
# Install file managers
#-------------------------------------------------


# Install Nautilus (GUI file explorer)
    install_package nautilus

# Install ranger (file explorer)
    install_package ranger
    # Link configuration files
        create_homedir_link ${DOTFILES_SOURCE}/homedir/.config/ranger .config
    # Install ranger dependencies
        install_package libcaca  # ASCII image preview
        install_package highlight  # Syntax highlight in preview
        install_package mediainfo  # Audio and video files informations
        install_package atool  # See archives content
    # Create ranger empty dotfiles (required)
        ranger --copy-config=all
