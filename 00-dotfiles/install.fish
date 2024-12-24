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

for dir in $DOTFILES/*/.config
    set parent (basename (dirname $dir))
    mkdir -p ~/.config/$parent
    for file in $dir/*
        set filename (basename $file)
        if test -e ~/.config/$parent/$filename
            mv ~/.config/$parent/$filename ~/.config/$parent/$filename.backup
        end
        ln -sf $file ~/.config/$parent/$filename
    end
end

mkdir -p $PROJECTS
