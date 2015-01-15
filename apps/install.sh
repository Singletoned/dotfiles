#!/bin/sh
#

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

rm ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s $DOTFILES_ROOT/apps/iTerm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
rm ~/Library/Preferences/org.pqrs.Karabiner.plist
ln -s $DOTFILES_ROOT/apps/Karabiner/org.pqrs.Karabiner.plist ~/Library/Preferences/org.pqrs.Karabiner.plist
