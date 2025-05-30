PS1="\h:\W\$ "

#use vim as default editor
export EDITOR=$(brew --prefix)/bin/vim

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
alias ugrad='ssh ybarnoy1@ugrad1.cs.jhu.edu'
alias scpu='scp $1 ybarnoy1@usgrad1.cs.jhu.edu:$2'
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

# Make colors nice in bash
export CLICOLOR=1
# dir symlink socket pipe exec blockSpecial charSp execWSetuid execWsetGid DirWritableSticky DirWritableNoSticky
export LSCOLORS=gxfxcxdxbxegedabagacad

# Add ocaml stuff to the path, and other ocaml constants
#eval `opam config -env`
. /Users/yotambarnoy/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Add Cabal to path
# export PATH=~/Library/Haskell/bin:~/.cabal/bin:~/Library/Haskell/ghc-7.6.3/lib/cabal-install-1.18.0.2/bin:$PATH

# Make command line history ignore some things, like starting with space and plain ls
export HISTIGNORE="ls:[bf]g:exit:ll"
export HISTCONTROL="erasedups:ignorespace"

# Add tex to path
# Use tlmgr to manage tex stuff
# export PATH="/usr/texbin:$PATH"

# Add postgres to path
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

# for homebrew
if [ -r ~/.notpublic ]
then
    source ~/.notpublic
fi

# readline is shadowed by BSD libedit. Have its place handy:
export READLINE_LIB=$BREW/Cellar/readline/6.3.8/lib
export READLINE_INCLUDE=$BREW/Cellar/readline/6.3.8/include
# command line needed to install readline with cabal
export CABAL_READLINE_ADD="cabal install readline --extra-include-dirs=$READLINE_INCLUDE --extra-lib-dirs=$READLINE_LIB --configure-option=--with-readline-includes=$READLINE_INCLUDE --configure-option=--with-readline-libraries=$READLINE_LIB"

# completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# required for docker?
export DOCKER_HOST=tcp://192.168.59.103:2375

# fasd awesomeness for quick access to files/dirs
# eval "$(fasd --init auto)" # slower
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
alias v='f -e vim' # quickly open file with vim
alias e='f -e emacs' # quickly open file with emacs
_fasd_bash_hook_cmd_complete v e
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias fixwway='sudo mkdir -p /run/user/1000/ && sudo ln -s /mnt/wslg/runtime-dir/wayland-0* /run/user/1000/'

BREW=/home/linuxbrew/.linuxbrew/bin/brew
[[ -f $BREW ]] && eval $($BREW shellenv)

