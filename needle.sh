#!/bin/bash

########################################
# utilities
########################################
# discard all changes including added new files
git_discard() {
  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 3); do
    git checkout -- "$f"
  done

  for f in $(git status -s | grep -E "\?\?" | cut -d ' ' -f 2); do
    rm -rf -- "$f"
  done
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

# load node version manager
loadnvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

########################################
# settings
########################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# add needle bin
export PATH=$PATH:~/.needle/bin

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# direnv
eval "$(direnv hook zsh)"

########################################
# alias
########################################
# files
alias vineedle="vi ~/.needle/needle.sh && source ~/.zshrc"
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
