#-------------------------------------------------
# Base system configuration
#-------------------------------------------------

# Synchronize clock with NTP time servers
install_package ntp
sudo systemctl enable ntpd.service

# Windows-style international layout with dead keys
create_link components/system/config/.XCompose ${USER_HOME}

# Realtime kernel
create_manual_todo 'System' 'Install realtime kernel with "sudo mhwd-kernel -i _KERNEL_VERSION_". Get version with "mhwd-kernel -l". Kernel used at startup is the latest (realtime or not). Make sure the highest installed kernel version is the realtime one. If not, uninstall other kernels.'
