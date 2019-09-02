#!/bin/bash

set -e

########################################
# utils
########################################
# output string in green
info() {
  echo $'\e[1;32m'"[NEEDLE]"$'\e[0m' "${@:1}"
}


########################################
# init
########################################
# install developer command line tools if not
if [ -z $(xcode-select -p) ]; then
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
brew install cmake
brew install fzf
brew install fd
brew install ag
brew install youtube-dl
brew install httpie


########################################
# git
########################################
# install latest git
brew install git

# gitignore
if [ ! -f "~/.gitignore" ]; then
  info "config gitignore"
  ln -fsv "$pwd/conf/git/gitignore" "~/.gitignore"
fi

# gitconfig
if [ ! -f "~/.gitconfig" ]; then
  info "config gitconfig"
  cp -v "$pwd/conf/git/gitconfig.template" "~/.gitconfig"

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
export NVM_DIR=$HOME/.nvm
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  info "install node version manager"
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
  popd
fi


########################################
# python
########################################
brew install python3

# pip
if [ ! -f "~/.pip/pip.conf" ]; then
  info "config pip.conf"
  mkdir "~/.pip"
  ln -fsv "$pwd/conf/pip/pip.conf" "~/.pip/pip.conf"
fi


########################################
# tmux
########################################
brew install tmux
brew install reattach-to-user-namespace

if [ ! -f "~/.tmux.conf" ]; then
  info "config tmux.conf"
  ln -fsv "$pwd/conf/tmux/tmux.conf" "~/.tmux.conf"
fi


########################################
# vim
########################################
brew install vim

# vimrc
if [ ! -f "~/.vimrc" ]; then
  info "config vimrc"
  ln -fsv "$pwd/conf/vim/vimrc" "~/.vimrc"

  # install plugin manager
  if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "install plug.vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  read -r -p "do you want to install vim plugins (y/n): " ans
  if [ $ans = 'y' ]; then
    vim +PlugInstall +qall
  fi

  read -r -p "do you want to compile YouCompleteMe (y/n): " ans
  if [ $ans = 'y' ]; then
    python3 ~/.vim/plug/YouCompleteMe/install.py --clang-completer --java-completer
  fi

  # override default vi
  if [ ! -f /usr/local/bin/vi -a -f /usr/local/bin/vim ]; then
    ln -s /usr/local/bin/vim /usr/local/bin/vi
  fi
fi


########################################
# zsh
########################################
brew install zsh

# oh my zsh
if [ ! -d ~/.oh-my-zsh ]; then
  info "install oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# zsh theme
TARGET=~/.oh-my-zsh/custom/themes/simple.zsh-theme
SOURCE="$pwd/conf/zsh/simple.zsh-theme"
if [ ! -f "$TARGET" ]; then
  info "install simple.zsh-theme"
  cp -v "$SOURCE" "$TARGET"
fi

# zshrc
if [ ! -f "~/.zshrc" ]; then
  info "config zshrc"
  ln -fsv "$pwd/conf/zsh/zshr" "~/.zshrc"
fi
