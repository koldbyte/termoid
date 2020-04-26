#!/bin/bash

set -e
rm -rf build
mkdir build -p && cd build
cmake -DCMAKE_INSTALL_PREFIX=`kf5-config --prefix` -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON ../
make
sudo make install 
kquitapp5 plasmashell
kstart5 plasmashell
