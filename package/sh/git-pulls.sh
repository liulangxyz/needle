#!/bin/bash

set -e

CURRENT_BRANCH=$(git --no-pager branch | grep "*" | cut -d ' ' -f 2)

for branch in $(git --no-pager branch --format="%(refname)"); do
  branch=${branch/*heads\/}
  git checkout $branch
  git pull
done

git checkout $CURRENT_BRANCH
