PS1="\[\e[0;34m\]\h:\W\$ \[\e[m\]"
#PS1="\h:\W\$ "

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# export PATH

#use vim as default editor
export EDITOR=/usr/bin/vim 

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

# MacPorts Installer addition on 2011-08-31_at_22:24:51: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
export C_INCLUDE_PATH=/opt/local/include
export CPLUS_INCLUDE_PATH=/opt/local/include
export LIBRARY_PATH=/opt/local/lib
export CPPFLAGS="-I/opt/local/include:$CPPFLAGS"
export LDFLAGS="-L/opt/local/lib:$LDFLAGS"

# Finished adapting your PATH environment variable for use with MacPorts.

# Make colors nice in bash
export CLICOLOR=1
# dir symlink socket pipe exec blockSpecial charSp execWSetuid execWsetGid DirWritableSticky DirWritableNoSticky
export LSCOLORS=gxfxcxdxbxegedabagacad

# Export CLASSPATH for java (from macPorts) for Apache commons
export CLASSPATH=.:/opt/local/share/java/commons-cli.jar

# Git command completion
#if [ -f /opt/local/etc/bash_completion ]; then
	#. /opt/local/etc/bash_completion 
#fi

# Add dbtoaster to path
export PATH=~/source/alpha5/bin:$PATH

# Add ocaml stuff to the path, and other ocaml constants
eval `opam config -env`

# Add Cabal to path
export PATH=~/Library/Haskell/bin:~/.cabal/bin:$PATH

# Make command line history ignore some things, like starting with space and plain ls
export HISTIGNORE="ls:[bf]g:exit:ll"
export HISTCONTROL="erasedups:ignorespace"

# PSP Stuff
export PSPDEV="/opt/local/pspdev"
export PSPSDK="$PSPDEV/psp/sdk"
export PSPPATH="$PSPDEV/bin:$PSPDEV/psp/bin:$PSPSDK/bin"
export PATH="$PATH:$PSPPATH"

# Add certain directories to the directory stack
pushd -n /Users/yotambarnoy/source/damsl/ >/dev/null

# Add support for JOCL for Java: OpenCL bindings
JOCLPATH=$HOME/source/jogamp/jocl/dist
export CLASSPATH=$CLASSPATH:$JOCLPATH/jocl.jar:$JOCLPATH/lib/gluegen-rt.jar
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$JOCLPATH/lib

# Add support for OGRE3d
export OGRE_HOME=$HOME/tools/ogre-1.8

