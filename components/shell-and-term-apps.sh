#-------------------------------------------------
# Install terminal emulator, shell, and shell utilities
#-------------------------------------------------


# Terminal emulator
    ${INSTALL} xterm
   # Link configuration files
       create_link ${HOMEDIR_DOTFILES_SOURCE}/.Xresources ${USER_HOMEDIR_DOTFILES_DESTINATION}
       create_link ${HOMEDIR_DOTFILES_SOURCE}/.Xresources ${ROOT_HOMEDIR_DOTFILES_DESTINATION}

# Shell
    ${INSTALL} zsh
# Set default shell
    # For the user
        sudo chsh -s /bin/zsh ${USER}
    # For root
        sudo chsh -s /bin/zsh root
   # Link configuration files
      create_link ${HOMEDIR_DOTFILES_SOURCE}/.zshrc ${USER_HOMEDIR_DOTFILES_DESTINATION}
      create_link ${HOMEDIR_DOTFILES_SOURCE}/.zshrc ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
      create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/zsh ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
      create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/zsh ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config

# ls improved
   ${INSTALL} lsd
# Terminal multiplexer
    ${INSTALL} tmux
    # Link configuration files
       create_link ${HOMEDIR_DOTFILES_SOURCE}/.tmux.conf ${USER_HOMEDIR_DOTFILES_DESTINATION}
       create_link ${HOMEDIR_DOTFILES_SOURCE}/.tmux.conf ${ROOT_HOMEDIR_DOTFILES_DESTINATION}
# Text editor
    ${INSTALL} vim
# Neovim, improved version of vim
    ${INSTALL} neovim
    ${INSTALL} python-neovim
    # Ctags, tags index generating. Used by nvim plugin Tagbar
        ${INSTALL} tagbar
   # Link configuration files
      create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/nvim ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
      create_link ${HOMEDIR_DOTFILES_SOURCE}/.config/nvim ${ROOT_HOMEDIR_DOTFILES_DESTINATION}/.config
   # Install nvim plugins
      echo "Installling neovim plugins ..."
      nvim -E +PlugInstall +qall > /dev/null
      echo "Neovim plugins installed !"
