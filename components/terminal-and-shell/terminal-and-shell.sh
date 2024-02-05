#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Terminal emulator
    install_package alacritty
    create_homedir_link components/terminal-and-shell/config/alacritty .config

# Shell
    install_package zsh
# Set default shell
    # For the user
        sudo chsh -s /bin/zsh ${USER}
    # For root
        sudo chsh -s /bin/zsh root
   # Link configuration files
      create_homedir_link ${DOTFILES_SOURCE}/homedir/.zshrc .
      create_homedir_link ${DOTFILES_SOURCE}/homedir/.config/zsh .config

# ls improved
   install_package lsd
# Terminal multiplexer
    install_package tmux
    # Link configuration files
       create_homedir_link ${DOTFILES_SOURCE}/homedir/.tmux.conf .
# Neovim, improved vim
    install_package neovim
    # Install LazyVim distribution
      rm -rf ${USER_HOME}/.config/nvim
      git clone https://github.com/LazyVim/starter ${USER_HOME}/.config/nvim
      sudo rm -rf ${ROOT_HOME}/.config/nvim
      sudo git clone https://github.com/LazyVim/starter ${ROOT_HOME}/.config/nvim
      
    # Link configuration files
      create_homedir_link ${DOTFILES_SOURCE}/homedir/.config/nvim/lua .config/nvim
