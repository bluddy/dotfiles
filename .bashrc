#PS1="\[\e[0;34m\]\h:\W\$ \[\e[m\]"
PS1="\h:\W\$ "

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# export PATH
export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:$PATH
export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH
export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.3/lib/python3.3/site-packages:$PATH
export PYTHONPATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib:$PYTHONPATH
export PYTHONPATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.3/lib:$PYTHONPATH

#use vim as default editor
export EDITOR=/opt/local/bin/vim 

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
alias d='dirs -v'
alias pd=pushd
alias pd2='pushd +2'
alias pd3='pushd +3'
alias pd4='pushd +4'
# haskell tags
alias htags='find . -name \*.\*hs | xargs hasktags -c'

# MacPorts Installer addition on 2011-08-31_at_22:24:51: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin/:usr/local/bin:$PATH
export C_INCLUDE_PATH=/opt/local/include:/usr/local/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=/opt/local/include:/usr/local/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/opt/local/lib:/usr/local/lib
#export CPPFLAGS="-I/opt/local/include:$CPPFLAGS"
#export LDFLAGS="-L/opt/local/lib:$LDFLAGS"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig:/usr/local/Library/ENV/pkgconfig/10.8

# Finished adapting your PATH environment variable for use with MacPorts.

# Make colors nice in bash
export CLICOLOR=1
# dir symlink socket pipe exec blockSpecial charSp execWSetuid execWsetGid DirWritableSticky DirWritableNoSticky
export LSCOLORS=gxfxcxdxbxegedabagacad

# Export CLASSPATH for java (from macPorts) for Apache commons
export CLASSPATH=.:/opt/local/share/java/commons-cli.jar

# Git command completion
#if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
#      . /opt/local/etc/profile.d/bash_completion.sh
#fi

# Add ocaml stuff to the path, and other ocaml constants
#eval `opam config -env`
. /Users/yotambarnoy/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Add Cabal to path
export PATH=~/Library/Haskell/bin:~/.cabal/bin:~/Library/Haskell/ghc-7.6.3/lib/cabal-install-1.18.0.2/bin:$PATH

# Make command line history ignore some things, like starting with space and plain ls
export HISTIGNORE="ls:[bf]g:exit:ll"
export HISTCONTROL="erasedups:ignorespace"

# PSP Stuff
export PSPDEV="/opt/local/pspdev"
export PSPSDK="$PSPDEV/psp/sdk"
export PSPPATH="$PSPDEV/bin:$PSPDEV/psp/bin:$PSPSDK/bin"
export PATH="$PATH:$PSPPATH"

# Add support for JOCL for Java: OpenCL bindings
JOCLPATH=$HOME/source/jogamp/jocl/dist
export CLASSPATH=$CLASSPATH:$JOCLPATH/jocl.jar:$JOCLPATH/lib/gluegen-rt.jar
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$JOCLPATH/lib

# Add support for OGRE3d
export OGRE_HOME=$HOME/tools/ogre-1.8

# Add tex to path
# Use tlmgr to manage tex stuff
# export PATH="/usr/texbin:$PATH"

# Add postgres to path
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"

