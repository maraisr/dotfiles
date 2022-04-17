#!/usr/bin/env fish

curl -fsSL https://get.volta.sh | bash

volta install node@latest

if not command -qs corepack
    volta install corepack
end

if not command -qs pnpm
    corepack prepare pnpm@6.22.2 --activate
end