#!/bin/bash

source $LIB

echo
info "==>" "config git"

# config gitconfig
echo "==>" "config gitconfig"
GIT_CONFIG=~/.gitconfig
TEMPLATE_GIT_CONFIG=$INSTALL_HOME/package/git/gitconfig.template
if [ -f $GIT_CONFIG ]; then
  warn "$GIT_CONFIG already exists"
  msg="re-set"
else
  msg="set"
fi
read -r -p "==> do you want to $msg gitconfig (y/n): " ans
if [ $ans = 'y' ]; then
  backup $GIT_CONFIG
  cp -f $TEMPLATE_GIT_CONFIG $GIT_CONFIG

  # setup user name and email
  read -r -p "==> Your name: " name
  git config --global user.name "$name"
  read -r -p "==> Your name: " email
  git config --global user.email "$email"
fi

# config gitignore
echo "==>" "config gitignore"
GIT_IGNORE=~/.gitignore
backup $GIT_IGNORE
linkconf $INSTALL_HOME/package/git/gitignore $GIT_IGNORE
