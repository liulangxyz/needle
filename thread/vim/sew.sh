brewinstall vim

# vimrc
symlink "$PWD"/thread/vim/vimrc ~/.vimrc

# install plugin manager
if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
  info "install plug.vim, a vim plugin manager"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# override default vi
if [[ -f /usr/local/bin/vim ]]; then
  symlink /usr/local/bin/vim /usr/local/bin/vi
fi