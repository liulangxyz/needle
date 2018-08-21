#!/bin/bash

source $LIB

brewinstall tmux
brewinstall reattach-to-user-namespace
backup ~/.tmux.conf
linkconf $INSTALL_HOME/package/tmux/tmux.conf ~/.tmux.conf
