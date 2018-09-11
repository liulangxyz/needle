#!/bin/bash

# lazy load pyenv
loadpyenv() {
  # pyenv and pyenv-virtualenv
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}

# lazy load virtualenvwrapper
loadvirtualenvwrapper() {
  # virtualenvwrapper
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  export PIP_REQUIRE_VIRTUALENV=false
  export WORKON_HOME=$HOME/.python-env
  source /usr/local/bin/virtualenvwrapper.sh
}

# alias
alias vipythonrc="vi $DOT_HOME/package/python/pythonrc.sh && source $SHELLRC"
