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
