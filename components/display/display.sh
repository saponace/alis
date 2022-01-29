#-------------------------------------------------
# Display management
#-------------------------------------------------

# Multi-monitor layout management
    install_package arandr autorandr

# Color shifter, reduce blue emission
    install_package redshift
    create_link components/display/config/redshift.conf ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
