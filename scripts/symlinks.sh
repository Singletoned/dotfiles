#!/bin/zsh

if [ ! -d ~/cloud ]; then
    ln -s "/Users/singletoned/Library/Mobile Documents/com~apple~CloudDocs" ~/cloud
fi
if [ ! -d ~/src ]; then
    ln -s "/Users/singletoned/Library/Mobile Documents/com~apple~CloudDocs/src" ~/src
fi
