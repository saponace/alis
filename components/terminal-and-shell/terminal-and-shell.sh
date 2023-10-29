#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Terminal emulator
    install_package alacritty
    create_link components/terminal-and-shell/config/alacritty ${USER_HOME}/.config

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
# Text editor
    install_package vim
# Neovim, improved version of vim
    install_package neovim
    install_package python-neovim
    # Ctags, tags index generating. Used by nvim plugin Tagbar
        install_package ctags
   # Link configuration files
      create_link ${DOTFILES_SOURCE}/homedir/.config/nvim ${USER_HOME}/.config
      create_link ${DOTFILES_SOURCE}/homedir/.config/nvim ${ROOT_HOME}/.config
   # Install nvim plugins
      echo "Installling neovim plugins ..."
      nvim -E +PlugInstall +qall > /dev/null
      sudo nvim -E +PlugInstall +qall > /dev/null
      echo "Neovim plugins installed !"
