#!/bin/bash

source $INSTALL_HOME/func.sh

brewinstall git

# config gitconfig
GIT_CONFIG=~/.gitconfig
TEMPLATE_GIT_CONFIG=$INSTALL_HOME/package/git/gitconfig.template
TARGET_GIT_CONFIG=$INSTALL_HOME/package/custom/gitconfig

if [ -f $GIT_CONFIG ]; then
  MSG="(You already have one ~/.gitginore)"
else
  MSG=""
fi
info "do you want to re-setup gitconfig $MSG (y/n):"
read ans
if [ $ans = 'y' ]; then
  backup $GIT_CONFIG
  backup $TARGET_GIT_CONFIG
  cp -p $TEMPLATE_GIT_CONFIG $TARGET_GIT_CONFIG
  linkconf $TARGET_GIT_CONFIG $GIT_CONFIG

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
TARGET_GIT_IGNORE=$INSTALL_HOME/package/custom/gitignore

info "config gitignore"
backup $GIT_IGNORE
backup $TARGET_GIT_IGNORE
cp -p $TEMPLATE_GIT_IGNORE $TARGET_GIT_IGNORE
linkconf $TARGET_GIT_IGNORE $GIT_IGNORE
