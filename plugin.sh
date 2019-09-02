#!/bin/bash

# customized functions and settings could be loaded in shell env by putting following line into zshrc or bashrc
#
# [ -f "~/.needle/plugin.sh" ] && source "~/.needle/plugin.sh"
#

########################################
# functions
########################################
# checkout all modified files at one go
git_checkout() {
  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 3); do
    git checkout -- "$f"
  done

  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 2); do
    rm -rf -- "$f"
  done
}

# display branch using fzf
fgb() {
  git for-each-ref --format="%(refname:lstrip=2)" "refs/heads" | fzf
}

# checkout branch using fzf
fgc() {
  git checkout $(fgb)
}

# delete branch using fzf
fgbd() {
  git branch -D $(fgb)
}

# lazyload nvm instead of loading it for every open shell
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

# ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.5.0/bin:$PATH"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'


########################################
# alias
########################################
# files
alias vigitignore="vi ~/.gitignore"
alias vizshrc="vi ~/.zshrc && source $SHELLRC"
alias vitmuxconf="vi ~/.tmux.conf && tmux source ~/.tmux.conf"

# convenient
[ ! -f "~/.needle/custom/monkey.md" ] && touch "~/.needle/custom/monkey.md"
alias vimk="vi ~/.needle/custom/monkey.md"
[ ! -f "~/.needle/custom/todo.md" ] && touch "~/.needle/custom/todo.md"
alias vitodo="vi ~/.needle/custom/todo.md"

# directories
alias mk="cd ~/Documents"

# macos
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'


########################################
# custom
########################################
for plugin in ~/.needle/custom/*.plugin.sh; do
  [ -f "$plugin" ] && source "$plugin"
done
