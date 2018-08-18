source $INSTALL_HOME/func.sh

brewinstall git

GIT_CONFIG=~/.gitconfig
TEMPLATE_GIT_CONFIG=$INSTALL_HOME/package/git/gitconfig.template
TARGET_GIT_CONFIG=$INSTALL_HOME/package/custom/gitconfig
GIT_IGNORE=~/.gitignore
TEMPLATE_GIT_IGNORE=$INSTALL_HOME/package/git/gitignore.template
TARGET_GIT_IGNORE=$INSTALL_HOME/package/custom/gitignore

info "config gitconfig"
backup $GIT_CONFIG
backup $TARGET_GIT_CONFIG
cp -p $TEMPLATE_GIT_CONFIG $TARGET_GIT_CONFIG
linkconf $TARGET_GIT_CONFIG $GIT_CONFIG

info "config gitignore"
backup $GIT_IGNORE
backup $TARGET_GIT_IGNORE
cp -p $TEMPLATE_GIT_IGNORE $TARGET_GIT_IGNORE
linkconf $TARGET_GIT_IGNORE $GIT_IGNORE

info "do you want to config your git user and email (y/n):"
read ans
if [ $ans = 'y' ]; then
  info "Name: "
  read name
  git config --global user.name "$name"
  info "Email: "
  read email
  git config --global user.email "$email"
fi
