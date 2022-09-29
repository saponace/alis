#-------------------------------------------------
# Specific configurations for logitech devices such as mices and keyboards
#-------------------------------------------------


# Solaar: Logitech devices manager
    install_package solaar
    create_link components/hardware-specific/logitech-devices/config/solaar ${USER_HOME}/.config
    create_finalize_startup_entry "Solaar (logitech devices manager) tray icon" "solaar --window hide &"
