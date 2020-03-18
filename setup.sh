#!/usr/bin/env sh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
cd $HOME
ln -s dotfiles/agignore .agignore
ln -s dotfiles/ocamlinit .ocamlinit
ln -s dotfiles/tmux_linux.conf .tmux.conf
ln -s dotfiles/zshrc .zshrc
mkdir $HOME/.config/nvim
cd $HOME/.config/nvim
ln -s $HOME/dotfiles/nvimrc init.vim
cd $HOME
