#-------------------------------------------------
# Install fonts, GTK theme, and set them
#-------------------------------------------------


# Install fonts
    ${INSTALL} inconsolata-g     # Default font
    ${INSTALL} ttf-dejavu     # Fallback font

# Install arc gtk theme
    ${INSTALL} arc-gtk-theme
    # Tell GTK to use arc theme
        create_link ${ADDITIONAL_CONFIG_FILES_DIR}/gtk-theme/settings.ini /usr/share/gtk-3.0/
