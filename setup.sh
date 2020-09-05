#!/bin/bash

set -e

command_exists() {
  command -v "$@" 1>/dev/null 2>&1
}

info() {
  echo "${GREEN}[NEEDLE]${RESET}" "$@"
}

error() {
  echo "${RED}Error:${RESET}" "$@"
}

brewinstall() {
  info "brew install $1"
  brew install "$1"
}

symlink() {
  info "symlink $2"
  ln -fsv "$1" "$2"
}

setup_color() {
  RED=$(printf '\033[31m')
	GREEN=$(printf '\033[32m')
	YELLOW=$(printf '\033[33m')
  RESET=$(printf '\033[m')
}

check_precondition() {
  if ! command_exists xcode-select || [[ -z $(xcode-select -p) ]]; then
    info "install xcode command line tools"
    xcode-select --install
  fi

  if ! command_exists brew; then
    info "install homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  if ! command_exists git; then
    error "git not found"
    exit 1
  fi
}

dl_needle() {
  info "Cloning Needle"
  git clone "$NEEDLE_REPO" "$NEEDLE" || {
    error "clone failed"
    exit 1
  }
}

setup_tmux() {
  brewinstall tmux
  brewinstall reattach-to-user-namespace

  # tmux.conf
  symlink "$NEEDLE_THREAD"/tmux.conf ~/.tmux.conf
}

setup_zsh() {
  brewinstall zsh

  # oh my zsh
  if [[ ! -d ~/.oh-my-zsh ]]; then
    info "install oh-my-zsh"
    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
  fi

  # zsh theme
  if [[ ! -f ~/.oh-my-zsh/custom/themes/simple.zsh-theme ]]; then
    info "install simple.zsh-theme"
    cp -v "$NEEDLE_THREAD"/simple.zsh-theme ~/.oh-my-zsh/custom/themes/simple.zsh-theme
  fi

  # zshrc
  symlink "$NEEDLE_THREAD"/zshrc ~/.zshrc
}

setup_git() {
  brewinstall git
  # gitignore
  symlink "$NEEDLE_THREAD"/gitignore ~/.gitignore

  # gitconfig
  if [[ ! -f ~/.gitconfig ]]; then
    info "config gitconfig"
    cp -v "$NEEDLE_THREAD"/gitconfig.template ~/.gitconfig

    # setup user name and email
    read -r -p "Your name: " name
    git config --global user.name "$name"
    read -r -p "Your email: " email
    git config --global user.email "$email"
  fi
}

setup_vim() {
  brewinstall vim

  # vimrc
  symlink "$NEEDLE_THREAD"/vimrc ~/.vimrc

  # install plugin manager
  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    info "install plug.vim, a vim plugin manager"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  # override default vi
  if [[ -f /usr/local/bin/vim ]]; then
    symlink /usr/local/bin/vim /usr/local/bin/vi
  fi
}

setup_javascript() {
  brewinstall node

  # node version manager
  if [ ! -s ~/.nvm/nvm.sh ]; then
    info "install node version manager"
    git clone https://github.com/nvm-sh/nvm.git ~/.nvm
    CURR_DIR=$PWD
    cd ~/.nvm
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    cd "$CURR_DIR"
  fi
}

setup_python() {
  brewinstall python3
  brewinstall pipenv

  # pip
  [[ ! -d ~/.pip ]] && mkdir ~/.pip
  symlink "$NEEDLE_THREAD"/pip.conf ~/.pip/pip.conf
}

install() {
  setup_color
  check_precondition
  dl_needle

  info "update brews"
  brew update
  info "upgrade existed brews"
  brew upgrade

  # install essentails
  brewinstall cmake
  brewinstall fzf
  brewinstall fd
  brewinstall ripgrep
  brewinstall httpie
  brewinstall youtube-dl
  brewinstall direnv

  # rest of them
  setup_git
  setup_tmux
  setup_zsh
  setup_vim
  setup_javascript
  setup_python

  info "Needle is all set."
}

uninstall() {
  setup_color
  info "delete needle from $NEEDLE"
  rm -rf "$NEEDLE"
  info "deleted, see you next time."
}

main() {
  if [[ "$1" == "--uninstall" ]]; then
    uninstall
  else
    install
  fi
}

########################################
# main
########################################
export NEEDLE=~/.needle
export NEEDLE_THREAD="$NEEDLE/thread"
export NEEDLE_REPO=https://github.com/kkninjae/needle.git

main "$0"
