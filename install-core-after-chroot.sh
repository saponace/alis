#!/bin/bash


# Get the current directory
# Leave this block of code at the very beginning of the script (some
# commands may change the current directory later in this script)
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null


CONFIG_FILE_PATH="${git_repo_path}/alis.config"

if [ ! -f "${CONFIG_FILE_PATH}" ]
then
    echo "Error: config file ${CONFIG_FILE_PATH} not found. Please create this file and try again"
    exit 1
fi
source ${CONFIG_FILE_PATH}



# Set the hostname
    echo  ${hostname} > /etc/hostname

# Set le locales and the keymap
    # Configure locales
        echo -e "\n${locales_to_enable}" >> /etc/locale.gen
        locale-gen
        ln -s ${locale_zone_path} /etc/localtime
        echo "KEYMAP=${keymap}" > /etc/vconsole.conf

# Set the clock
    hwclock --systohc --localtime


# Create ramdisk
    # Configure mkinitcpio
    sed -i 's/^HOOKS=(.*)/HOOKS=(base udev resume autodetect modconf block keyboard keymap encrypt filesystems)/' /etc/mkinitcpio.conf
    mkinitcpio -p linux


# Install and configure boot manager
    # mount boot partition to /boot
        bootctl --path=/boot install
    # Create menu entry
        echo -e "timeout=3\ndefault=arch" > /boot/loader/loader.conf
    # Configure entry
        root_partition_uuid=$(blkid ${root_partition} | cut -f2 -d\")
        swap_partition_uuid=$(blkid ${swap_partition} | cut -f2 -d\")
        echo -e "title  arch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img" > /boot/loader/entries/arch.conf
        echo -e "options cryptdevice=UUID=${root_partition_uuid}:root root=/dev/mapper/root resume=UUID=${swap_partition_uuid} quiet rw" >> /boot/loader/entries/arch.conf


# Set root password
    echo Enter root password:
    passwd root


# Create the user and add him to wheel group (sudoers)
    useradd -m -G wheel -s /bin/bash ${username}
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
    # Set user password
        echo Enter ${username} password:
        passwd ${username}


# Move the git repo into the user's home directory
    mv ${git_repo_path} /home/${username}
    chown -R ${username}:${username} /home/${username}/

