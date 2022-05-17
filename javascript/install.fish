#!/usr/bin/env fish

curl -fsSL https://fnm.vercel.app/install | bash

fnm install latest

corepack enable --install-directory ~/.corepack

if not command -qs pnpm
    corepack prepare pnpm@7.0.1 --activate
end