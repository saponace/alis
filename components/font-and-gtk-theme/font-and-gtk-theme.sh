#-------------------------------------------------
# Install fonts, GTK theme, and set them
#-------------------------------------------------


# Install fonts
    install_package ttf-dejavu
    install_package ttf-hack-nerd  #icons

# Install arc gtk theme
    install_package arc-gtk-theme

    # Link GTK configuration files
        create_homedir_link components/font-and-gtk-theme/config/gtk-3.0 .config
        create_homedir_link components/font-and-gtk-theme/config/.gtkrc-2.0 .
