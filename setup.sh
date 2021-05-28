#!/bin/bash

set -e

command_exists() {
  command -v "$@" 1>/dev/null 2>&1
}

setup_color() {
  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  RESET=$(printf '\033[m')
}

info() {
  echo "${GREEN}[NEEDLE]${RESET}" "$@"
}

error() {
  echo "${RED}Error:${RESET}" "$@"
}

check_precondition() {
  if ! command_exists xcode-select || [[ -z $(xcode-select -p) ]]; then
    info "install xcode command line tools"
    xcode-select --install
  fi

  if ! command_exists brew; then
    info "install homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

main() {
  setup_color
  info "start"
  check_precondition
  info "brew update && upgrade"
  brew update && brew upgrade

  # brews
  brews=(
    cmake
    fzf
    fd
    ripgrep
    httpie
    youtube-dl
    direnv
    git
    tmux
    vim
    node
    yarn
    python3
    pipenv
    reattach-to-user-namespace
  )

  info "install brews"
  brew install -q "${brews[@]}"

  if [[ ! -d ~/.oh-my-zsh ]]; then
    info "install oh-my-zsh"
    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    info "install plug.vim, a vim plugin manager"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  if [ ! -s ~/.nvm/nvm.sh ]; then
    info "install node version manager"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  fi

  info "symlink rc files"
  for rc in $(ls "${NEEDLE}/rc"); do
    ln -fsv "${NEEDLE}/rc/${rc}" "${HOME}/.${rc}"
  done

  info "copy template"
  cp -fpv "${NEEDLE}/template/simple.zsh-theme" ~/.oh-my-zsh/custom/themes/simple.zsh-theme
  cp -fpv "${NEEDLE}/template/gitconfig" ~/.gitconfig

  info "done."
}

########################################
# main
########################################
export NEEDLE="${HOME}/.needle"
main
