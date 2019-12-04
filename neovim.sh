#!/bin/bash

PACKAGES="ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip build-essential curl wget"
URL=https://github.com/neovim/neovim/archive/v0.4.2.tar.gz

sudo apt install $PACKAGES
wget $URL
tar xvf v0.4.2.tar.gz
cd neovim-0.4.2
make CMAKE_BUILD_TYPE=Release
sudo make install
rm ../v0.4.2.tar.gz
