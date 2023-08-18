#!/bin/bash

########################################
# functions
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

# open github repo
vgr() {
  repo=$(git remote -v | head -1 | grep -E ":.*\." -o)
  repo=${repo#:}
  repo=${repo%.}
  open https://github.com/${repo}
}

# compress img
zipimg() {
  for img in $(fzf -m); do
    echo "rename $img to old-$img"
    mv -v $img "old-$img"
    echo "compress $img"
    ffmpeg -i "old-$img" $img
  done
}

########################################
# settings
########################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# pip
export PIP_CONFIG_FILE=~/.pip.conf

# pipenv, creates virtualenv inside project directory
export PIPENV_VENV_IN_PROJECT=1

########################################
# alias
########################################
# git
alias gcm="git checkout master"
alias gcd="git checkout develop"

# files
alias vizshrc="vi ~/.zshrc && source ~/.zshrc"

# directories
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# bins
alias p=pnpm

########################################
# load custom plugins
########################################
for plugin in $(find ~/.needle/custom -name "*.plugin.sh" -print | sort); do
  source "$plugin"
done
