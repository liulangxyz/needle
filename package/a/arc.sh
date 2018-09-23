#!/bin/bash

# local language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# files
alias viarc="vi $DOT_HOME/package/a/arc.sh && source $SHELLRC"
alias vimk="vi $DOT_HOME/custom/monkey.md"
alias vitodo="vi $DOT_HOME/custom/todo.md"

# directories
alias cddotfile="cd $DOT_HOME"
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
