# For homebrew
autoload run-help
export HELPDIR=/usr/local/share/zsh/help
export FPATH=/usr/local/share/zsh/functions:/usr/local/share/zsh/site-functions:$FPATH

source .antigen/antigen.zsh

antigen use oh-my-zsh

 antigen bundle zsh-users/zsh-syntax-highlighting
 antigen bundle zsh-users/zsh-history-substring-search

 antigen bundle vi-mode
 antigen bundle git
# antigen bundle git-prompt
 antigen bundle cabal
 antigen bundle mercurial
 antigen bundle pip
 antigen bundle brew
 antigen bundle fasd
 antigen bundle python
 antigen bundle ruby
 antigen bundle scala
 antigen bundle tmux
 antigen bundle vagrant
 antigen bundle emacs

# Locale
#
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

antigen theme robbyrussell

antigen apply

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


# User configuration
export MYBREW=/usr/local

#use vim as default editor
export EDITOR=$MYBREW/bin/vim

# export correct term for tmux
if [[ -n "$TMUX" ]]; then
    export TERM="screen-256color"
else
    export TERM="xterm-256color"
fi
export TERM="xterm-256color"

alias ll="ls -l"
alias ..="cd .."
alias latexmk='latexmk -pdf -pvc'
alias vlc='open -a $HOME/Applications/VLC.app/Contents/MacOS/VLC'
# haskell tags
alias htags='find . -name \*.\*hs | xargs hasktags -c'
alias vag='cd ~/source/vagrant && vagrant ssh'

export PATH=$MYBREW/bin:$MYBREW/sbin:$PATH
export C_INCLUDE_PATH=$MYBREW/include:$MYBREW/usr/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$MYBREW/include:$MYBREW/usr/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=$MYBREW/lib:$MYBREW/usr/lib
export LD_LIBRARY_PATH=$MYBREW/lib:$MYBREW/usr/lib
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$MYBREW/lib/pkgconfig:$MYBREW/Library/ENV/pkgconfig/10.8
#export PYTHONPATH=$MYBREW/lib/python2.7/site-packages:$MYBREW/lib/python3.3/site-packages:$PYTHONPATH
export LDFLAGS="-L/usr/local/lib -L/usr/local/usr/lib"

# Add ocaml stuff to the path, and other ocaml constants
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval `opam config env`

# Add cabal to path
export PATH="$PATH:$HOME/.cabal/bin"
#
# Add postgres to path
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin"

# Add texbin to path
export PATH="$PATH:/usr/texbin"

# for homebrew
if [ -r ~/.notpublic ]
then
    source ~/.notpublic
fi

# readline is shadowed by BSD libedit. Have its place handy:
export READLINE_LIB=$MYBREW/Cellar/readline/6.3.8/lib
export READLINE_INCLUDE=$MYBREW/Cellar/readline/6.3.8/include
# command line needed to install readline with cabal
alias cabal_readline_add='cabal install readline --extra-include-dirs=$READLINE_INCLUDE --extra-lib-dirs=$READLINE_LIB --configure-option=--with-readline-includes=$READLINE_INCLUDE --configure-option=--with-readline-libraries=$READLINE_LIB'

# command for GDK recognizing stuff
alias gdk_pixbuf_cache='env GDK_PIXBUF_MODULEDIR=$MYBREW/lib/gdk-pixbuf-2.0/2.10.0/loaders gdk-pixbuf-query-loaders --update-cache'



export DOCKER_HOST=tcp://192.168.59.103:2375

# for GO
export GOPATH=$HOME/gocode

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
