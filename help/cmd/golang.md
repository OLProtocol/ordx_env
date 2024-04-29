```shell
# install g
curl -sSL https://git.io/g-install | sh -s
gvm install 1.22.1
gvm set 1.22.1

# build
export GOOS=linux
export GOARCH=amd64
export CGO_ENABLED=0
go build 
```