#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

git clone --depth 1 https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
git clone --depth 1 https://github.com/tarjoilija/zgen.git "$HOME/.zgen"
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
~/.fzf/install
ln -s $SCRIPT_DIR/agignore $HOME/.agignore
ln -s $SCRIPT_DIR/ocamlinit $HOME/.ocamlinit
ln -s $SCRIPT_DIR/tmux_linux.conf $HOME/.tmux.conf
ln -s $SCRIPT_DIR/zshrc $HOME/.zshrc
mkdir -p $HOME/.config
ln -s $SCRIPT_DIR/nvim2 $HOME/.config/nvim

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to bashrc
BASHRC="$HOME/.bashrc"

BREW_LINE='BREW=/home/linuxbrew/.linuxbrew/bin/brew'
EVAL_LINE='[[ -f $BREW ]] && eval $($BREW shellenv)'

# Append only if not already present
grep -qxF "$BREW_LINE" "$BASHRC" || echo "$BREW_LINE" >>"$BASHRC"
grep -qxF "$EVAL_LINE" "$BASHRC" || echo "$EVAL_LINE" >>"$BASHRC"

bash
