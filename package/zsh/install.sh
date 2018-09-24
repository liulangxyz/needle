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
customized_zsh_theme=$NEEDLE_HOME/package/zsh/simple.zsh-theme
target_file=~/.oh-my-zsh/custom/themes/simple.zsh-theme
if [ ! -f "$target_file" ]; then
  msg="install"
else
  msg="re-install"
fi
read -r -p "do you want to $msg simple.zsh-theme (y/n): " ans
if [ $ans = "y" ]; then
  backup $target_file
  info "==>" "install simple.zsh-theme"
  cp -p $customized_zsh_theme $target_file
  log "copy: $customized_zsh_theme -> $target_file"
fi

# symlink conf
info "==>" "config zshrc"
backup ~/.zshrc
linkconf $NEEDLE_HOME/package/zsh/zshrc ~/.zshrc
