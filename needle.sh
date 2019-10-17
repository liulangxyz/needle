#!/bin/bash

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
for plugin in $(find ~/.needle/custom -name "*.plugin.sh" -print | sort); do
  source "$plugin"
done