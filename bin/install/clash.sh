#!/bin/bash
# set -x
set -e

script_path=$(cd "$(dirname "$0")" && pwd)
cd "$script_path/../.."
git submodule update --init --recursive clash