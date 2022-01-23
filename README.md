# Follow these steps to install a new Manjaro linux system

## Install Manjaro-i3
Boot from a Manjaro-i3 live drive and run the installer.

It is recommended to use BTRFS and enable filesystem encryption


## Install git and clone this repo
```
# pacman -Syy git
# git clone --recursive https://github.com/saponace/alis.git
```


### Execute auto-confguration
Make sure the machine is connected to the internet via a wired connection, and run the following:
```
# cd alis
# ./configure-system.sh HARDWARE
```
Where `HARDWARE` is one of the following:
* `generic` (default value): does not configure anything specific
* `t550`: Thinkpad T550 laptop

The system will reboot into the fresh install.


### Manually finalize configuration of the system
Log in, and follow instructions in the file `~/alis/manual-configuration-instructions.txt`.

This file can then safely be removed.


### Note
All the configs are stored in the editable file ./alis.config
