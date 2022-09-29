#-------------------------------------------------
# Specific configurations for logitech devices such as mices and keyboards
#-------------------------------------------------


# Solaar: Logitech devices manager
    install_package solaar
    # Link configuration
        create_link components/hardware-specific/logitech-mouse-keyboard/config/solaar ${USER_HOME}/.config

