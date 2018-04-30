command_exists () {
    type "$1" &> /dev/null ;
}

# get platform
platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Darwin' ]]; then
  platform='osx'
elif [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
fi

# For homebrew
if [[ $platform == 'osx' ]]; then
  autoload run-help
  export HELPDIR=/usr/local/share/zsh/help
  export FPATH=/usr/local/share/zsh/functions:/usr/local/share/zsh/site-functions:$FPATH
  # Locale
  #
  LC_CTYPE=en_US.UTF-8
  LC_ALL=en_US.UTF-8
  export MYBREW='/usr/local'
  if [[ ! -z "$MYBREW" ]]; then
    # use brew vim as default editor
    export EDITOR=$MYBREW/bin/vim

    # homebrew paths
    export PATH=$MYBREW/bin:$MYBREW/sbin:$PATH
    export MANPATH=$MYBREW/share/man:$MANPATH
    export INFOPATH=$MYBREW/share/info:$MANPATH
    export C_INCLUDE_PATH=$MYBREW/include:$MYBREW/usr/include:$C_INCLUDE_PATH
    export CPLUS_INCLUDE_PATH=$MYBREW/include:$MYBREW/usr/include:$CPLUS_INCLUDE_PATH
    export LIBRARY_PATH=$MYBREW/lib:$MYBREW/usr/lib
    export LD_LIBRARY_PATH=$MYBREW/lib:$MYBREW/usr/lib
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$MYBREW/lib/pkgconfig:$MYBREW/Library/ENV/pkgconfig/10.8
    export XDG_RUNTIME_DIR=$HOME/xdg_runtime
    export LDFLAGS="-L$MYBREW/lib -L$MYBREW/usr/lib"
  fi
  # export correct term for tmux
  if [[ -n "$TMUX" ]]; then
      export TERM="screen-256color"
  else
      export TERM="xterm-256color"
  fi

  alias vlc='open -a $HOME/Applications/VLC.app/Contents/MacOS/VLC'
  # Add texbin to path
  [ -d '/usr/texbin/' ] && export PATH="$PATH:/usr/texbin"
fi

# requires antigen be installed
[ -d "${HOME}/.zgen" ] && source "${HOME}/.zgen/zgen.zsh"


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

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Add ocaml stuff to the path, and other ocaml constants
if command_exists opam ; then
  . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  eval `opam config env`
fi

alias ll="ls -l"
alias ..="cd .."
alias latexmk='latexmk -pdf -pvc'
# haskell tags
alias htags='find . -name \*.\*hs | xargs hasktags -c'


# local opam switch (per terminal window)
function opamsw() {
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

# for GO
export GOPATH=$HOME/gocode

# Marcc master connection
marcc_setup () {
  ssh -fNM marcc
}
# Casual connection
marcc () {
  ssh -X marcc
}
# For local python stuff
export PATH="$HOME/.local/bin:$PATH"
# Add usr/bin to path
export PATH="$HOME/usr/bin:$PATH"
# disable context-switch chars
printf "\e[?1004l"
