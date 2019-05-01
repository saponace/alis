#!/bin/bash


# Get the current directory
# Leave this block of code at the very beginning of the script (some
# commands may change the current directory later in this script)
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null
    git_repo_dir_name=$(basename ${git_repo_path})


CONFIG_FILE_PATH="${git_repo_path}/alis.config"

if [ ! -f "${CONFIG_FILE_PATH}" ]
then
  echo "Error: config file ${CONFIG_FILE_PATH} not found. Please create this file and try again"
  exit 1
fi
source ${CONFIG_FILE_PATH}

chroot_script_to_call="install-core-after-chroot.sh"



# mkswap swap partition
    mkswap ${swap_partition}


# Set encryption on root partition and open encrypted partition
    echo "Encrypting root partition. Please enter passphrase when prompted."
    cryptsetup --verbose ${root_encryption_options} luksFormat ${root_partition}
    cryptsetup luksOpen ${root_partition} root

# Format root partition
    mkfs.ext4 /dev/mapper/root


# Mount root partition
    mount /dev/mapper/root /mnt
# Mount boot partition
    mkdir /mnt/boot
    mount ${boot_partition} /mnt/boot
# Enable swap
    swapon ${swap_partition}


# Refresh pacman gpg keys list
    pacman-key --refresh-key

# Install base components into new system
    pacstrap /mnt base base-devel

# Generate fstab of new system to automatically mount all the devices at bootup
    genfstab -U -p /mnt >> /mnt/etc/fstab


# Move the git repo into the /root of the new system
    mv ${git_repo_path} /mnt/root/


# Chroot into the new system
    arch-chroot /mnt /root/${git_repo_dir_name}/${chroot_script_to_call}
