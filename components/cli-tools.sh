#-------------------------------------------------
# Command line tools
#-------------------------------------------------

## Text editor
install_package neovim
# Install LazyVim distribution
git clone https://github.com/LazyVim/starter ${USER_HOME}/.config/nvim
sudo git clone https://github.com/LazyVim/starter ${ROOT_HOME}/.config/nvim
create_homedir_link ${DOTFILES_SOURCE}/homedir/.config/nvim/lua .config/nvim

# Files management
install_package rsync
install_package rmlint # Delete duplicates files
install_package wget
install_package zip unzip
install_package unrar

# Monitoring and discovery
install_package nmap    # Network discovery tool
install_package lsof    # List open files by given process
install_package bashtop # System monitor tool

# Filesystem stuff
install_package jmtpfs  # Android metia transfert protocol filesystem
install_package ntfs-3g # NTFS filesystem
install_package sshfs   # Mount distant directories over ssh

install_package udiskie # Auto-mounting media disks daemon
create_finalize_startup_entry "Auto mount connected USB devices" "udiskie -s &"

# Misc
install_package git
install_package openssh
install_package xclip # Access X clipboard from shell
install_package lsd   # ls improved
