#!/bin/bash

# alias
alias vipythonrc="vi $DOT_HOME/package/python/pythonrc.sh && source $SHELLRC"

# pyenv and pyenv-virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export PIP_REQUIRE_VIRTUALENV=false
export WORKON_HOME=$HOME/.python-env
source /usr/local/bin/virtualenvwrapper.sh
