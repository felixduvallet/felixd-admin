#!/bin/bash
#
# Synchronize a directory to cloud storage using clone. Usage:
#   mirror-rclone.sh <source> <remote:path> [exclude_from_file] [log_file]
#
# rclone must exist somewhere in the path (e.g., /usr/local/bin) and have the
# remote host configured (e.g., Dropbox), see http://rclone.org/ for information
# on installation and configuring remotes.
#
# The exclusion file allows you to specify a list of directories/files to *not*
# mirror (for example build directories which are not useful). The exclusion
# file is optional. Any excluded files are deleted.
# See http://rclone.org/filtering/ for information on filtering rules (it's
# basically like gitignore syntax).
#
# A timeout is in place to handle cases where we have no internet
# connection. Any trailing slashes in the source directory are removed (to copy
# entire directory).
#
# A log file can be specified, /dev/null is the default.
#
# Author: Felix Duvallet, felixd@gmail.com
# Copyright 2013-2015.

if [ $# -lt 2 ]
then
    echo "  Must specify source and destination"
    echo " "
    echo "  Usage: mirror-rclone.sh <source> <remote:path> [exclude_from_file] [log_file]"
    echo " "
    exit
fi

# Extract source and desination directories. Remove trailing slash from
# potential source directory so that entire directory (not just contents) are
# copied.
SRC_DIR=${1%/}
DEST_DIR=$2

# Set the default timeout to 4 seconds.
TIMEOUT_SEC=4s

# Exclude file is optional, use /dev/null by default.
if [ $# -gt 2 ]
then
    EXCLUDE_FROM_FILE=$3
else
    EXCLUDE_FROM_FILE=/dev/null
fi

# Log file is optional, if specified the transaction will be appended.
if [ $# -gt 3 ]
then
    LOG_FILE=$4
else
    LOG_FILE=/dev/null
fi

# Log 'header'
echo "" >> $LOG_FILE
echo `date` >> $LOG_FILE

# The actual business: rclone. Timeout in case we don't have internet,
# catch all errors. Delete any files that are missing on the source.
rclone sync --timeout $TIMEOUT_SEC \
    --exclude-from=$EXCLUDE_FROM_FILE --delete-excluded \
    $SRC_DIR $DEST_DIR --log-file=$LOG_FILE > /dev/null 2>&1

echo "Finished" >> $LOG_FILE
