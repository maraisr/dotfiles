#!/usr/bin/env fish

curl -fsSL https://fnm.vercel.app/install | bash

fnm install 18
fnm default 18

mkdir -p ~/.corepack

corepack enable --install-directory ~/.corepack

if not command -qs pnpm
    corepack prepare pnpm@7.0.1 --activate
end