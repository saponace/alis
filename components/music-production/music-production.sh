#-------------------------------------------------
# Music production
#-------------------------------------------------

# Digital audio workstation
install_package bitwig-studio
create_manual_todo 'Music production' 'Log in with Bitwig account in app "Bitwig Studio"'

sudo usermod -a -G audio ${USERNAME} # Add user to audio group

sudo cp components/music-production/config/10-ableton-push.rules /etc/udev/rules.d/ # Give user write permission on Ableton push 2 USB device
