#-------------------------------------------------
# Base system configuration
#-------------------------------------------------


# Synchronize clock with NTP time servers
    install_package ntp
    sudo systemctl enable ntpd.service
