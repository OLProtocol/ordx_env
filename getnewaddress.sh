curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getbestblockhash", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:18443/

curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:18443/

curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "createwallet", "params": ["test"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/

curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "getwalletinfo", "params": [""]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/

curl --user jacky:123456 --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "loadwallet", "params": ["testwallet"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/


curl --user myusername --data-binary '{"jsonrpc": "1.0", "id": "curltest", "method": "createwallet", "params": ["testwallet"]}' -H 'content-type: text/plain;' http://127.0.0.1:18443/