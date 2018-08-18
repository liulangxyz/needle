source $INSTALL_HOME/func.sh

brewinstall zsh

echo "==> install oh my zsh"
if [ ! -d ~/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  warn "already installed"
fi

# install customized zsh theme
info "install customized zsh theme"
TARGET_FILE=~/.oh-my-zsh/custom/themes/simple.zsh-theme
backup $TARGET_FILE
cp -vp $INSTALL_HOME/package/zsh/simple.zsh-theme $TARGET_FILE

# symlink conf
backup ~/.zshrc
linkconf $INSTALL_HOME/package/zsh/zshrc ~/.zshrc
