#!/bin/bash

# local language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# files
alias vigitignore="vi ~/.gitignore"
alias vizshrc="vi ~/.zshrc && source $SHELLRC"
alias vitmuxconf="vi ~/.tmux.conf && tmux source ~/.tmux.conf"
alias vimk="vi $NEEDLE_HOME/custom/monkey.md"
alias vitodo="vi $NEEDLE_HOME/custom/todo.md"

# directories
alias cddotfile="cd $NEEDLE_HOME"
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.5.0/bin:$PATH"
