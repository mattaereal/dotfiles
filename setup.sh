#!/bin/bash

# zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -s ~/.dotfiles/zshrc ~/.zshrc

ln -s ~/.dotfiles/mattlips.zsh-theme ~/.oh-my-zsh/themes/
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# vim
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

# git
ln -s ~/.dotfiles/gitconfig ~/.gitconfig

# tmux post installation
# tmux source ~/.tmux.consf
# And prefix + I to fetch plugins.