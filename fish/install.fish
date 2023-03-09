#!/usr/bin/env fish

touch ~/.config/fish/config.fish

set -U fish_greeting

curl -sL https://git.io/fisher | source
ln -sf $DOTFILES/fish/fish_plugins ~/.config/fish/fish_plugins
fisher update
