#!/bin/bash
# set -x
set -e

# python3
if command -v python3 &> /dev/null
then
    echo "python3 is already installed"
else
    sudo apt update
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.8
    update-alternatives --remove python /usr/bin/python2
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10
    python --version
    sudo apt install python3-pip
    python -m pip install pip
    pip3 --version
fi