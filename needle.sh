#!/bin/bash

########################################
# common settings
########################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

########################################
# load plugins
########################################
# git
git_discard() {
  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 3); do
    git checkout -- "$f"
  done

  for f in $(git status -s | grep -E "\?\?" | cut -d ' ' -f 2); do
    rm -rf -- "$f"
  done
}

fzf_git_branch() {
  git for-each-ref --format="%(refname:lstrip=2)" "refs/heads" | fzf -m
}

fzf_git_checkout() {
  git checkout $(fzf_git_branch)
}

fzf_git_branch_delete() {
  git branch -D $(fzf_git_branch)
}

# node version manager
loadnvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# python
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# direnv
eval "$(direnv hook zsh)"

########################################
# alias
########################################
# files
alias vineedle="vi ~/.needle/needle.sh"
alias vitmuxconf="vi ~/.tmux.conf && tmux source ~/.tmux.conf"
alias vizshrc="vi ~/.zshrc && source ~/.zshrc"

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
