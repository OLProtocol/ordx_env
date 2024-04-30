#!/bin/bash
# set -x
set -e

# go get github.com/dgraph-io/badger/v4
# cd "$GOPATH/src/github.com/dgraph-io/badger"
# git fetch --all
# git checkout v4.2.0
# cd badger && go install

go get github.com/dgraph-io/badger/v4
cd "$GOPATH/pkg/mod/github.com/dgraph-io/badger/v4@v4.2.0"
cd badger && go install
