#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Terminal emulator
    install_package xterm

# Shell
    install_package zsh
# Set default shell
    # For the user
        sudo chsh -s /bin/zsh ${USER}
    # For root
        sudo chsh -s /bin/zsh root
   # Link configuration files
      create_link ${DOTFILES_SOURCE}/homedir/.zshrc ${USER_HOMEDIR_DOTFILES_DESTINATION}
      create_link ${DOTFILES_SOURCE}/homedir/.zshrc ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
      create_link ${DOTFILES_SOURCE}/homedir/.config/zsh ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
      create_link ${DOTFILES_SOURCE}/homedir/.config/zsh ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config

# ls improved
   install_package lsd
# Terminal multiplexer
    install_package tmux
    # Link configuration files
       create_link ${DOTFILES_SOURCE}/homedir/.tmux.conf ${USER_HOMEDIR_DOTFILES_DESTINATION}
       create_link ${DOTFILES_SOURCE}/homedir/.tmux.conf ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
# Text editor
    install_package vim
# Neovim, improved version of vim
    install_package neovim
    install_package python-neovim
    # Ctags, tags index generating. Used by nvim plugin Tagbar
        install_package tagbar
   # Link configuration files
      create_link ${DOTFILES_SOURCE}/homedir/.config/nvim ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
      create_link ${DOTFILES_SOURCE}/homedir/.config/nvim ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config
   # Install nvim plugins
      echo "Installling neovim plugins ..."
      nvim -E +PlugInstall +qall > /dev/null
      sudo nvim -E +PlugInstall +qall > /dev/null
      echo "Neovim plugins installed !"
