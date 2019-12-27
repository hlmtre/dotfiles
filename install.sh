#!/bin/bash

# create symlinks to various things in $HOME
# but we want to check for existence (regardless of type) of the file
# -f would test if file, -d if directory - but it never returns true either way,
# since they're symlinks

function install_dotfiles {
  cur=`pwd`
  if [ -e ~/.emacs.d ]; then
      echo "~/.emacs.d exists; renaming for safety..."
      mv ~/.emacs.d ~/.emacs.d.backup
  fi
  ln -s $cur/hlmtremacs ~/.emacs.d

  if [ -e ~/.spacemacs ]; then
      echo "~/.spacemacs exists; renaming for safety..."
      mv ~/.spacemacs ~/.spacemacs.backup
  fi
  ln -s $cur/hlmtremacs/.spacemacs ~/.spacemacs

  if [ -e ~/.i3 ]; then
      echo "~/.i3 exists; renaming for safety..."
      mv ~/.i3 ~/.i3.backup
  fi
  ln -s $cur/.i3 ~/.i3

  if [ -e ~/.i3status.conf ]; then
      echo "~/.i3status.conf exists; renaming for safety..."
      mv ~/.i3status.conf ~/.i3status.conf.backup
  fi
  ln -s $cur/.i3/py3status/.i3status.conf ~/.i3status.conf

  if [ -e ~/.vimrc ]; then
      echo "~/.vimrc exists; renaming for safety..."
      mv ~/.vimrc ~/.vimrc.backup
  fi
  ln -s $cur/.vimrc ~/.vimrc

  if [ -e ~/.zshrc ]; then
      echo "~/.zshrc exists; renaming for safety..."
      mv ~/.zshrc ~/.zshrc.backup
  fi
  ln -s $cur/.zshrc ~/.zshrc

  if [ -e ~/.config/fish ]; then
      echo "~/.config/fish exists; renaming for safety..."
      mv ~/.config/fish ~/.config/fish.backup
  fi
  ln -s $cur/fish ~/.config/fish

  if [ -e ~/.config/rofi ]; then
      echo "~/.config/rofi exists; renaming for safety..."
      mv ~/.config/rofi ~/.config/rofi.backup
  fi
  ln -s $cur/rofi ~/.config/rofi

  if [ -e ~/.config/dunst ]; then
      echo "~/.config/dunst exists; renaming for safety..."
      mv ~/.config/dunst ~/.config/dunst.backup
  fi
  ln -s $cur/dunst ~/.config/dunst

  mkdir -p ~/bin/
  ln -s $cur/ssh-agent-procure.bash ~/bin/

  if [ -e ~/.tmux.conf ]; then
    echo "~/.tmux.conf exists; renaming for safety..."
    mv ~/.tmux.conf ~/.tmux.conf.backup
  fi
  ln -s $cur/.tmux.conf ~/.tmux.conf

  if [ -e ~/.bashrc ]; then
    echo "~/.bashrc exists; renaming for safety..."
    mv ~/.bashrc ~/.bashrc.backup
  fi
  ln -s $cur/.bashrc ~/.bashrc

  if [ -e ~/.SpaceVim.d ]; then
    echo "~/.SpaceVim.d exists; renaming for safety..."
    mv ~/.SpaceVim.d ~/.SpaceVim.d.backup
  fi
  ln -s $cur/.SpaceVim.d ~/.SpaceVim.d


  # if it exists and is empty
  if [ -z "(ls -A ~/.SpaceVim)" ]; then
    rm -rf ~/.SpaceVim
  fi

  ln -s $cur/.SpaceVim.d/myconfig.vim ~/.SpaceVim/autoload/
}

function install_spacevim {
  curl -sLf https://spacevim.org/install.sh | bash
}

function install_neovim {
  bash ./neovim.sh
}

function install_rust {
  # install rust if not installed
  if [[ ! $(command -v rustc) ]] ; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  else
    echo "rustc already installed; check rustup?"
  fi
}

function install_all {
  install_rust
  install_neovim
  install_spacevim
  install_dotfiles
}

function usage {
  echo "usage:
        install.sh <opts> [
        -r (install rust)
        -n (install neovim)
        -s (install spacevim)
        -d (install dotfiles)
        -a (all)
        ]"
  exit 1
}

# execution starts here

if [[ $# < 1 ]] ; then
  usage
  exit 1
fi

while getopts ":rnsda" opt; do
  case ${opt} in
    r) echo "installing rust... " && install_rust
      ;;
    n) echo "installing neovim... " && install_neovim
      ;;
    s) echo "installing spacevim... " && install_spacevim
      ;;
    d) echo "installing dotfiles... " && install_dotfiles
      ;;
    a) echo "installing all... " && install_all
      ;;
    \?) echo "Invalid option -$OPTARG" >&2
  esac
done

