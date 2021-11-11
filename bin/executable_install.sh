#!/bin/sh
#

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

if [ ! -d ~/.envs ]; then
    mkdir ~/.envs
fi

export PIP_REQUIRE_VIRTUALENV=false
export VIRTUALENVWRAPPER_PYTHON=python3

pip3 install pip virtualenv setuptools
pip3 install virtualenvwrapper
source virtualenvwrapper.sh
if [ ! -d ~/.envs/default ]; then
    mkvirtualenv default
fi
workon default

pip install ipython

if [ ! -d ~/.envs/emacs ]; then
    mkvirtualenv emacs
    workon emacs
    pip install black flake8 isort
fi

