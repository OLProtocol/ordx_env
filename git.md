
git add . && git commit -m "fix" && git push

git remote add origin git@github.com:tinyverse-web3/tvsconnect.git
git remote get-url origin
git fetch
git fetch --all
git remote -v
git reset --hard HEAD
git reset --hard 449da4b21ecbd17c991a5523e9235371bc977277^
git log -n 1 --pretty=format:%H
git config --global user.email "softwarecheng@126.com"
git config --global user.name "jackychen"
git submodule update --init
git submodule sync --recursive
git submodule update --init --recursive
git submodule add https://github.com/softwarecheng/clash clash

git pull origin main
git merge support_reorg
git push origin main
git push -u origin main

git fetch --tags
git fetch origin tag <tagname>
git ls-remote --tags origin
git checkout tags/0.2.0-release
git checkout -b new-branch-name tags/0.2.0-release

git branch --all
git branch -r
git remote show <remote-name>

