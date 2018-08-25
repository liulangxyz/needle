#!/bin/bash

source $LIB

echo
info "==>" "config tmux"

brewinstall reattach-to-user-namespace

echo "==>" "config tmux.conf"
backup ~/.tmux.conf
linkconf $INSTALL_HOME/package/tmux/tmux.conf ~/.tmux.conf
