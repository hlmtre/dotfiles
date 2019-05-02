#!/bin/bash

# create symlinks to various things in $HOME
# but we want to check for existence (regardless of type) of the file
# -f would test if file, -d if directory - but it never returns true either way,
# since they're symlinks
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