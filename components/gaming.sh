#-------------------------------------------------
# Setup gaming environment
#-------------------------------------------------


# Game launcher
    install_package steam

# PS3 controller over bluetooth
    install_package bluez-utils bluez-plugins
    create_manual_todo 'Gaming' 'Pair PS3 controller: in a terminal, run: `bluetoothctl`. Then, in bluetoothctl interactive shell, enter `default-agent`. Finally connect the PS3 controller via USB. bluetoothctl will ask to authorize the device. Enter `yes`. Unplug the controller: It will connect automatically. This will need to be done every time the controller is connected to another host'
