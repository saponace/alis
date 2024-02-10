#-------------------------------------------------
# Terminal emulator and shell, and shell utilities
#-------------------------------------------------

# Terminal emulator
install_package alacritty
create_homedir_link components/terminal-and-shell/config/alacritty .config

# Shell
install_package zsh
sudo chsh -s /bin/zsh ${USER} # Set default shelll for user
sudo chsh -s /bin/zsh root    # Set default shelll for root
create_homedir_link ${DOTFILES_SOURCE}/homedir/.zshrc .
create_homedir_link ${DOTFILES_SOURCE}/homedir/.config/zsh .config

install_package lsd # ls improved

# Terminal multiplexer
install_package tmux
create_homedir_link ${DOTFILES_SOURCE}/homedir/.tmux.conf .

## Text editor
install_package neovim
create_homedir_link ${DOTFILES_SOURCE}/homedir/.config/nvim/lua .config/nvim
# Install LazyVim distribution
rm -rf ${USER_HOME}/.config/nvim
git clone https://github.com/LazyVim/starter ${USER_HOME}/.config/nvim
sudo rm -rf ${ROOT_HOME}/.config/nvim
sudo git clone https://github.com/LazyVim/starter ${ROOT_HOME}/.config/nvim
