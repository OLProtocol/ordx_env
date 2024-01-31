#!/bin/bash
# set -x

# rust
if command -v rustc &> /dev/null
then
    echo "rustc is already installed"
else
    echo "preparing to install rustc"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustc --version
    rustup toolchain install 1.70
    rustup default 1.70
    source "$HOME/.cargo/env"
    # rustup show, rustup toolchain list
fi

# nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install 16.13.0

# postgres
apt install postgresql postgresql-contrib
# vi /etc/postgresql/12/main/postgresql.conf
# listen_addresses = '*'
# vi /etc/postgresql/12/main/pg_hba.conf
# host    all             all             0.0.0.0/0            md5
# sudo -u postgres psql #sudo -i -u postgres
# ALTER USER postgres with password 'tinyverse';
# \q
# vi /etc/postgresql/12/main/pg_hba.conf
# local   all             postgres                             password
# sudo systemctl restart postgresql.service
# psql -h 192.168.1.102 -U postgres -W
# vi /etc/postgresql/12/main/postgresql.conf
# data_directory = '/data/postgresql/12/main'
# sudo chown -R postgres:postgres /data/postgresql/
# sudo chmod -R 0750 /data/postgresql/
# systemctl restart postgresql

# tmux
apt remove tmux
sudo apt update && sudo apt install libncurses5-dev libevent-dev build-essential autoconf bison
git clone git@github.com:tmux/tmux.git
cd tmux && git checkout 3.3
./configure && make && sudo make install

# rvm && gem && tmuxinator
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
proxy_on
curl -sSL https://get.rvm.io | bash -s stable --ruby
proxy_off
rvm -v
rvm list
rvm use default --default
gem -v
gem install tmuxinator

## autossh
apt install autossh

# golang
curl -sSL https://git.io/g-install | sh -s
