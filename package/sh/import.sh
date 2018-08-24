#!/bin/bash

# load user defined settings
source "$DOT_HOME/sh/config.sh"
source "$DOT_HOME/sh/alias.sh"

# load custom configs
if [ -e "$PKG_HOME/custom/import.sh" ]; then
  source "$PKG_HOME/custom/import.sh"
fi
