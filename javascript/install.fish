#!/usr/bin/env fish

curl -fsSL https://get.volta.sh | bash

if not command -qs node
    volta install node@latest
end

if not command -qs corepack
    volta install corepack
end

if not command -qs pnpm
    corepack prepare pnpm@6.22.2 --activate
end