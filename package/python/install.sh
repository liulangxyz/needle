#!/bin/bash

source $LIB

# install python packages
#
# $1: package in pip
pipinstall() {
  info "==>" "pip3 install $1"
  if ! pip3 show "$1" >/dev/null 2>&1; then
    pip3 install "$1"
    log "pip3 install: $1"
  else
    warn "already installed"
  fi
}

brewinstall python3

info "==>" "config pip.conf"
pip_conf=~/.pip/pip.conf
mkdir -p ~/.pip
backup $pip_conf
linkconf $INSTALL_HOME/package/python/pip.conf $pip_conf

# libs
pipinstall virtualenvwrapper

# python env
brewinstall pyenv
brewinstall pyenv-virtualenvwrapper
