## install python3
```shell
brew install python3
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

```shell
# apt install python3.9.2
# sudo update-alternatives --set python3 /usr/bin/python3.6
# sudo apt install --reinstall python-dbus
sudo apt update
sudo apt upgrade
sudo apt install software-properties-common
sudo apt install python3.9
sudo apt install python3.9-distutils python3.9-venv python3.9-dev python3.9-distutils
sudo update-alternatives --remove-all python3
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
sudo update-alternatives --list python3
sudo update-alternatives --display python3
sudo update-alternatives --config python3
python3 --version

# networkd-dispatcher.service error
pyenv install python3.8.10
pyenv global python3.8.10
sudo apt install python3.8.10
sudo update-alternatives --set python3 /usr/bin/python3.8
sudo apt install --reinstall python-dbus
sudo pip install --upgrade pip
sudo pip install glib
sudo pip install PyQt
systemctl start networkd-dispatcher.service

# install pyenv && install python with pyenv
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc

mv /usr/bin/python2 python2_bak && mv /usr/bin/python3 python3_bak && mv /usr/bin/python python_bak
pyenv install 3.9.2
pyenv local 3.9.2
pyenv global 3.9.2
pyenv versions
```