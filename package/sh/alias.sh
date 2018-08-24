#!/bin/bash

alias vi="vim"
alias vialias="vi $DOT_HOME/sh/alias.sh"
alias viconfig="vi $DOT_HOME/sh/config.sh"
alias vigitignore="vi ~/.gitignore"

# directory
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# utilities
alias git-push-force="sh $DOT_HOME/sh/git-push-force.sh"
alias git-pulls="sh $DOT_HOME/sh/git-pulls.sh"
