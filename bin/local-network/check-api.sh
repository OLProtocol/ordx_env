#!/bin/bash
# set -x
# set -e

function check_localnet_api_health() {
    local ip_address=$1
    local port=$2
    local network=$3
    printf 'http://%s:%s/%s/health\n' "$ip_address" "$port" "$network"
    curl --max-time 5 "http://$ip_address:$port/$network/health"
    printf '\n\n'
}

function check_internet_api_health() {
    local environment=$1
    local network=$2
    printf 'https://api%s.ordx.space/%s/health\n' "$environment" "$network"
    curl --max-time 10 "https://api$environment.ordx.space/$network/health"
    printf '\n\n'
}

# dev
function execute_dev() {
    printf 'check api for %s\n' dev
    local network_env=$1
    if [[ $network_env == "localnet" || $network_env == "" ]]; then
        check_localnet_api_health "192.168.10.103" "8005" "mainnet"
        check_localnet_api_health "192.168.10.103" "8009" "testnet4"
    fi
    if [[ $network_env == "internet" || $network_env == "" ]]; then
        check_internet_api_health "dev" "mainnet"
        check_internet_api_health "dev" "testnet4"
    fi
}

# test
function execute_test() {
    printf 'check api for %s\n' test
    local network_env=$1
    if [[ $network_env == "localnet" || $network_env == "" ]]; then
        check_localnet_api_health "192.168.10.102" "8003" "mainnet"
        check_localnet_api_health "192.168.10.102" "8008" "testnet4"
    fi
    if [[ $network_env == "internet" || $network_env == "" ]]; then
        check_internet_api_health "test" "mainnet"
        check_internet_api_health "test" "testnet4"
    fi
}

# prd
function execute_prd() {
    printf 'check api for %s\n' prd
    local network_env=$1
    if [[ $network_env == "localnet" || $network_env == "" ]]; then
        check_localnet_api_health "192.168.10.101" "8001" "mainnet"
        check_localnet_api_health "192.168.10.101" "8007" "testnet4"
    fi
    if [[ $network_env == "internet" || $network_env == "" ]]; then
        check_internet_api_health "prd" "mainnet"
        check_internet_api_health "prd" "testnet4"
    fi
}

if [[ $# -eq 0 ]]; then
    execute_dev
    execute_test
    execute_prd
else
    case $1 in
    dev)
        execute_dev "$2"
        ;;
    test)
        execute_test "$2"
        ;;
    prd)
        execute_prd "$2"
        ;;
    *)
        echo "Invalid argument: $1"
        exit 1
        ;;
    esac
fi
