#!/bin/bash

# local language settings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# pyenv and pyenv-virtualenv
if command -v pyenv 1>/dev/null 2>&1 ; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# virtualenvwrapper
if command -v lsvirtualenv 1>/dev/null 2>&1 ; then
  if command -v python3 1>/dev/null 2>&1 ; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  fi
  export PIP_REQUIRE_VIRTUALENV=false
  export WORKON_HOME=$HOME/.python-env
  source /usr/local/bin/virtualenvwrapper.sh
fi

# java
export JAVA_HOME=$(/usr/libexec/java_home)
