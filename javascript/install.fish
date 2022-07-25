#!/usr/bin/env fish

curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

fnm install 18
fnm default 18

mkdir -p $HOME/.corepack

corepack enable --install-directory $HOME/.corepack
set -Ua fish_user_paths $HOME/.corepack

if not command -qs pnpm
    corepack prepare pnpm@7.6.0 --activate
end