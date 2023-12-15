set positional-arguments

watch +args='test':
cargo watch --clear --exec '{{args}}'

ci: clippy forbid
cargo fmt -- --check
cargo test --all
cargo test --all -- --ignored

fmt:
cargo fmt --all

clippy:
cargo clippy --all --all-targets -- -D warnings

lclippy:
cargo lclippy --all --all-targets -- -D warnings

deploy branch chain domain:

deploy-all: deploy-testnet deploy-signet deploy-signet deploy-mainnet

deploy-mainnet branch="master": (deploy branch "main" "ordinals.net")

deploy-signet branch="master": (deploy branch "signet" "signet.ordinals.net")

deploy-testnet branch="master": (deploy branch "testnet" "testnet.ordinals.net")

deploy-regtest branch="master": (deploy branch "regtest" "regtest.ordinals.net")

deploy-ord-dev branch="master" chain="main" domain="ordinals-dev.com": (deploy branch chain domain)

save-ord-dev-state domain="ordinals-dev.com":
$EDITOR ./deploy/save-ord-dev-state
scp ./deploy/save-ord-dev-state root@{{domain}}:~
ssh root@{{domain}} "./save-ord-dev-state"

log unit="ord" domain="ordinals.net":
ssh root@{{domain}} 'journalctl -fu {{unit}}'

test-deploy:
ssh-keygen -f ~/.ssh/known_hosts -R 192.168.1.106
vagrant up
ssh-keyscan 192.168.1.106 >> ~/.ssh/known_hosts
rsync -avz \
--delete \
--exclude .git \
--exclude target \
--exclude .vagrant \
--exclude index.redb \
. root@192.168.1.106:ord
ssh root@192.168.1.106 'cd ord && ./deploy/setup'

time-tests:
cargo +nightly test -- -Z unstable-options --report-time

profile-tests:
cargo +nightly test -- -Z unstable-options --report-time \
| sed -n 's/^test \(.*\) ... ok <\(.*\)s>/\2 \1/p' | sort -n \
| tee test-times.txt

fuzz:
#!/usr/bin/env bash
set -euxo pipefail
cd fuzz
while true; do
    cargo +nightly fuzz run transaction-builder -- -max_total_time=60
    cargo +nightly fuzz run runestone-decipher -- -max_total_time=60
    cargo +nightly fuzz run varint-decode -- -max_total_time=60
    cargo +nightly fuzz run varint-encode -- -max_total_time=60
done

decode txid:
bitcoin-cli getrawtransaction {{txid}} | xxd -r -p - | cargo run decode

open:
open http://localhost

doc:
cargo doc --all --open

prepare-release revision='master':
#!/usr/bin/env bash
set -euxo pipefail
git checkout {{ revision }}
git pull origin {{ revision }}
echo >> CHANGELOG.md
git log --pretty='format:- %s' >> CHANGELOG.md
$EDITOR CHANGELOG.md
$EDITOR Cargo.toml
VERSION=`sed -En 's/version[[:space:]]*=[[:space:]]*"([^"]+)"/\1/p' Cargo.toml | head -1`
cargo check
git checkout -b release-$VERSION
git add -u
git commit -m "Release $VERSION"
gh pr create --web

publish-release revision='master':
#!/usr/bin/env bash
set -euxo pipefail
rm -rf tmp/release
git clone https://github.com/ordinals/ord.git tmp/release
cd tmp/release
git checkout {{ revision }}
cargo publish
cd ../..
rm -rf tmp/release

publish-tag-and-crate revision='master':
#!/usr/bin/env bash
set -euxo pipefail
rm -rf tmp/release
git clone git@github.com:ordinals/ord.git tmp/release
cd tmp/release
git checkout {{revision}}
VERSION=`sed -En 's/version[[:space:]]*=[[:space:]]*"([^"]+)"/\1/p' Cargo.toml | head -1`
git tag -a $VERSION -m "Release $VERSION"
git push git@github.com:ordinals/ord.git $VERSION
cargo publish
cd ../..
rm -rf tmp/release

list-outdated-dependencies:
cargo outdated -R
cd test-bitcoincore-rpc && cargo outdated -R

update-modern-normalize:
curl \
https://raw.githubusercontent.com/sindresorhus/modern-normalize/main/modern-normalize.css \
> static/modern-normalize.css

download-log unit='ord' host='ordinals.net':
ssh root@{{host}} 'mkdir -p tmp && journalctl -u {{unit}} > tmp/{{unit}}.log'
rsync --progress --compress root@{{host}}:tmp/{{unit}}.log tmp/{{unit}}.log

download-index unit='ord' host='ordinals.net':
rsync --progress --compress root@{{host}}:/var/lib/{{unit}}/index.redb tmp/{{unit}}.index.redb

serve-docs: build-docs
open http://127.0.0.1:8080
python3 -m http.server --directory docs/build/html --bind 127.0.0.1 8080

build-docs:
#!/usr/bin/env bash
mdbook build docs -d build
for lang in "de" "fr" "es" "pt" "ru" "zh" "ja" "ko" "fil" "ar" "hi" "it"; do
    MDBOOK_BOOK__LANGUAGE=$lang \
    mdbook build docs -d build/$lang
    mv docs/build/$lang/html docs/build/html/$lang
done

update-changelog:
echo >> CHANGELOG.md
git log --pretty='format:- %s' >> CHANGELOG.md

update-mdbook-theme:
curl https://raw.githubusercontent.com/rust-lang/mdBook/v0.4.35/src/theme/index.hbs > docs/theme/index.hbs

audit-cache:
cargo run --package audit-cache
