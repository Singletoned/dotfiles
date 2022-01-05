#!/bin/zsh
#

set -o errexit
set -o nounset

if [ ! -d ~/.envs ]; then
    mkdir ~/.envs

    export PIP_REQUIRE_VIRTUALENV=false
    export VIRTUALENVWRAPPER_PYTHON=python3

    python3 -m pip install --upgrade pip virtualenv setuptools
    python3 -m pip install --upgrade virtualenvwrapper

    source virtualenvwrapper.sh
fi

if [ ! -d ~/.envs/default ]; then
    mkvirtualenv default
    workon default
    python3 -m pip install --upgrade ipython
fi

if [ ! -d ~/.envs/emacs ]; then
    mkvirtualenv emacs
    workon emacs
    python3 -m pip install --upgrade black flake8 isort
fi
