#!/usr/bin/env fish

curl -fsSL https://get.volta.sh | bash

volta install node@latest
volta install corepack

corepack prepare pnpm@6.22.2 --activate