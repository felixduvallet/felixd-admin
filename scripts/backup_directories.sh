#!/bin/bash

# Backup multiple directories into individual archives.
#
# NOTE: requires 'pv' tool for progress bar.

dirs_to_backup="/bin /boot /dev /etc /home /lib /lib32 /lib64 /opt /run /sbin /scratch /srv /sys /usr /var"
backup_location="/data/"

#for dir in "/bin" "/boot"
for dir in $dirs_to_backup
do
    echo "== Backing up ${dir} =="
    base=$(basename "$dir")
    ionice -c 3 nice tar cf - "$dir" -P | pv -s $(du -sb "$dir" | awk '{print $1}') | ionice -c 3 nice gzip > "$backup_location/${base}.tar.gz"
done
