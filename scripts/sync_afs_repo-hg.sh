#!/bin/bash
# Sync the specified mercurial directory if AFS tokens are available.
# 
# Performs hg pull (probably best to have this be a non-working/mirror
# repository).  This keeps the mirror repository (for redmine, etc...)
# synchronized (when AFS tokens are available).
# 
# A log file can be specified, /dev/null is the default.
#
# Author: Felix Duvallet, felixd@cmu.edu
# October 2010.

# Check number of arguments
if [ $# -lt 1 ] 
then
    echo "  Must specify repository"
    echo " "
    echo "  Usage: sync_afs_repo-hg <repo_dir> [log_file]"
    echo " "
    exit
fi


# Extract repository directory
REPO_DIR=$1

# Log file is optional
if [ $# -gt 1 ] 
then
    LOG_FILE=$2
else
    LOG_FILE=/dev/null
fi


# Only pull if there are AFS tokens.
if [ `tokens | grep -i expires | wc -l` -gt 0 ]
then
    echo "" >> $LOG_FILE
    echo `date` >> $LOG_FILE
    cd $REPO_DIR
    hg pull >> $LOG_FILE 2>&1
fi
