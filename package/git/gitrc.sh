#!/bin/bash

# pull all local branches
git_pulls() {
  local current_branch=$(git --no-pager branch | grep "*" | cut -d ' ' -f 2)
  for branch in $(git --no-pager branch --format="%(refname)"); do
    branch=${branch/*heads\/}
    git checkout $branch
    git pull
  done
  git checkout $current_branch
}

# force push
#
# $1: commit message, last commit message will be used if it is empty
git_push_force() {
  local msg="$1"
  if [ -z "$msg" ]; then
    # use previous commit message if user does not provide
    msg=$(git --no-pager log -1 --pretty=%B)
  fi
  git add .
  git commit --amend -m "$msg"
  git push --force
}

# checkout all modified files at one go
git_checkout() {
  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 3); do
    git checkout -- "$f"
  done
}

# alias
alias vigitrc="vi $DOT_HOME/package/git/gitrc.sh && source $SHELLRC"
alias vigitignore="vi ~/.gitignore"
alias git-pulls="git_pulls"
alias git-push-force="git_push_force"
alias git-checkout="git_checkout"
