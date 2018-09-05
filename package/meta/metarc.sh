#!/bin/bash

# local language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias vishrc="vi $DOT_HOME/package/meta/metarc.sh && source $SHELLRC"
alias vimk="vi $DOT_HOME/custom/monkey.md"
alias vitodo="vi $DOT_HOME/custom/todo.md"

# directories
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
