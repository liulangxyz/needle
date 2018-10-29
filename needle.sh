#!/bin/bash

set -e

SCRIPT="$0"

if [ -h "$SCRIPT" ]; then
  SCRIPT=$(readlink "$SCRIPT")
fi

if [ "${SCRIPT:0:2}" = './' ]; then
  SCRIPT="${SCRIPT:2}"
  SCRIPT="$(pwd)/${SCRIPT}"
fi

if [ "${SCRIPT:0:1}" != '/' ]; then
  SCRIPT="$(pwd)/$SCRIPT"
fi

export SCRIPT_NAME="${SCRIPT//*\/}"
export NEEDLE_HOME="${SCRIPT%\/*}"
export TIMESTAMP=$(date '+%Y%m%d%H%M%S')

source $NEEDLE_HOME/lib/util.sh
source $NEEDLE_HOME/lib/config.sh

check_precondition

# shell
info "==>" "setup shell"
brewinstall cmake
brewinstall fzf
brewinstall fd
brewinstall ag
brewinstall pt
brewinstall youtube-dl
brewinstall httpie
config_files

# git
info "==>" "setup git"
brewinstall git
config_gitconfig
config_gitignore

# node
info "==>" "setup node"
brewinstall node
npminstall typescript
npminstall tslint
config_nvm

# python
info "==>" "setup python"
brewinstall python3
brewinstall pyenv
brewinstall pyenv-virtualenvwrapper
pipinstall virtualenvwrapper
config_pip

# tmux
info "==>" "setup tmux"
brewinstall tmux
brewinstall reattach-to-user-namespace
config_tmux

# vim
info "==>" "setup vim"
brewinstall vim
config_vim

# zsh
info "==>" "setup zsh"
brewinstall zsh
config_ohmyzsh
