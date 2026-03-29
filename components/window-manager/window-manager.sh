#-------------------------------------------------
# Configure window manager and desktop environment
#-------------------------------------------------

# Window manager
install_package sway swaybg xorg-xwayland
create_link components/window-manager/config/sway ${USER_HOME}/.config

# Deploy wallpaper for swaybg
sudo cp components/window-manager/image/wallpaper.jpg /usr/share/backgrounds/

create_manual_todo 'Desktop session' 'Log into a TTY and start the Wayland session manually with `sway`'
