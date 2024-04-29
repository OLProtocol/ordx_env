```shell
sudo systemctl enable ipfs
sudo systemctl start ipfs
service ipfs status
ipfs ipfs pin ls --type recursive QmeiFkJgYhvH2oPe9EpiQ6maUzHJkVMs8R7sDyFjTuLij6
ipfs pin ls --type recursive QmeiFkJgYhvH2oPe9EpiQ6maUzHJkVMs8R7sDyFjTuLij6
ipfs cat QmeiFkJgYhvH2oPe9EpiQ6maUzHJkVMs8R7sDyFjTuLij6
ipfs cat 12D3KooWC49xPG3wryaCvYVo4Nc1vRcMcMv4BskcRxE6arDP77f8  --cid-version 1
ipfs add --pin=false ./QmXjWqTfzPZtvcq6dY3XFtukzSqt63tQ6wvxbebKr5dzrC
ipfs object links QmYwUTHmdDzHKFY9o68W7VrPqcCzr72RVdnNpHYw5yBrtU
ipfs block get QmaxC5QYd6iaugwm6knbvY7BB3uUbiXJ1h1s5XR1XrVMmB
ipfs add ./random-file
ipfs routing findprovs QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs dht provide QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs routing findprovs QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs cid format -v 1 -b base32 QmZsRP7e6o1EaQsNYVMsviPEphmDviNU4gT6fk4NwMcT9p
ipfs pin remote add --service=nftstorage --name=test  QmdGryWJdj2pDYKNJh59cQJjaQ3Eddn8sfCVoCXS4Y639Y
ipfs pin remote ls --service=nftstorage
ipfs pin remote service rm ntfstorage4
ipfs add random-file --cid-version 1
ipfs pin remote ls --service=nftstorage4
ipfs get QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs swarm addrs listen
ipfs swarm peering ls
ipfs stats repo
ipfs swarm peers
ipfs swarm peers --identify
ipfs pubsub peers
ipfs p2p stream ls
ipfs refs local
ipfs stats bitswap
ipfs stats dht | grep QmXBJabTPtXPvviCWpbWj8eJK6V5g5LKui8is8bVCuVx2c
ipfs stats provide
ipfs repo stat
ipfs swarm connect QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ
ipfs swarm connect /ip4/104.131.131.82/tcp/4001/p2p/QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "POST"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://103.103.245.177:5001", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
ipfs repo gc
```