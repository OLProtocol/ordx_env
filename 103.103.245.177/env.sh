#!/bin/bash
# set -x
# set -e

# password qWzRq98nCEv28Qb47Z

# sudo apt update
# sudo apt upgrade
# sudo apt install snapd

apt install tmux
apt install tmuxinator

# oh-my-zsh
sudo apt install zsh
zsh --version
chsh -s $(which zsh)
# scp /root/.zsh* root@103.234.53.68:/root/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# scp -r /root/.oh-my-zsh root@103.234.53.68:/root/
# scp -r /root/* root@103.234.53.68:/root/

# certbot
sudo snap install --classic certbot
certbot --version
sudo snap set certbot trust-plugin-with-root=ok
sudo snap install certbot-dns-cloudflare
# scp /etc/letsencrypt/cloudflare.ini root@103.234.53.68:/etc/letsencrypt/cloudflare.ini

# cron
(crontab -l 2>/dev/null; echo "0 23 25 * * certbot renew > /root/log/cron-certbot.log 2>&1") | crontab -
# crontab -e

# openresty
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/openresty.list
sudo apt update
sudo apt install openresty
openresty -v
sudo ln -sf /usr/local/openresty/nginx/conf /etc/openresty
# scp -r /etc/openresty/* root@103.234.53.68:/etc/openresty/

# web
# scp -r /var/www/*  root@103.234.53.68:/var/www/

# github 
# tmux attach-session -t github-runner
# tmux new -s github-runner
# cd /root/actions-runner/
# ./run.sh

# mole
# scp /etc/ssh/sshd_config root@103.234.53.68:/etc/ssh/sshd_config