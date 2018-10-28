#!/bin/bash

# local language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# files
alias vipluginshell="vi $NEEDLE_HOME/plugin/shell.plugin.sh && source $SHELLRC"
alias vimk="vi $NEEDLE_HOME/custom/monkey.md"
alias vitodo="vi $NEEDLE_HOME/custom/todo.md"

# directories
alias cddotfile="cd $NEEDLE_HOME"
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
