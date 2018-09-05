#!/bin/bash

source $LIB

brewinstall git

# config gitconfig
info "==>" "config gitconfig"
git_config=~/.gitconfig
template_git_config=$INSTALL_HOME/package/git/gitconfig.template
if [ -f $git_config ]; then
  warn "$git_config already exists"
  msg="re-set"
else
  msg="set"
fi
read -r -p "do you want to $msg gitconfig (y/n): " ans
if [ $ans = 'y' ]; then
  backup $git_config
  cp -f $template_git_config $git_config

  # setup user name and email
  read -r -p "Your name: " name
  git config --global user.name "$name"
  read -r -p "Your name: " email
  git config --global user.email "$email"
fi

# config gitignore
info "==>" "config gitignore"
git_ignore=~/.gitignore
backup $git_ignore
linkconf $INSTALL_HOME/package/git/gitignore $git_ignore
