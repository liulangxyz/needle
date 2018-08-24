#!/bin/bash

source $LIB

brewinstall git

# config gitconfig
info "==>" "config gitconfig"
GIT_CONFIG=~/.gitconfig
TEMPLATE_GIT_CONFIG=$INSTALL_HOME/package/git/gitconfig.template
if [ -f $GIT_CONFIG ]; then
  warn "$GIT_CONFIG already exists"
  info "==>" "do you want to re-set (y/n):"
else
  info "==>" "do you want to set gitconfig (y/n):"
fi
read ans
if [ $ans = 'y' ]; then
  backup $GIT_CONFIG
  rm -rf $GIT_CONFIG
  cp -f $TEMPLATE_GIT_CONFIG $GIT_CONFIG

  # setup user name and email
  info "==>" "Your name: "
  read name
  git config --global user.name "$name"
  info "==>" "Your Email: "
  read email
  git config --global user.email "$email"
fi


# config gitignore
info "==>" "config gitignore"
GIT_IGNORE=~/.gitignore
backup $GIT_IGNORE
rm -rf $GIT_IGNORE
linkconf $INSTALL_HOME/package/git/gitignore $GIT_IGNORE
