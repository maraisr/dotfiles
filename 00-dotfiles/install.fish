#!/usr/bin/env fish

# =========
# Variables
# =========

set -Ux EDITOR vim
set -Ux VISUAL $EDITOR

set -Ux PROJECTS ~/dev

# =========
# Functions
# =========

for f in $DOTFILES/*/functions
	set -Up fish_function_path $f
end

# =======
# Configs
# =======

mkdir -p ~/.config/fish/conf.d/

for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f ~/.config/fish/conf.d/(basename $f)
end


mkdir -p $PROJECTS