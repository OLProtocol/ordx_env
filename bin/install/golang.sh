#!/bin/bash
# set -x
set -e

# golang,
echo "must input alias name with gvm"
curl -sSL https://git.io/g-install | sh -s
gvm install 1.22.1
gvm set 1.22.1
go install -v golang.org/x/tools/gopls@latest
go install -v github.com/cweill/gotests/gotests@latest
go install -v github.com/fatih/gomodifytags@latest
go install -v github.com/josharian/impl@latest
go install -v github.com/haya14busa/goplay/cmd/goplay@latest
go install -v github.com/go-delve/delve/cmd/dlv@latest
go install -v honnef.co/go/tools/cmd/staticcheck@latest