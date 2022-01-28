#-------------------------------------------------
# Install fonts, GTK theme, and set them
#-------------------------------------------------


# Install fonts
    install_package ttf-dejavu
    install_package otf-font-awesome  # Icons

# Install arc gtk theme
    install_package arc-gtk-theme

    # Link GTK configuration files
        create_link components/font-and-gtk-theme/config/gtk-3.0 ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
        create_link components/font-and-gtk-theme/config/gtk-3.0 ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config

        create_link components/font-and-gtk-theme/config/.gtkrc-2.0 ${USER_HOMEDIR_DOTFILES_DESTINATION}
        create_link components/font-and-gtk-theme/config/.gtkrc-2.0 ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
