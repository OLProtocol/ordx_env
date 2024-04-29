#!/bin/bash
# set -x
set -e

# install mdbook
if command -v mdbook &> /dev/null
then
    echo "mdbook is already installed"
else
    cargo install mdbook
fi