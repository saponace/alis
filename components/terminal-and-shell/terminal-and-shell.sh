#-------------------------------------------------
# Terminal emulator and shell (and tmux)
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

# Terminal multiplexer
install_package tmux
create_homedir_link ${DOTFILES_SOURCE}/homedir/.tmux.conf .

# fzf: fuzzy search in shell history, and files
install_package fzf

# zoxide: better cd
yay zoxide
