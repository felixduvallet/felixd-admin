# -*- shell-script -*-

#############
## Aliases ##
#############

# Convenience & typo aliases
alias lh='ls -lhF'
alias llh='ls -lhF'
alias sl=ls
alias lks=ls
alias les=less

# Show largest (by size in MB) 10 files, sorted.
alias dums='du -cms * | sort -rn | head'

# Ping 8.8.8.8, a known DNS server.
alias p8='ping 8.8.8.8'

# Run GDB directly with arguments: call gdba ./command --with --params
alias gdba='gdb --args'

# Kill job 1, 2, etc..
alias k1='kill %1'
alias k2='kill %2'
alias k3='kill %3'
# kk = really kill
alias kk1='kill -9 %1'
alias kk2='kill -9 %2'
alias kk3='kill -9 %3'

# Get fullpath to a file
alias fullpath='readlink -f'

# xclip: copy text to clipboard
alias xclip='xclip -selection c'

# QIV - quick image viewer (for current directory)
alias q.='qiv .'

# cd to the 'latest' current directory. Note that this *must* be an alias (not a
# script) since a script would execute in its own shell.
alias cdcurrent='cd -P ~/currentdir'
makecurrent() {
    # Remove old currentdir
    if [ -d ~/currentdir ]
    then
        rm -v ~/currentdir
    fi

    # Alias new directory
    ln -sv `pwd` ~/currentdir
}

#############
## Options ##
#############

# Tab completion without filling in the first option.
setopt noautomenu

# hostname: useful for many things
export HOSTNAME

# Set all localization settings across the board.
export LC_ALL="en_US.UTF-8"

# Make less search case insensitively (-I), and display colors (-R)
export LESS="-M -I -R"

# Make grep colorized
export GREP_OPTIONS='--color=auto'

# Editor settings
export EDITOR=emacs
export GIT_EDITOR='emacs -nw -q'
export ALTERNATE_EDITOR=nano

# For homebrew, export a github API token to prevent rate-limiting on
# searches. See https://github.com/settings/applications
#export HOMEBREW_GITHUB_API_TOKEN=fill_me_in

##########
## Path ##
##########

# Export the pythonpath to be (at least) the empty string, which adds
# the current directory to PYTHONPATH (yes, this is weird).
export PYTHONPATH=$PYTHONPATH:""

# Enable ccache by prepending its directory to the path: ccache will get called
# instead of the compiler.
export PATH=/usr/lib/ccache:$PATH
export CCACHE_CPP2=true
# Tell ccache to ignore __DATE__ and __TIME__ macros.
export CCACHE_SLOPPINESS=time_macros

# Enable distcc for faster network compilation [disabled for now]
## export CCACHE_PREFIX="distcc"

# NINJA header:
## percent_done [num_finished/num_running/num_left] elapsed_time, jobs-per-second.
export NINJA_STATUS="%p [%f/%r/%u] %e %c | "

# Add scripts to path.
export PATH=$PATH:$HOME/scripts

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# ROS
ROS_ROOT=/opt/ros/indigo/
ROS_SETUP=$ROS_ROOT/setup.zsh

if [ -f $ROS_SETUP ]
then
    source $ROS_SETUP
fi

###############
## OSX stuff ##
###############

if [[ "$OSTYPE" = darwin* ]]; then

    # Use GNU find instead of apple find
    alias find=gfind

    # LaTeX binaries (pdflatex, etc...) for compiling latex documents.
    export PATH=$PATH:/usr/local/texlive/2012/bin/x86_64-darwin/
fi

####################
## Handy Function ##
####################

###   Handy Extract Program
# From http://www.shell-fu.org/lister.php?id=375
extract () {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xvjf "$1"        ;;
            *.tar.gz)    tar xvzf "$1"     ;;
            *.bz2)       bunzip2 "$1"       ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xvf "$1"        ;;
            *.tbz2)      tar xvjf "$1"      ;;
            *.tgz)       tar xvzf "$1"       ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Delete all *~ temporary files.
rmtmp() {
    find . -type f -name "*~" -exec rm -v -- {} +
}

# move 'upto' any parent directory matching the provided string. Works with tab completion.
#
# Shamelessly nabbed from:
# http://unix.stackexchange.com/questions/14303/bash-cd-up-until-in-certain-folder
# with zsh modifications from:
# https://stackoverflow.com/questions/35374305/how-can-you-convert-this-bash-completion-function-to-a-zsh-completion-function/
upto () {
    if [ -z "$1" ]; then
        return
    fi
    local upto=$1
    cd "${PWD/\/$upto\/*//$upto}"
}

_upto() {
    local parents;
    parents=(${(s:/:)PWD});
    compadd -V 'Parent Dirs' -- "${(Oa)parents[@]}";
}
compdef _upto upto
