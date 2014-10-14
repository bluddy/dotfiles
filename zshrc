# For homebrew
unalias run-help
autoload run-help
export HELPDIR=/usr/local/share/zsh/help
export FPATH=/usr/local/share/zsh/functions:/usr/local/share/zsh/site-functions:$FPATH

source .antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen bundle vi-mode
antigen bundle git
antigen bundle git-prompt
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

antigen theme robbyrussell

antigen apply

# map keys
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# User configuration

#use vim as default editor
export EDITOR=$(brew --prefix)/bin/vim

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
alias vlc='open -a /Applications/VLC.app/Contents/MacOS/VLC'
# haskell tags
alias htags='find . -name \*.\*hs | xargs hasktags -c'
alias vag='cd ~/source/vagrant && vagrant ssh'

export PATH=$BREW/bin:$BREW/sbin:$PATH
export C_INCLUDE_PATH=$BREW/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$BREW/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=$BREW/lib
export LD_LIBRARY_PATH=$BREW/lib
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BREW/lib/pkgconfig:$BREW/Library/ENV/pkgconfig/10.8
export PYTHONPATH=$BREW/lib/python2.7/site-packages:$BREW/lib/python3.3/site-packages:$PYTHONPATH
export LDFLAGS="-L/usr/local/lib"

# Add ocaml stuff to the path, and other ocaml constants
#eval `opam config -env`
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Add cabal to path
export PATH="$PATH:$HOME/.cabal/bin"
#
# Add postgres to path
export PATH="$PATH:/Applications/Postgres93.app/Contents/MacOS/bin"

# for homebrew
export HOMEBREW_GITHUB_API_TOKEN=ea641dcbed2232c563a07a57af55367cd5943077

# readline is shadowed by BSD libedit. Have its place handy:
export READLINE_LIB=$BREW/Cellar/readline/6.3.8/lib
export READLINE_INCLUDE=$BREW/Cellar/readline/6.3.8/include
# command line needed to install readline with cabal
alias cabal_readline_add='cabal install readline --extra-include-dirs=$READLINE_INCLUDE --extra-lib-dirs=$READLINE_LIB --configure-option=--with-readline-includes=$READLINE_INCLUDE --configure-option=--with-readline-libraries=$READLINE_LIB'

export DOCKER_HOST=tcp://192.168.59.103:2375

# for GO
export GOPATH=$HOME/gocode

