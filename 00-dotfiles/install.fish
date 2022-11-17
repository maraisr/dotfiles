#!/usr/bin/env fish

set -Ux EDITOR vim
set -Ux VISUAL $EDITOR

set -Ux PROJECTS ~/dev

mkdir -p $PROJECTS

for f in $DOTFILES/*/functions
	set -Up fish_function_path $f
end

mkdir -p ~/.config/fish/conf.d/

for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f ~/.config/fish/conf.d/(basename $f)
end
