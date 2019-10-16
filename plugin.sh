#!/bin/bash

# add following line to shell profile to load plugins
#
# [ -f "~/.needle/plugin.sh" ] && source "~/.needle/plugin.sh"
#

########################################
# common settings
########################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

########################################
# load plugins
########################################
# load user defined plugins
for plugin in $(find ~/.needle/thread -name "plugin.sh" -type f -print | sort); do
  source "$plugin"
done

# load custom plugins
for plugin in $(find ~/.needle/custom -name "*.plugin.sh" -type f -print | sort); do
  source "$plugin"
done