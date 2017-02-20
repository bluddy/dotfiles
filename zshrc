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
autoload run-help
export HELPDIR=/usr/local/share/zsh/help
export FPATH=/usr/local/share/zsh/functions:/usr/local/share/zsh/site-functions:$FPATH

# requires antigen be installed
[ -d "${HOME}/.zgen" ] && source "${HOME}/.zgen/zgen.zsh"

# Locale
#
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# User configuration

if [[ $platform == 'linux' ]] && [[ -d "~/.linuxbrew" ]]; then
  export MYBREW="~/.linuxbrew"
elif [[ $platform == 'osx' ]]; then
  export MYBREW='/usr/local'
fi
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

alias ll="ls -l"
alias ..="cd .."
alias latexmk='latexmk -pdf -pvc'
alias vlc='open -a $HOME/Applications/VLC.app/Contents/MacOS/VLC'
# haskell tags
alias htags='find . -name \*.\*hs | xargs hasktags -c'
alias vag='cd ~/source/vagrant && vagrant ssh'

# Add ocaml stuff to the path, and other ocaml constants
if command_exists opam ; then
  . $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  eval `opam config env`
fi

# local opam switch (per terminal window)
function opamsw {
  eval $(opam config env --switch $1)
}

# Add cabal to path
[ -d "$HOME/.cabal" ] && export PATH="$PATH:$HOME/.cabal/bin"
# Add texbin to path
[ -d '/usr/texbin/' ] && export PATH="$PATH:/usr/texbin"
# private homebrew github token
[ -r ~/.notpublic ] && source ~/.notpublic

# --- Temporary stuff ---

# readline is shadowed by BSD libedit. Have its place handy:
export READLINE_LIB=$MYBREW/Cellar/readline/6.3.8/lib
export READLINE_INCLUDE=$MYBREW/Cellar/readline/6.3.8/include
# command line needed to install readline with cabal
alias cabal_readline_add='cabal install readline --extra-include-dirs=$READLINE_INCLUDE --extra-lib-dirs=$READLINE_LIB --configure-option=--with-readline-includes=$READLINE_INCLUDE --configure-option=--with-readline-libraries=$READLINE_LIB'

# command for GDK recognizing stuff
alias gdk_pixbuf_cache='env GDK_PIXBUF_MODULEDIR=$MYBREW/lib/gdk-pixbuf-2.0/2.10.0/loaders gdk-pixbuf-query-loaders --update-cache'
export DOCKER_HOST=tcp://192.168.59.103:2375
# tlmgr search for file
alias stlmgr='tlmgr search --global --all'

# for GO
export GOPATH=$HOME/gocode
