#!/bin/bash

set -e

# make sure invoking INSTALL.sh in right directory
export INSTALL_HOME=$(pwd)
if [ ! -f "$INSTALL_HOME/INSTALL.sh" ]; then
  echo "Please invoke INSTALL.sh from where it resides"
  exit 1
fi

export TIMESTAMP=$(date '+%Y%m%d%H%M%S')
export LIB=$INSTALL_HOME/lib/import.sh
source $LIB


# =============================================================================
# Basic
# =============================================================================
# install developer command line tools
echo "==> install xcode command line tools"
if [[ -z $(xcode-select -p) ]]; then
  xcode-select --install
else
  warn "already installed"
fi

# install homebrew
echo "==> install homebrew"
if ! command -v brew 1>/dev/null 2>&1; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  warn "already installed"
fi


# =============================================================================
# Install binaries
# =============================================================================
# essentials
brewinstall cmake
brewinstall fzf
brewinstall fd
brewinstall ag
brewinstall pt
brewinstall youtube-dl
brewinstall httpie
brewinstall node

# customized
for install_script in $INSTALL_HOME/package/*/install.sh; do
  /bin/sh $install_script
done
