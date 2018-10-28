#!/bin/bash

config_files() {
  warn "config" "files"
  local files=(
    "monkey.md"
    "todo.md"
  )
  for file in ${files[@]}; do
    local file="$NEEDLE_HOME/custom/$file"
    if [ ! -f "$file" ]; then
      touch "$file"
      echo "create ${file//*\/}"
      log "create file: $file"
    fi
  done
}

config_gitignore() {
  warn "config" "gitignore"
  local target=~/.gitignore
  local source="$NEEDLE_HOME/conf/git/gitignore"
  backup "$target"
  linkconf "$source" "$target"
}

config_gitconfig() {
  warn "config" "gitconfig"
  local target=~/.gitconfig
  local source="$NEEDLE_HOME/conf/git/gitconfig.template"
  backup "$target"
  cp -f "$source" "$target"

  # setup user name and email
  read -r -p "Your name: " name
  git config --global user.name "$name"
  read -r -p "Your email: " email
  git config --global user.email "$email"
}

config_nvm() {
  warn "config" "nvm"
  export NVM_DIR=~/.nvm
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    echo "install node version manager"
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
    popd
  fi
}

config_pip() {
  warn "config" "pip.conf"
  local target=~/.pip/pip.conf
  local source="$NEEDLE_HOME/conf/python/pip.conf"
  mkdir -p "${target%\/*}"
  backup "$target"
  linkconf "$source" "$target"
}

config_tmux() {
  warn "config" "tmux.conf"
  local target=~/.tmux.conf
  local source="$NEEDLE_HOME/conf/tmux/tmux.conf"
  backup "$target"
  linkconf "$source" "$target"
}

config_vim() {
  warn "config" "vim"
  local target=~/.vimrc
  local source="$NEEDLE_HOME/conf/vim/vimrc"
  backup "$target"
  linkconf "$source" "$target"

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
}

config_ohmyzsh() {
  warn "config" "ohmyzsh"
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "install oh-my-zsh"
    /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi

  # install customized zsh theme
  local target=~/.oh-my-zsh/custom/themes/simple.zsh-theme
  local source="$NEEDLE_HOME/conf/zsh/simple.zsh-theme"
  if [ ! -f "$target" ]; then
    echo "install simple.zsh-theme"
    cp "$source" "$target"
  fi

  warn "config" "zshrc"
  local target=~/.zshrc
  local source="$NEEDLE_HOME/conf/zsh/zshrc"
  backup "$target"
  linkconf "$source" "$target"
}
