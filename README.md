
# Follow these steps to install a new arch linux system

### Set the keyboard layout to French
```
# loadkeys fr
```

### Create partitions
Create swap and root partitions (with fdisk for instance).

If arch is the first OS to be installed on this system, create a boot partition (ESP system) and format it with `mkfs.vfat -F 32 /dev/sdxY`


### Remount archiso with more space to be able to download and install git
```
# mount -o remount,size=2G /run/archiso/cowspace
```

### Install git and clone this repo
```
# pacman -Syy git
# git clone --recursive https://github.com/saponace/alis.git
```

### Install the new system
```
# cd alis
# ./install.sh
```


### Reboot
```
# exit
```
Umount and swapoff partitions
```
# reboot
```

### Configure the new system
Log in as the user, and
```
# cd alis
# ./configure-system.sh
```

The system will reboot into the fresh install.

### Note
All the configs are stored in the editable file ./alis.config
