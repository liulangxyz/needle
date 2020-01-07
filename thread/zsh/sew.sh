brewinstall zsh

# oh my zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
  info "install oh-my-zsh"
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended"
fi

# zsh theme
if [[ ! -f ~/.oh-my-zsh/custom/themes/simple.zsh-theme ]]; then
  info "install simple.zsh-theme"
  cp -v "$NEEDLE"/thread/zsh/simple.zsh-theme ~/.oh-my-zsh/custom/themes/simple.zsh-theme
fi

# zshrc
symlink "$NEEDLE"/thread/zsh/zshrc ~/.zshrc
