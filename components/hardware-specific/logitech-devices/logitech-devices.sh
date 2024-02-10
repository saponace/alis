#-------------------------------------------------
# Specific configurations for logitech mice and keyboards
#-------------------------------------------------

# Logitech devices manager
install_package solaar
create_finalize_startup_entry "Solaar (logitech devices manager) tray icon" "solaar --window hide &"

cp -r components/hardware-specific/logitech-devices/config/solaar ${USER_HOME}/.config # Copy config instead of link since solaar alters config file
