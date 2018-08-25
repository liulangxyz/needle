#!/bin/bash

source $LIB

echo
info "==>" "config zsh"

echo "==> install oh my zsh"
if [ ! -d ~/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  warn "already installed"
fi

# install customized zsh theme
SOURCE_FILE=$INSTALL_HOME/package/zsh/simple.zsh-theme
TARGET_FILE=~/.oh-my-zsh/custom/themes/simple.zsh-theme
backup $TARGET_FILE
echo "==>" "install customized zsh theme"
cp -p $SOURCE_FILE $TARGET_FILE
log "copy: $SOURCE_FILE -> $TARGET_FILE"

# symlink conf
echo "==>" "config zshrc"
backup ~/.zshrc
linkconf $INSTALL_HOME/package/zsh/zshrc ~/.zshrc
