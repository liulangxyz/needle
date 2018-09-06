#!/bin/bash

source $LIB

brewinstall node

# install nvm
export NVM_DIR="$HOME/.nvm"
if ! command -v nvm 1>/dev/null 2>&1; then
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    local current_dir=$(pwd)
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    cd "$current_dir"
  fi
fi
