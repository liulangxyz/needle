#!/bin/bash

source $LIB

brewinstall zsh

info "==>" "install oh my zsh"
if [ ! -d ~/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  warn "already installed"
fi

# install customized zsh theme
SOURCE_FILE=$INSTALL_HOME/package/zsh/simple.zsh-theme
TARGET_FILE=~/.oh-my-zsh/custom/themes/simple.zsh-theme
if [ ! -f "$TARGET_FILE" ]; then
  msg="install"
else
  msg="re-install"
fi
read -r -p "do you want to $msg simple.zsh-theme (y/n): " ans
if [ $ans = "y" ]; then
  backup $TARGET_FILE
  info "==>" "install simple.zsh-theme"
  cp -p $SOURCE_FILE $TARGET_FILE
  log "copy: $SOURCE_FILE -> $TARGET_FILE"
fi

# symlink conf
info "==>" "config zshrc"
backup ~/.zshrc
linkconf $INSTALL_HOME/package/zsh/zshrc ~/.zshrc
