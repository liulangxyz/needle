#!/bin/bash

source $LIB

echo
info "==>" "config python"

echo "==>" "config pip.conf"
PIP_CONF=~/.pip/pip.conf
mkdir -p ~/.pip
backup $PIP_CONF
linkconf $INSTALL_HOME/package/python/pip.conf $PIP_CONF

pipinstall() {
  echo "==>" "install $1"
  if ! pip3 show "$1" >/dev/null 2>&1; then
    pip3 install "$1"
    log "pip3 install: $1"
  else
    warn "already installed"
  fi
}

# libs
pipinstall virtualenvwrapper

# python env
brewinstall pyenv
brewinstall pyenv-virtualenvwrapper
