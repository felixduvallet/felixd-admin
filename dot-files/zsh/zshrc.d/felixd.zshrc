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

##############
## Commands ##
##############

# Go up directories.
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

# Show largest (size) 10 files, sorted.
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

#############
## Options ##
#############

export EDITOR=emacs
export GIT_EDITOR='emacs -nw -q'

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

# Add scripts to path.
export PATH=$PATH:$HOME/scripts

# TODO: lesspipe

# Global aliases: can be used anywhere within a command

###############
## OSX stuff ##
###############

if [[ "$OSTYPE" = darwin* ]]; then

    # Use GNU find instead of apple find
    alias find=gfind

    # LaTeX binaries (pdflatex, etc...) for compiling latex documents.
    export PATH=$PATH:/usr/local/texlive/2012/bin/x86_64-darwin/
fi
