#!/bin/sh
#

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

brew tap caskroom/fonts

brew cask install `cat $DOTFILES_ROOT/fonts/fonts`
