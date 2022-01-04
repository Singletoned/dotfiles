#!/bin/sh
#

set -o errexit
set -o nounset

if [ ! -d ~/.envs ]; then
    mkdir ~/.envs
fi

export PIP_REQUIRE_VIRTUALENV=false
export VIRTUALENVWRAPPER_PYTHON=python3

python3 -m pip install --upgrade pip virtualenv setuptools
python3 -m pip install --upgrade virtualenvwrapper

source virtualenvwrapper.sh
if [ ! -d ~/.envs/default ]; then
    mkvirtualenv default
fi
workon default

python3 -m pip install --upgrade ipython

if [ ! -d ~/.envs/emacs ]; then
    mkvirtualenv emacs
    workon emacs
    python3 -m pip install --upgrade black flake8 isort
fi

