#!/bin/bash

set -e

########################################
# utils
########################################
# output string in green
info() {
  echo $'\e[1;32m'"[NEEDLE]"$'\e[0m' "${@:1}"
}

# $1 brew
brewinstall() {
  info "brew install $1"
  brew install "$1"
}

# $1 source
# $2 target
symlink() {
  info "symlink $2"
  ln -fsv "$1" "$2"
}

########################################
# init
########################################
# install developer command line tools if not
if [[ -z $(xcode-select -p) ]]; then
  info "install xcode command line tools"
  xcode-select --install
fi

# install homebrew if not
if ! command -v brew 1>/dev/null 2>&1; then
  info "install homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


########################################
# basic stuff
########################################
info "update brews"
brew update

info "upgrade existed brews"
brew upgrade

brewinstall cmake
brewinstall fzf
brewinstall fd
brewinstall ag
brewinstall youtube-dl
brewinstall httpie


########################################
# git
########################################
# install latest git
brew install git

# gitignore
symlink "$PWD"/conf/git/gitignore ~/.gitignore

# gitconfig
if [[ ! -f ~/.gitconfig ]]; then
  info "config gitconfig"
  cp -v "$PWD"/conf/git/gitconfig.template ~/.gitconfig

  # setup user name and email
  read -r -p "Your name: " name
  git config --global user.name "$name"
  read -r -p "Your email: " email
  git config --global user.email "$email"
fi


########################################
# node
########################################
brew install node

# node version manager
if [ ! -s ~/.nvm/nvm.sh ]; then
  info "install node version manager"
  git clone https://github.com/creationix/nvm.git ~/.nvm
  cd ~/.nvm
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  popd
fi


########################################
# python
########################################
brew install python3

# pip
[[ ! -d ~/.pip ]] && mkdir ~/.pip
symlink "$PWD"/conf/pip/pip.conf ~/.pip/pip.conf


########################################
# tmux
########################################
brew install tmux
brew install reattach-to-user-namespace

# tmux.conf
symlink "$PWD"/conf/tmux/tmux.conf ~/.tmux.conf


########################################
# vim
########################################
brew install vim

# vimrc
symlink "$PWD"/conf/vim/vimrc ~/.vimrc

# install plugin manager
if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
  echo "install plug.vim"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

read -r -p "do you want to install vim plugins (y/n): " ans
if [[ $ans = 'y' ]]; then
  vim +PlugInstall +qall
fi

read -r -p "do you want to compile YouCompleteMe (y/n): " ans
if [[ $ans = 'y' ]]; then
  python3 ~/.vim/plug/YouCompleteMe/install.py --clang-completer
fi

# override default vi
if [[ ! -h /usr/local/bin/vi && -f /usr/local/bin/vim ]]; then
  ln -fsv /usr/local/bin/vim /usr/local/bin/vi
fi


########################################
# zsh
########################################
brew install zsh

# oh my zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
  info "install oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# zsh theme
if [[ ! -f ~/.oh-my-zsh/custom/themes/simple.zsh-theme ]]; then
  info "install simple.zsh-theme"
  cp -v "$PWD"/conf/zsh/simple.zsh-theme ~/.oh-my-zsh/custom/themes/simple.zsh-theme
fi

# zshrc
symlink "$PWD"/conf/zsh/zshrc ~/.zshrc
