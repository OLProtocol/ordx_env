#!/bin/bash
# set -x
set -e

# install rustc

if command -v rustc &>/dev/null; then
    echo "rustc is already installed"
else
    echo "preparing to install rustc"
    rm -rf "$HOME/.cargo/registry"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    # shellcheck disable=SC1091
    source "$HOME/.cargo/env"
    rustc --version
    rustup install 1.76.0
    rustup default 1.76.0
    # rustup show, rustup toolchain list
    OS=$(uname -s)
    if [ "$OS" = "Darwin" ]; then
        rustup target add x86_64-unknown-linux-gnu
        # GNU
        brew install SergioBenitez/osxct/x86_64-unknown-linux-gnu # linker
        # MUSL
        brew install FiloSottile/musl-cross/musl-cross
        # brew install gcc
        read -r -d '' CONFIG_CONTENT <<'EOF'
[target.x86_64-unknown-linux-gnu]
linker = "x86_64-linux-gnu-gcc"
EOF
        if [ ! -d "$HOME/.cargo" ]; then
            mkdir -p "$HOME/.cargo"
        fi
        CARGO_CONFIG="$HOME/.cargo/config.toml"
        if [ ! -f "$CARGO_CONFIG" ]; then
            echo "$CONFIG_CONTENT" >"$CARGO_CONFIG"
        else
            if ! grep -qF "[target.x86_64-unknown-linux-gnu]" "$CARGO_CONFIG"; then
                echo "$CONFIG_CONTENT" >>"$CARGO_CONFIG"
            fi
        fi
    else
        sudo apt install pkg-config libssl-dev build-essential
    fi
    echo "rust finish install"
fi
