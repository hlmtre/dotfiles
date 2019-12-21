#!/bin/bash

PACKAGES="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip build-essential curl wget"
VERSION=0.4.3
TARFILE=v$VERSION.tar.gz
URL=https://github.com/neovim/neovim/archive/$TARFILE

if [[ $(command -v nvim) ]] && [[ $(nvim --version | head -n 1 | awk '{print $2}') = v$VERSION ]]; then
  exit 0
fi

sudo apt install $PACKAGES
wget $URL
tar xvf $TARFILE
cd neovim-$VERSION
make CMAKE_BUILD_TYPE=Release
sudo make install
rm ../$TARFILE
