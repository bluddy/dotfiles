PS1="\h:\W\$ "

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
# export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:$PATH
# export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH
# export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.3/lib/python3.3/site-packages:$PATH
# export PYTHONPATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib:$PYTHONPATH
# export PYTHONPATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.3/lib:$PYTHONPATH

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
#export CPPFLAGS="-I/usr/local/include:$CPPFLAGS"
#export LDFLAGS="-L/usr/local/lib:$LDFLAGS"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BREW/lib/pkgconfig:$BREW/Library/ENV/pkgconfig/10.8
export PYTHONPATH=$BREW/lib/python2.7/site-packages:$BREW/lib/python3.3/site-packages:$PYTHONPATH

# Make colors nice in bash
export CLICOLOR=1
# dir symlink socket pipe exec blockSpecial charSp execWSetuid execWsetGid DirWritableSticky DirWritableNoSticky
export LSCOLORS=gxfxcxdxbxegedabagacad

# Git command completion
#if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
#      . /opt/local/etc/profile.d/bash_completion.sh
#fi

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
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"

# for homebrew
export HOMEBREW_GITHUB_API_TOKEN=ea641dcbed2232c563a07a57af55367cd5943077

# completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
