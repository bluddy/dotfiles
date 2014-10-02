# For homebrew
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode brew fasd git-prompt)

# map keys
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word

source $ZSH/oh-my-zsh.sh

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

export BREW=$(brew --prefix)
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
. /Users/yotambarnoy/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Add postgres to path
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"

# for homebrew
export HOMEBREW_GITHUB_API_TOKEN=ea641dcbed2232c563a07a57af55367cd5943077

# readline is shadowed by BSD libedit. Have its place handy:
export READLINE_LIB=$BREW/Cellar/readline/6.3.8/lib
export READLINE_INCLUDE=$BREW/Cellar/readline/6.3.8/include
# command line needed to install readline with cabal
alias cabal_readline_add='cabal install readline --extra-include-dirs=$READLINE_INCLUDE --extra-lib-dirs=$READLINE_LIB --configure-option=--with-readline-includes=$READLINE_INCLUDE --configure-option=--with-readline-libraries=$READLINE_LIB'

export DOCKER_HOST=tcp://192.168.59.103:2375

