#-------------------------------------------------
# Display management
#-------------------------------------------------

# Multi-monitor management
    ${INSTALL} xrandr arandr
# Color shifter, reduce blue emission
    ${INSTALL} redshift
    create_link components/display/config/redshift.conf ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
