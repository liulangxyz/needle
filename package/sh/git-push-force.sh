#!/bin/bash

set -e

echo '==> force push start'

# get commit messgae
msg="$1"
if [[ -z "$msg" ]]; then
  msg=$(git --no-pager log -1 --pretty=%B)
fi

git add .
git commit --amend -m "$msg"
git push --force

echo "==> done."
