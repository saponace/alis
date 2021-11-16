# Follow these steps to install a new Manjaro linux system

## Download and install Manjaro-i3

TODO: installation steps

## Install git and clone this repo
```
# pacman -Syy git
# git clone --recursive https://github.com/saponace/alis.git
```

### Execute auto-confguration
```
# cd alis
# ./configure-system.sh
```

The system will reboot into the fresh install.

### Manually finalize configuration of the system
Log in as the user, and follow instructions in the file `~/alis/manual-configuration-instructions.txt`.

This file can then safely be removed.


### Note
All the configs are stored in the editable file ./alis.config
