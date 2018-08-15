#! /bin/bash
#
# Script to quickly get settings installed by creating symlinks in the
# right places to the right things.
#
# Make sure you have the repository checked out, then run this
# script. It will set up the following:
#  - bash dot files
#  - emacs dot file
#  - mercurial and git configs
#  - tmux setting
#  - create aliases for script/ and cron/ directories
#
# Author: Felix Duvallet (felix.duvallet@epfl.ch), April 2015


ADMIN_DIR=`pwd`

if [ ! -d $ADMIN_DIR ]
then
    echo "Check out admin repo first"
    exit
fi

echo "Running script for $ADMIN_DIR..."

## Two functions for creating symlinks iff a file/directory does not already
## exist at that location:
##    LN_*_IF_POSSIBLE SRC DEST
function LN_FILE_IF_POSSIBLE {
    SRC=$1
    DEST=$2
    if [ ! -f $DEST ]
    then
        ln -s $SRC $DEST
        echo "Created $DEST -> $SRC"
    else
        echo "$DEST already exists"
    fi
}

function LN_DIR_IF_POSSIBLE {
    SRC=$1
    DEST=$2
    if [ ! -d $DEST ]
    then
        ln -s $SRC $DEST
        echo "Created $DEST -> $SRC"
    else
        echo "$DEST already exists"
    fi
}

# Bash
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/bash/bashrc.felixd ~/.bashrc
LN_DIR_IF_POSSIBLE $ADMIN_DIR/dot-files/bash/bashrc.d ~/.bashrc.d

# zshell
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/zsh/zshrc ~/.zshrc
LN_DIR_IF_POSSIBLE $ADMIN_DIR/dot-files/zsh/zshrc.d ~/.zshrc.d

# Emacs: .emacs file and .emacs.d directory
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/emacs/emacs ~/.emacs
mkdir -p ~/.emacs.d/
LN_DIR_IF_POSSIBLE $ADMIN_DIR/dot-files/emacs/emacs.d/custom.d ~/.emacs.d/custom.d

# Mercurial, git
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/hg/hgrc ~/.hgrc
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/git/gitconfig ~/.gitconfig

# SSH
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/ssh/config ~/.ssh/config

# LESSFILTER: Additional settings for lesspipe
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/lessfilter ~/.lessfilter

# Tmux
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/tmux/tmux.conf ~/.tmux.conf

## Scripts directory
LN_DIR_IF_POSSIBLE $ADMIN_DIR/scripts ~/scripts

## Cron directory
LN_DIR_IF_POSSIBLE $ADMIN_DIR/cron ~/cron

# ipython: Add a check for the existence of the container directory.
if [ ! -f ~/.config/ipython/profile_default/ ]
then
    mkdir -p ~/.config/ipython/profile_default/
fi

LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/ipython/ipython_config.py ~/.config/ipython/profile_default/ipython_config.py

# xmodmap (key binding settings, may be optional)
LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/xmodmap/xmodmaprc ~/.xmodmaprc

LN_FILE_IF_POSSIBLE $ADMIN_DIR/dot-files/ack-grep/ackrc ~/.ackrc
