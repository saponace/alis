#-------------------------------------------------
# Install fonts, GTK theme, and set them
#-------------------------------------------------


# Install fonts
    install_package ttf-dejavu
    # Icons fonts
        install_package otf-font-awesome
        install_package ttf-hack-nerd

# Install arc gtk theme
    install_package arc-gtk-theme

    # Link GTK configuration files
        create_link components/font-and-gtk-theme/config/gtk-3.0 ${USER_HOME}/.config
        create_link components/font-and-gtk-theme/config/gtk-3.0 ${ROOT_HOME}/.config

        create_link components/font-and-gtk-theme/config/.gtkrc-2.0 ${USER_HOME}
        create_link components/font-and-gtk-theme/config/.gtkrc-2.0 ${ROOT_HOME}
