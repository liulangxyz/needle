#!/bin/bash

########################################
# utilities
########################################
# discard all changes including added new files
gd() {
  git add .
  git commit --no-verify -m "dump" 1>/dev/null 2>&1
  git reset --hard HEAD^ 1>/dev/null 2>&1
}

# discard -> update -> prune
gu() {
  gd && git pull && git remote prune origin
}

# get git branch name by using fzf
fgb() {
  git for-each-ref --format="%(refname:lstrip=2)" "refs/heads" | fzf -m
}

# checkout branch by using fzf
fgc() {
  git checkout $(fgb)
}

# delete branch(es) by using fzf
fgbd() {
  git branch -D $(fgb)
}

########################################
# settings
########################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# direnv
eval "$(direnv hook zsh)"

# pip
export PIP_CONFIG_FILE=~/.pip.conf

# pipenv, creates virtualenv inside project directory
export PIPENV_VENV_IN_PROJECT=1

# jdk
export JAVA_HOME=`/usr/libexec/java_home`

# rbenv
eval "$(rbenv init -)"

# n, a node version manager
export N_PREFIX=~/.config

########################################
# alias
########################################
# files
alias vineedle="vi ~/.needle/init.sh && source ~/.zshrc"
alias vizshrc="vi ~/.zshrc && source ~/.zshrc"
alias vitmux="vi ~/.tmux.conf && tmux source ~/.tmux.conf"

# directories
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

########################################
# load custom plugins
########################################
for plugin in $(find ~/.needle/custom -name "*.plugin.sh" -print | sort); do
  source "$plugin"
done
