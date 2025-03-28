#-------------------------------------------------
# Install hardware drivers
#-------------------------------------------------

# TODO: Check if xf86-video-vesa is required, and if other open source drivers should be installed on a
# per-target-hardware basis
#
# Video drivers
install_package mesa xf86-video-vesa

# Bluetooth
install_package bluez blueman
sudo systemctl enable bluetooth.service
create_finalize_startup_entry "Enable bluetooth" "dbus-update-activation-environment DISPLAY; blueman-applet &"

# Keyboard remap and keybindings
sudo localectl set-x11-keymap us pc105 intl
create_finalize_startup_entry "Keyboard mapping: set keymap to US international (with dead keys, as configured in ~/.XCompose)" "setxkbmap us -variant intl"
create_finalize_startup_entry "Keyboard mapping: Kill (and restart) X11 with Ctrl+Alt+Backspace" "setxkbmap -option terminate:ctrl_alt_bksp"
