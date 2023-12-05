1 bitcoin

#developer

https://developer.bitcoin.org/examples/testing.html
https://developer.bitcoin.org/reference/rpc/index.html


2 ord
Usage: ord [OPTIONS] <COMMAND>

Commands:
  balances  List all rune balances
  decode    Decode a transaction
  epochs    List the first satoshis of each reward epoch
  find      Find a satoshi's current location
  index     Index commands
  list      List the satoshis in an output
  parse     Parse a satoshi from ordinal notation
  preview   Run an explorer server populated with inscriptions
  runes     List all runes
  server    Run the explorer server
  subsidy   Display information about a block's subsidy
  supply    Display Bitcoin supply information
  teleburn  Generate teleburn addresses
  traits    Display satoshi traits
  wallet    Wallet commands
  help      Print this message or the help of the given subcommand(s)

Options:
      --bitcoin-data-dir <BITCOIN_DATA_DIR>
          Load Bitcoin Core data dir from <BITCOIN_DATA_DIR>.
      --bitcoin-rpc-pass <BITCOIN_RPC_PASS>
          Authenticate to Bitcoin Core RPC with <RPC_PASS>.
      --bitcoin-rpc-user <BITCOIN_RPC_USER>
          Authenticate to Bitcoin Core RPC as <RPC_USER>.
      --chain <CHAIN_ARGUMENT>
          Use <CHAIN>. [default: mainnet] [possible values: mainnet, testnet, signet, regtest]
      --config <CONFIG>
          Load configuration from <CONFIG>.
      --config-dir <CONFIG_DIR>
          Load configuration from <CONFIG_DIR>.
      --cookie-file <COOKIE_FILE>
          Load Bitcoin Core RPC cookie file from <COOKIE_FILE>.
      --data-dir <DATA_DIR>
          Store index in <DATA_DIR>.
      --db-cache-size <DB_CACHE_SIZE>
          Set index cache to <DB_CACHE_SIZE> bytes. By default takes 1/4 of available RAM.
      --first-inscription-height <FIRST_INSCRIPTION_HEIGHT>
          Don't look for inscriptions below <FIRST_INSCRIPTION_HEIGHT>.
      --height-limit <HEIGHT_LIMIT>
          Limit index to <HEIGHT_LIMIT> blocks.
      --index <INDEX>
          Use index at <INDEX>.
      --index-runes-pre-alpha-i-agree-to-get-rekt
          Track location of runes. RUNES ARE IN AN UNFINISHED PRE-ALPHA STATE AND SUBJECT TO CHANGE AT ANY TIME.
      --index-sats
          Track location of all satoshis.
  -r, --regtest
          Use regtest. Equivalent to `--chain regtest`.
      --rpc-url <RPC_URL>
          Connect to Bitcoin Core RPC at <RPC_URL>.
  -s, --signet
          Use signet. Equivalent to `--chain signet`.
  -t, --testnet
          Use testnet. Equivalent to `--chain testnet`.
      --wallet <WALLET>
          Use wallet named <WALLET>. [default: ord]
  -h, --help
          Print help
  -V, --version
          Print version


ord --wallet test --bitcoin-data-dir E:\bitcoin wallet create