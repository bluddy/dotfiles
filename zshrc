
command_exists () {
    type "$1" &> /dev/null ;
}

# get platform
platform='linux'

# requires zgen be installed
if [[ -d "${HOME}/.zgen" ]]; then
  source "${HOME}/.zgen/zgen.zsh"
else
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
  source "${HOME}/.zgen/zgen.zsh"
fi

# Locale
#
#LC_CTYPE=en_US.UTF-8
#LC_ALL=en_US.UTF-8

# pick from oh-my-zsh plugins
if command_exists zgen && ! zgen saved; then
  zgen prezto editor key-bindings 'vi'
  zgen prezto prompt theme 'sorin'

  zgen prezto
  zgen prezto environment
  zgen prezto history
  zgen prezto utility
  zgen prezto completion
  zgen prezto archive
  zgen prezto git
  zgen prezto fasd
  zgen prezto homebrew
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search
  #zgen prezto autosuggestions
  zgen prezto prompt

  zgen save

  ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc)
fi

# for massive renaming
autoload -U zmv

# map keys
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word

substring-up-local() {
    zle set-local-history 1
    history-substring-search-up
    zle set-local-history 0
}
zle -N substring-up-local

substring-down-local() {
    zle set-local-history 1
    history-substring-search-down
    zle set-local-history 0
}
zle -N substring-down-local

bindkey -M vicmd 'k' substring-up-local
bindkey -M vicmd 'j' substring-down-local

# Add ocaml stuff to the path, and other ocaml constants
if command_exists opam ; then
  . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  eval `opam config env`
fi

alias ll="ls -l"
alias ..="cd .."
alias latexmk='latexmk -pdf -pvc'
alias lg=lazygit

# local opam switch (per terminal window)
function opamsw() {
  [[ $# < 1 ]] && echo 'Missing switch' && return 1
  eval $(opam config env --switch $1)
}

# shortcut to do opam env update
function opamenv() {
  eval $(opam config env)
}

# Haskell
# Add cabal to path
[ -d "$HOME/.cabal" ] && export PATH="$PATH:$HOME/.cabal/bin"

# tlmgr search for file
alias stlmgr='tlmgr search --global --all'
alias jup="jupyter notebook --Session.key=''"

# for GO
[[ -d $HOME/gocode ]] && export GOPATH=$HOME/gocode

# Marcc master connection
marcc_setup () {
  ssh -fNM marcc
}
# Casual connection
marcc () {
  ssh -X marcc
}

# Cleanup function
cleanup_all () {
  brew upgrade
  brew cleanup -s
}

# Windows shortcuts
export WIN="/mnt/c/"
export WINHOME="$WIN/Users/yotam"

# For SSH forwarding
#export DISPLAY=127.0.0.1:0

# For local python stuff
[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"

[[ -d $HOME/npm/bin ]] && export PATH="$HOME/npm/bin:$PATH"

[[ -d $HOME/.cargo/bin ]] && export PATH="$HOME/.cargo/bin:$PATH"

[[ -d /opt/bin ]] && export PATH=/opt/bin:$PATH

# Add usr/bin to path
export PATH="$HOME/usr/local/bin:$HOME/usr/bin:$PATH"

# google cloud
if [[ -d $HOME/google-cloud-sdk ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# disable context-switch chars
printf "\e[?1004l"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export FZF_DEFAULT_COMMAND='ag -g ""'

# For AMD CPU
#export MKL_DEBUG_CPU_TYPE=5

# set title function
set_title () {
  echo -ne "\033]0;$1\007"
}

# For WSL
if false && grep -qi Microsoft /proc/version; then
  export DISPLAY=$(ip route list default | awk '{print $3}'):0
  export LIBG_ALWAYS_INDIRECT=0
fi

export TERM="tmux-256color"

BREW=/home/linuxbrew/.linuxbrew/bin/brew
[[ -f $BREW ]] && eval "$($BREW shellenv)"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source /opt/imagry/env_vars.sh

# Install carapace with homebrew
command_exists carapace && source <(carapace _carapace zsh)

autoload bashcompinit
bashcompinit
source "/home/imagry/.local/share/bash-completion/completions/am"
