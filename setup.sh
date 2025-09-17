#!/usr/bin/env sh

git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone --depth 1 https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
cd $HOME
ln -s dotfiles/agignore .agignore
ln -s dotfiles/ocamlinit .ocamlinit
ln -s dotfiles/tmux_linux.conf .tmux.conf
ln -s dotfiles/zshrc .zshrc
ln -s dotfiles/nvim2 $HOME/.config/nvim
