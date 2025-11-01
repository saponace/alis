#-------------------------------------------------
# Misc GUI programs
#-------------------------------------------------

install_package firefox
install_package vlc
install_package gnome-disk-utility # Disks management (useful for S.M.A.R.T. tests)
install_package sxiv               # Image viewer
install_package evince             # PDF viewer
create_manual_todo 'Music streaming' 'Log in with Spotify account in app "Spotify"'
install_package homebank                                 # Budget manager
install_package transmission-cli transmission-remote-gtk # BitTorrent daemon (and CLI and web-UI)

# Screenshots
install_package flameshot
create_finalize_startup_entry "Flameshot (screenshot tool) tray icon" "flameshot &"
