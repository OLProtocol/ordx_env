#!/bin/bash
# set -x
set -e

# install just
if command -v just &> /dev/null
then
    echo "just is already installed"
else
    cargo install just
fi