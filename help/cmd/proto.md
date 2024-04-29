```shell
protoc-gen-go --version
protoc --go_out=. ./ordinals/indexer/pb/*.proto
protoc --go_out=paths=source_relative:. ./ordx/indexer/pb/*.proto
```