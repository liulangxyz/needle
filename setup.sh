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
  echo
  echo "${GREEN}[NEEDLE]${RESET}" "$@"
}

error() {
  echo "${RED}[NEEDLE] Error:${RESET}" "$@"
}

main() {
  setup_color
  info "start"

  info "install xcode command line tools"
  if ! command_exists xcode-select || [[ -z $(xcode-select -p) ]]; then
    xcode-select --install
  fi

  info "install homebrew"
  if ! command_exists brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  info "brew update && upgrade"
  PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
  brew update && brew upgrade

  info "install brews"
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
    python3
    pipenv
    pnpm
    node
    yarn
    reattach-to-user-namespace
  )
  brew install -q "${brews[@]}"

  info "install oh-my-zsh"
  if [[ ! -d ~/.oh-my-zsh ]]; then
    CHSH=no RUNZSH=no KEEP_ZSHRC=yes /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  info "install plug.vim, a vim plugin manager"
  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    curl -fsSLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  info "install node version manager"
  if [ ! -d ~/.nvm ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh)"
  fi

  info "symlink runtime configurations"
  for f in $(ls "${NEEDLE}/rc"); do
    ln -fsv "${NEEDLE}/rc/${f}" "${HOME}/.${f}"
  done

  info "copy templated configurations"
  cp -fpv "${NEEDLE}/template/simple.zsh-theme" ~/.oh-my-zsh/custom/themes/simple.zsh-theme
  cp -fpv "${NEEDLE}/template/gitconfig" ~/.gitconfig

  info "done."
}

########################################
# main
########################################
export NEEDLE="${HOME}/.needle"
main
