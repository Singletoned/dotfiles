#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log
fi

# Install homebrew packages
brew install `cat $DOTFILES_ROOT/homebrew/packages`

brew install caskroom/cask/brew-cask

brew tap caskroom/versions

brew cask install `cat $DOTFILES_ROOT/homebrew/apps`

exit 0
