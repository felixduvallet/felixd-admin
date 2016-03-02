#!/bin/bash

# Simple example of bash option flags:
#  - with unconstrainted argument (-p <string>)
#  - with constrained argument (-a <45|90>, error if other value)
#  - with flag (boolean) argument  (-u)
#
# Taken (with slight modifications) from:
# http://stackoverflow.com/a/16496491/256798

usage() { echo "Usage: $0 [-s <45|90>] [-p <string>] [-u]" 1>&2; exit 1; }

upgrade=0

while getopts ":s:p:u" o; do
    case "${o}" in
        s)
            s=${OPTARG}
            ((s == 45 || s == 90)) || usage
            ;;
        p)
            p=${OPTARG}
            ;;
        u)
            upgrade=1
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ]; then
    usage
fi

echo "s = ${s}"
echo "p = ${p}"
echo "upgrade = ${upgrade}"

if [[ "$upgrade" -eq 1 ]]; then
    echo "Upgrade is true"
else
    echo "upgrade is false"
fi
