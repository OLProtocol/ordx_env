#!/bin/bash
# set -x
# set -e

# password qWzRq98nCEv28Qb47Z

# sudo apt update
# sudo apt install snapd

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

# cron
(crontab -l 2>/dev/null; echo "0 23 25 * * certbot renew > /root/log/cron-certbot.log 2>&1") | crontab -
# crontab -e
