#!/usr/bin/env fish

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

set -Ua fish_user_paths $HOME/.cargo/bin