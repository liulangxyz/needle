#!/bin/bash

source $INSTALL_HOME/func.sh

brewinstall tmux
brewinstall reattach-to-user-namespace
backup ~/.tmux.conf
linkconf $INSTALL_HOME/package/tmux/tmux.conf ~/.tmux.conf
