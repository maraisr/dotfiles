#!/usr/bin/env fish

set -U fish_greeting

set -Ux DOTFILES (pwd -P)

for f in $DOTFILES/*/functions
	set -Up fish_function_path $f
end

for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f ~/.config/fish/conf.d/(basename $f)
end