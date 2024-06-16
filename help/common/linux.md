```shell
# privileged
sudo su
passwd
chmod +x {cmd.sh}
# version
lsb_release -a
uname -s
# name
sudo hostnamectl set-hostname dev-server
# zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source ~/.zshrc
# crontab
crontab -e
```

# 
disown