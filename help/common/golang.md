```shell
# install g
curl -sSL https://git.io/g-install | sh -s
gvm install 1.22.1
gvm set 1.22.1
# tools
go install -v golang.org/x/tools/gopls@latest
go install -v github.com/cweill/gotests/gotests@latest
go install -v github.com/fatih/gomodifytags@latest
go install -v github.com/josharian/impl@latest
go install -v github.com/haya14busa/goplay/cmd/goplay@latest
go install -v github.com/go-delve/delve/cmd/dlv@latest
go install -v honnef.co/go/tools/cmd/staticcheck@latest
# github private
go env -w GOPRIVATE="github.com/{tinyverse-web3}/*"
echo '[url "git@github.com:{tinyverse-web3}/"]
	insteadOf = https://github.com/{tinyverse-web3}/' >> ~/.gitconfig
# build
export GOOS=linux
export GOARCH=amd64
export CGO_ENABLED=0
go build 
```