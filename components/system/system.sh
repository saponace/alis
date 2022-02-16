#-------------------------------------------------
# Base system configuration
#-------------------------------------------------


# Synchronize clock with NTP time servers
    install_package ntp
    sudo systemctl enable ntpd.service


# Windows-style international keyboard dead keys
    create_link components/system/config/.XCompose ${USER_HOMEDIR_DOTFILES_DESTINATION}
