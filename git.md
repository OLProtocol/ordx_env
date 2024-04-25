
git add . && git commit -m "fix" && git push

git remote add origin git@github.com:tinyverse-web3/tvsconnect.git
git remote get-url origin
git fetch
git fetch --all
git remote -v
git reset --hard HEAD
git reset --hard 449da4b21ecbd17c991a5523e9235371bc977277^
git log -n 1 --pretty=format:%H
git log -n 1 --pretty=format:%H
git config --global user.email "softwarecheng@126.com"
git config --global user.name "jackychen"
git submodule update --init

git pull origin main
git merge support_reorg
git push origin main
git push -u origin main

git fetch --tags
git ls-remote --tags origin
git checkout tags/0.2.0-release
git checkout -b new-branch-name tags/0.2.0-release

git branch --all
