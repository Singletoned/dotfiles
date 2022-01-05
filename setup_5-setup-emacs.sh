#!/bin/zsh

set -e

cd ~

if [ ! -d ~/.emacs.d ]; then
    git clone git@github.com:Singletoned/emacs.d.git ~/.emacs.d
fi
