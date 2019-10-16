brewinstall git

# gitignore
symlink "$PWD"/thread/git/gitignore ~/.gitignore

# gitconfig
if [[ ! -f ~/.gitconfig ]]; then
  info "config gitconfig"
  cp -v "$PWD"/thread/git/gitconfig.template ~/.gitconfig

  # setup user name and email
  read -r -p "Your name: " name
  git config --global user.name "$name"
  read -r -p "Your email: " email
  git config --global user.email "$email"
fi