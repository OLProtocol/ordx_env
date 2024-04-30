#!/bin/bash
# set -x
set -e

script_path=$(cd "$(dirname "$0")" && pwd)
projectPath="$script_path/../.."
cd "$projectPath"
git submodule update --init --recursive clash