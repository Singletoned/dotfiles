#!/bin/sh
#

set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd)

if [ ! -f ~/Library/Preferences/com.googlecode.iterm2.plist ]; then
   rm ~/Library/Preferences/com.googlecode.iterm2.plist
if
ln -s $DOTFILES_ROOT/apps/iTerm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

if [ ! -f ~/Library/Preferences/org.pqrs.Karabiner.plist ]; then
   rm ~/Library/Preferences/org.pqrs.Karabiner.plist
fi
ln -s $DOTFILES_ROOT/apps/Karabiner/org.pqrs.Karabiner.plist ~/Library/Preferences/org.pqrs.Karabiner.plist
