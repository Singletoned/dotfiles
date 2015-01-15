#!/bin/sh
#

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

if [ ! -d ~/.envs ]; then
    mkdir ~/.envs
fi

pip install virtualenvwrapper
source virtualenvwrapper.sh
if [ ! -d ~/.envs/default ]; then
    mkvirtualenv default
fi
workon default
pip install virtualenvwrapper
pip install ipython
