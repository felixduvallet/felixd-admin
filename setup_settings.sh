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

########################################
# Bash
BASHRC_FILE_SRC=$ADMIN_DIR/dot-files/bash/bashrc.felixd
BASHRC_FILE_DEST=~/.bashrc
if [ ! -f $BASHRC_FILE_DEST ]
then
    ln -s $BASHRC_FILE_SRC $BASHRC_FILE_DEST
    echo "Created $BASHRC_FILE_DEST -> $BASHRC_FILE_SRC"
else
    echo "$BASHRC_FILE_DEST already exists"
fi

BASHRC_D_SRC=$ADMIN_DIR/dot-files/bash/bashrc.d
BASHRC_D_DEST=~/.bashrc.d
if [ ! -d $BASHRC_D_DEST ]
then
    ln -s $BASHRC_D_SRC $BASHRC_D_DEST
    echo "Created $BASHRC_D_DEST -> $BASHRC_D_SRC"
else
    echo "$BASHRC_D_DEST already exists"
fi

########################################
# Emacs: .emacs file and .emacs.d directory
EMACS_SRC=$ADMIN_DIR/dot-files/emacs/emacs
EMACS_DEST=~/.emacs
if [ ! -f $EMACS_DEST ]
then
    ln -s $EMACS_SRC $EMACS_DEST
    echo "Created $EMACS_DEST -> $EMACS_SRC"
else
    echo "$EMACS_DEST already exists"
fi

EMACS_SRC=$ADMIN_DIR/dot-files/emacs/emacs.d
EMACS_DEST=~/.emacs.d
if [ ! -d $EMACS_DEST ]
then
    ln -s $EMACS_SRC $EMACS_DEST
    echo "Created $EMACS_DEST -> $EMACS_SRC"
else
    echo "$EMACS_DEST already exists"
fi


########################################
# Mercurial, git
HG_SRC=$ADMIN_DIR/dot-files/hg/hgrc
HG_DEST=~/.hgrc
if [ ! -f $HG_DEST ]
then
    ln -s $HG_SRC $HG_DEST
    echo "Created $HG_DEST -> $HG_SRC"
else
    echo "$HG_DEST already exists"
fi

GIT_SRC=$ADMIN_DIR/dot-files/git/gitconfig
GIT_DEST=~/.gitconfig
if [ ! -f $GIT_DEST ]
then
    ln -s $GIT_SRC $GIT_DEST
    echo "Created $GIT_DEST -> $GIT_SRC"
else
    echo "$GIT_DEST already exists"
fi

########################################
# SSH
SSH_CONFIG_SRC=$ADMIN_DIR/dot-files/ssh/config
SSH_CONFIG_DEST=~/.ssh/config
if [ ! -f $SSH_CONFIG_DEST ]
then
    ln -s $SSH_CONFIG_SRC $SSH_CONFIG_DEST
    echo "Created $SSH_CONFIG_DEST -> $SSH_CONFIG_SRC"
else
    echo "$SSH_CONFIG_DEST already exists"
fi

########################################
# LESSFILTER: Additional settings for lesspipe
LESSFILTER_CONFIG_SRC=$ADMIN_DIR/dot-files/lessfilter
LESSFILTER_CONFIG_DEST=~/.lessfilter
if [ ! -f $LESSFILTER_CONFIG_DEST ]
then
    ln -s $LESSFILTER_CONFIG_SRC $LESSFILTER_CONFIG_DEST
    echo "Created $LESSFILTER_CONFIG_DEST -> $LESSFILTER_CONFIG_SRC"
else
    echo "$LESSFILTER_CONFIG_DEST already exists"
fi

########################################
# Tmux
TMUX_SRC=$ADMIN_DIR/dot-files/tmux/tmux.conf
TMUX_DEST=~/.tmux.conf
if [ ! -f $TMUX_DEST ]
then
    ln -s $TMUX_SRC $TMUX_DEST
    echo "Created $TMUX_DEST -> $TMUX_SRC"
else
    echo "$TMUX_DEST already exists"
fi
########################################
## Scripts directory
SCRIPTS_SRC=$ADMIN_DIR/scripts
SCRIPTS_DEST=~/scripts
if [ ! -d $SCRIPTS_DEST ]
then
    ln -s $SCRIPTS_SRC $SCRIPTS_DEST
    echo "Created $SCRIPTS_DEST -> $SCRIPTS_SRC"
else
    echo "$SCRIPTS_DEST already exists"
fi

########################################
## Cron directory
CRON_SRC=$ADMIN_DIR/cron
CRON_DEST=~/cron
if [ ! -d $CRON_DEST ]
then
    ln -s $CRON_SRC $CRON_DEST
    echo "Created $CRON_DEST -> $CRON_SRC"
else
    echo "$CRON_DEST already exists"
fi

########################################
# ipython
IPYTHON_SRC=$ADMIN_DIR/dot-files/ipython/ipython_config.py
IPYTHON_DEST=~/.config/ipython/profile_default/
if [ ! -f $IPYTHON_DEST ]
then
    ln -s $IPYTHON_SRC $IPYTHON_DEST
    echo "Created $IPYTHON_DEST -> $IPYTHON_SRC"
else
    echo "$IPYTHON_DEST already exists"
fi
