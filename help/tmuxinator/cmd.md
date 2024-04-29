```shell
# Install rvm
curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm -v
rvm list
rvm use default --default 
# Install tmuxinator
gem -v
gem install tmuxinator

vi ~/.config/tmuxinator/ordx.yml
tmuxinator start ordx
```