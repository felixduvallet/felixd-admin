#!/bin/bash

# Backup multiple directories into individual archives.

dirs_to_backup="/bin /boot /sbin"
backup_location="/data/"

#for dir in "/bin" "/boot"
for dir in $dirs_to_backup
do
    echo "== Backing up ${dir} =="
    base=$(basename "$dir")
    tar -czf "$backup_location/${base}.tar.gz" "$dir"
done
