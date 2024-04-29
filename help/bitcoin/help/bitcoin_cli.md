Bitcoin Core RPC client version v25.0.0

Usage:  bitcoin-cli [options] <command> [params]  Send command to Bitcoin Core
or:     bitcoin-cli [options] -named <command> [name=value]...  Send command to Bitcoin Core (with named arguments)
or:     bitcoin-cli [options] help                List commands
or:     bitcoin-cli [options] help <command>      Get help for a command

Options:

  -?
       Print this help message and exit

  -addrinfo
       Get the number of addresses known to the node, per network and total,
       after filtering for quality and recency. The total number of
       addresses known to the node may be higher.

  -color=<when>
       Color setting for CLI output (default: auto). Valid values: always, auto
       (add color codes when standard output is connected to a terminal
       and OS is not WIN32), never.

  -conf=<file>
       Specify configuration file. Relative paths will be prefixed by datadir
       location. (default: bitcoin.conf)

  -datadir=<dir>
       Specify data directory

  -generate
       Generate blocks, equivalent to RPC getnewaddress followed by RPC
       generatetoaddress. Optional positional integer arguments are
       number of blocks to generate (default: 1) and maximum iterations
       to try (default: 1000000), equivalent to RPC generatetoaddress
       nblocks and maxtries arguments. Example: bitcoin-cli -generate 4
       1000

  -getinfo
       Get general information from the remote server. Note that unlike
       server-side RPC calls, the output of -getinfo is the result of
       multiple non-atomic requests. Some entries in the output may
       represent results from different states (e.g. wallet balance may
       be as of a different block from the chain state reported)

  -named
       Pass named instead of positional arguments (default: false)

  -netinfo
       Get network peer connection information from the remote server. An
       optional integer argument from 0 to 4 can be passed for different
       peers listings (default: 0). Pass "help" for detailed help
       documentation.

  -rpcclienttimeout=<n>
       Timeout in seconds during HTTP requests, or 0 for no timeout. (default:
       900)

  -rpcconnect=<ip>
       Send commands to node running on <ip> (default: 127.0.0.1)

  -rpccookiefile=<loc>
       Location of the auth cookie. Relative paths will be prefixed by a
       net-specific datadir location. (default: data dir)

  -rpcpassword=<pw>
       Password for JSON-RPC connections

  -rpcport=<port>
       Connect to JSON-RPC on <port> (default: 8332, testnet: 18332, signet:
       38332, regtest: 18443)

  -rpcuser=<user>
       Username for JSON-RPC connections

  -rpcwait
       Wait for RPC server to start

  -rpcwaittimeout=<n>
       Timeout in seconds to wait for the RPC server to start, or 0 for no
       timeout. (default: 0)

  -rpcwallet=<walletname>
       Send RPC for non-default wallet on RPC server (needs to exactly match
       corresponding -wallet option passed to bitcoind). This changes
       the RPC endpoint used, e.g.
       http://127.0.0.1:8332/wallet/<walletname>

  -stdin
       Read extra arguments from standard input, one per line until EOF/Ctrl-D
       (recommended for sensitive information such as passphrases). When
       combined with -stdinrpcpass, the first line from standard input
       is used for the RPC password.

  -stdinrpcpass
       Read RPC password from standard input as a single line. When combined
       with -stdin, the first line from standard input is used for the
       RPC password. When combined with -stdinwalletpassphrase,
       -stdinrpcpass consumes the first line, and -stdinwalletpassphrase
       consumes the second.

  -stdinwalletpassphrase
       Read wallet passphrase from standard input as a single line. When
       combined with -stdin, the first line from standard input is used
       for the wallet passphrase.

  -version
       Print version and exit

Debugging/Testing options:

Chain selection options:

  -chain=<chain>
       Use the chain <chain> (default: main). Allowed values: main, test,
       signet, regtest

  -signet
       Use the signet chain. Equivalent to -chain=signet. Note that the network
       is defined by the -signetchallenge parameter

  -signetchallenge
       Blocks must satisfy the given script to be considered valid (only for
       signet networks; defaults to the global default signet test
       network challenge)

  -signetseednode
       Specify a seed node for the signet network, in the hostname[:port]
       format, e.g. sig.net:1234 (may be used multiple times to specify
       multiple seed nodes; defaults to the global default signet test
       network seed node(s))

  -testnet
       Use the test chain. Equivalent to -chain=test.

