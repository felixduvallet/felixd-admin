#! /bin/bash

# Install many of the 'basic' commonly-used packages.

echo "Installing a bunch of packages, this will require sudo access"

# Things everyone needs
sudo aptitude -v install \
    ack-grep \
    build-essential \
    emacs \
    gnome-do gnome-do-plugins \
    gsl-bin \
    ipython \
    kdiff3-qt \
    mercurial subversion git \
    ntpdate \
    openssh-server \
    pdfshuffler \
    python-nltk python-scipy python-setuptools python-pip python-yaml pyflakes \
    python-nose python-matplotlib python-numpy python-enchant python-memcache python-mpmath \
    qiv \
    rake \
    libgsl0-dev \
    libpython-all-dev \
    swig \
    texlive-binaries texlive-latex-base texlive-latex-extra \
    tmux

# NOTE: very slow
sudo aptitude -v install texlive-full
