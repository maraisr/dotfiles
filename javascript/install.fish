#!/usr/bin/env fish

curl -fsSL https://get.volta.sh | bash -s

~/.volta/bin/volta setup
source ~/.config/fish/config.fish

volta install node@latest
volta install pnpm@latest
