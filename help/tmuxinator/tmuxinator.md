```shell
# Install rvm 
# ubuntu 20
curl -sSL https://get.rvm.io | bash -s stable --ruby
rvm -v
rvm list
rvm use default --default 

# ununtu 22
sudo apt install ruby-full

# Install tmuxinator
gem -v
gem install tmuxinator

vi ~/.config/tmuxinator/ordx.yml
tmuxinator start ordx
```