#!/bin/bash
#
# Synchronize a directory to a remote host using rsync. Usage:
#      sync_dir-rsync.sh <source> <remote_path> [exclude_from_file] [log_file]
#
# The exclusion file allows you to specify a list of files to *not* mirror (for
# example large directories which are not useful). Any directory added to the
# exclude list is deleted. /dev/null can be used as an exclude file to have no
# exclusions.
#
# A timeout is in place to handle cases where we have no internet
# connection. Any trailing slashes in the source directory are removed (to copy
# entire directory).
#
# A log file can be specified, /dev/null is the default.
#
# Author: Felix Duvallet, felixd@cmu.edu.
# November 2013.

if [ $# -lt 2 ]
then
    echo "  Must specify source and destination"
    echo " "
    echo "  Usage: sync_dir-rsync.sh <source> <remote_path> [exclude_from_file] [log_file]"
    echo " "
    exit
fi

# Extract source and desination directories. Remove trailing slash from
# potential source directory so that entire directory (not just contents) are
# copied.
SRC_DIR=${1%/}
DEST_DIR=$2

# Set the default timeout to 4 seconds.
TIMEOUT_SEC=4


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


# Log header
echo "" >> $LOG_FILE
echo `date` >> $LOG_FILE

# The actual business (rsync) over ssh. Timeout in case we don't have internet,
# catch all errors. Delete any files that are missing on the source.
rsync -avzl -e ssh --delete --timeout $TIMEOUT_SEC \
    --exclude-from=$EXCLUDE_FROM_FILE --delete-excluded \
    $SRC_DIR $DEST_DIR >> $LOG_FILE 2>&1
