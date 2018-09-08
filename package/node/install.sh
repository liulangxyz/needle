#!/bin/bash

source $LIB

# install node packages
#
# $1: package in npm
npminstall() {
  info "==>" "npm install $1"
  if ! npm ls "$1" -g --depth 0 1>/dev/null 2>&1; then
    npm install -g "$1"
    log "npm install: $1"
  else
    warn "already installed"
  fi
}

brewinstall node

# install nvm
export NVM_DIR="$HOME/.nvm"
if ! command -v nvm 1>/dev/null 2>&1; then
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    info "==>" "install node version manager"
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    local current_dir=$(pwd)
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    cd "$current_dir"
  fi
  source "$NVM_DIR/nvm.sh"
  info "==>" "use system as default node version"
  nvm alias default system
  nvm use system
fi

# typescript
npminstall typescript
npminstall tslint
