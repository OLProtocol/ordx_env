#!/bin/bash
# https://github.com/jarun/advcpmv
export FORCE_UNSAFE_CONFIGURE=1
curl https://raw.githubusercontent.com/jarun/advcpmv/master/install.sh --create-dirs -o ./advcpmv/install.sh && (cd advcpmv && sh install.sh)
cd advcpmv || exit
cp advcp /usr/local/bin/cpg
cp advmv /usr/local/bin/mvg
