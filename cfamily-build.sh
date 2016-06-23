#!/bin/bash

set -eu pipefail

bash ./get_source.sh

if [ ! -f cups-1.6.1-source.tar.gz ]; then
  # http://openjdk.5641.n7.nabble.com/Why-is-CUPS-required-td134487.html
  wget http://www.cups.org/software/1.6.1/cups-1.6.1-source.tar.gz
  tar -xzf cups-1.6.1-source.tar.gz
  cd cups-1.6.1
  ln -s . include
  cd ..
fi
if [ ! -f freetype-2.6.3.tar.gz ]; then
  wget http://download.savannah.gnu.org/releases/freetype/freetype-2.6.3.tar.gz
  tar -xzf freetype-2.6.3.tar.gz
  cd freetype-2.6.3
  ./configure
  make
  ln -s objs/.libs lib
  cd ..
fi

bash ./configure --with-cups=$(pwd)/cups-1.6.1 --with-freetype=$(pwd)/freetype-2.6.3 --enable-debug
make clean
build-wrapper-linux-x86-64 --out-dir cfamily-compilation-database make all
