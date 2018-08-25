#!/bin/bash

# pull all local branches
git_pulls() {
  CURRENT_BRANCH=$(git --no-pager branch | grep "*" | cut -d ' ' -f 2)

  for branch in $(git --no-pager branch --format="%(refname)"); do
    branch=${branch/*heads\/}
    git checkout $branch
    git pull
  done

  git checkout $CURRENT_BRANCH
}

# force push
git_push_force() {
  MSG="$1"
  if [ -z "$MSG" ]; then
    # use previous commit message if user does not provide
    MSG=$(git --no-pager log -1 --pretty=%B)
  fi
  git add .
  git commit --amend -m "$MSG"
  git push --force
}

# alias
alias vigitignore="vi ~/.gitignore"
alias vigitrc="vi $DOT_HOME/package/git/gitrc.sh && source $SHELL_RC"
alias git-pulls="git_pulls"
alias git-push-force="git_push_force"
