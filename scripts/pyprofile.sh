#!/bin/bash
#
# Profile any python script.  Prints profiler information.  Requires
# cProfile.
#
# Output file will generate a dump, which can be read (and plotted) using
# program runsnakerun:
#   $ runsnake <out.py>
#
# usage: ./profile.sh <file> [out_file]
#
# NOTE: For a unit test, run this instead:
#   python -m cProfile -o out.prof `which nosetests` test_file.py
#
# Author: Felix Duvallet, May 2011.


if [ $# -lt 1 ]
then
    echo "   Usage: ./profile.sh script [out_file]"
    exit
fi

if [ $# -gt 1 ]
then
    echo "Saving profiler output to $2"
    python -m cProfile -o $2 $1
else
    python -m cProfile $1
fi


