
```shell
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

# common merge
git pull origin main
git rebase main / git merge support_reorg
git push -u origin main

# new feature, squash and merge
git checkout -b new-feature
git diff
git add .
git commit -m "fix"
git push -u origin new-feature/ git push origin new-feature
git checkout main
git pull origin main
git checkout new-feature
git merge main / git rebase main # check conflict and merge
git add . && git commit -m "fix"
git push origin new-feature / git push -f origin new-feature ( -f option for rebase)

# new pull request : squash amd merge for main branch history cleanup
# merge pull request to main branch , option for squash and merge in github
git checkout main
git merge --squash new-feature
git add . && git commit -m "update for new feature" && git push origin main
git push origin --delete new-feature
git branch -D new-feature / git fetch -p # cleanup local branch

#ctrl + z to undo
# for no commit
git checkout <chahged_file> / git restore <changed_file>
# for git add
git reset <changed_file> / git restore --staged <changed_file>  # keep changed
git checkout --HEAD <changed_file> # for all file, delete all untracked files
# for commit
git reset --soft <commit_id> / git reset --soft HEAD~1 # undo commit and keep staged, for private branch, ex new-feature branch
git reset HEAD~1(git reset --mixed HEAD~1) # undo commit and add
git reset --hard <commit_id> / git reset --hard HEAD~1 # undo commit and untracked (allow restore deleted file)
git push -f # for reset
git revert <commit_id> / git revert HEAD~1  # get last commit and create new commit ,for public branch , ex remote main branch
git push # for revert

# tag
git fetch --tags
git fetch origin tag <tagname>
git ls-remote --tags origin
git checkout tags/0.2.0-release
git checkout -b new-branch-name tags/0.2.0-release

git branch --all
git branch -r
git branch -a
git remote show <remote-name>

git remote -v
git remote set-url origin https://github.com/OLProtocol/ordx_env.git
git remote -v
```