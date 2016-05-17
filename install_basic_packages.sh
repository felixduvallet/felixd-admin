#! /bin/bash

# Install many of the 'basic' commonly-used packages.

echo "Installing a bunch of packages, this will require sudo access"

# Things everyone needs
sudo aptitude -v install \
    ack-grep \
    build-essential automake ccache \
    emacs emacs-goodies-el auto-complete-el \
    gnome-do gnome-do-plugins \
    libgsl0-dev gsl-bin \
    mercurial subversion git \
    ntpdate \
    openssh-server \
    pdfshuffler \
    python ipython pep8 pylint pyflakes \
    python-nltk python-scipy python-setuptools python-pip python-yaml python-tk \
    python-nose python-matplotlib python-numpy python-enchant python-mode python-mpmath \
    qiv imagemagick \
    rake \
    libpython-all-dev \
    texlive-binaries texlive-latex-base texlive-latex-extra \
    meld \
    tmux

# NOTE: very slow
sudo aptitude -v install texlive-full
