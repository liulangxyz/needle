#!/bin/bash

source $LIB

brewinstall git

# config gitconfig
GIT_CONFIG=~/.gitconfig
TEMPLATE_GIT_CONFIG=$INSTALL_HOME/package/git/gitconfig.template

echo "==> config gitconfig"
if [ -f $GIT_CONFIG ]; then
  info "$GIT_CONFIG already exists"
  info "do you want to re-set (y/n):"
else
  info "do you want to set gitconfig (y/n):"
fi
read ans
if [ $ans = 'y' ]; then
  backup $GIT_CONFIG
  cp -f $TEMPLATE_GIT_CONFIG $GIT_CONFIG

  # setup user name and email
  info "Name: "
  read name
  git config --global user.name "$name"
  info "Email: "
  read email
  git config --global user.email "$email"
fi


# config gitignore
GIT_IGNORE=~/.gitignore
TEMPLATE_GIT_IGNORE=$INSTALL_HOME/package/git/gitignore.template

echo "==> config gitignore"
if [ -f $GIT_IGNORE ]; then
  info "$GIT_IGNORE already exists"
  info "do you want to re-set (y/n):"
else
  info "do you want to set gitignore (y/n):"
fi
read ans
if [ $ans = 'y' ]; then
  backup $GIT_IGNORE
  cp -f $TEMPLATE_GIT_IGNORE $GIT_IGNORE
fi
