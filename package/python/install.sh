#!/bin/bash

source $LIB

brewinstall python3

PIP_CONF=~/.pip/pip.conf
mkdir -p ~/.pip
backup $PIP_CONF
linkconf $INSTALL_HOME/package/python/pip.conf $PIP_CONF

# libs
brewinstall pyenv
brewinstall pyenv-virtualenv
brewinstall pyenv-virtualenvwrapper
