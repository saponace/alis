#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Terminal emulator
    install_package alacritty
    create_link components/terminal-and-shell/config/alacritty ${USER_HOME}/.config
    create_link components/terminal-and-shell/config/alacritty ${ROOT_HOME}/.config

# Shell
    install_package zsh
# Set default shell
    # For the user
        sudo chsh -s /bin/zsh ${USER}
    # For root
        sudo chsh -s /bin/zsh root
   # Link configuration files
      create_link ${DOTFILES_SOURCE}/homedir/.zshrc ${USER_HOME}
      create_link ${DOTFILES_SOURCE}/homedir/.zshrc ${ROOT_HOME}
      create_link ${DOTFILES_SOURCE}/homedir/.config/zsh ${USER_HOME}/.config
      create_link ${DOTFILES_SOURCE}/homedir/.config/zsh ${ROOT_HOME}/.config

# ls improved
   install_package lsd
# Terminal multiplexer
    install_package tmux
    # Link configuration files
       create_link ${DOTFILES_SOURCE}/homedir/.tmux.conf ${USER_HOME}
       create_link ${DOTFILES_SOURCE}/homedir/.tmux.conf ${ROOT_HOME}
# Neovim, improved vim
    install_package neovim
    # Install LazyVim distribution
      rm -rf ${USER_HOME}/.config/nvim
      git clone https://github.com/LazyVim/starter ${USER_HOME}/.config/nvim
      sudo rm -rf ${ROOT_HOME}/.config/nvim
      sudo git clone https://github.com/LazyVim/starter ${ROOT_HOME}/.config/nvim
      
    # Link configuration files
      create_link ${DOTFILES_SOURCE}/homedir/.config/nvim/lua ${USER_HOME}/.config/nvim
      create_link ${DOTFILES_SOURCE}/homedir/.config/nvim/lua ${ROOT_HOME}/.config/nvim
