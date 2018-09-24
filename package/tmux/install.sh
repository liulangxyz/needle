#!/bin/bash

source $LIB

brewinstall tmux
brewinstall reattach-to-user-namespace

info "==>" "config tmux.conf"
backup ~/.tmux.conf
linkconf $NEEDLE_HOME/package/tmux/tmux.conf ~/.tmux.conf
