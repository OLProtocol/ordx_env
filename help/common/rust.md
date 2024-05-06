```shell
# local
cargo build --release;
# cross for linux
# https://betterprogramming.pub/cross-compiling-rust-from-mac-to-linux-7fad5a454ab1
cargo build --target=x86_64-unknown-linux-gnu --release;
cross build --target x86_64-unknown-linux-gnu --release
cross build --target x86_64-pc-windows-gnu --release
cross build --target x86_64-pc-windows-gnu --release
cross build --target aarch64-unknown-linux-gnu --release
TARGET_CC=x86_64-unknown-linux-gnu cargo build --release --target x86_64-unknown-linux-gnu

cargo build --target x86_64-unknown-linux-musl
TARGET_CC=x86_64-linux-musl-gcc cargo build --release --target x86_64-unknown-linux-musl
```