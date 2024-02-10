#-------------------------------------------------
# Install fonts, GTK theme, and set them
#-------------------------------------------------

# Fonts
install_package ttf-dejavu
install_package ttf-hack-nerd #icons

# GTK theme
install_package arc-gtk-theme
create_homedir_link components/appearance/config/gtk-3.0 .config
create_homedir_link components/appearance/config/.gtkrc-2.0 .
