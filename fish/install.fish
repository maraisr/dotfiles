#!/usr/bin/env fish

touch ~/.config/fish/config.fish

set -U fish_greeting

set -Ux DOTFILES (pwd -P)

for f in $DOTFILES/*/functions
	set -Up fish_function_path $f
end

mkdir -p ~/.config/fish/conf.d/

for f in $DOTFILES/*/conf.d/*.fish
	ln -sf $f ~/.config/fish/conf.d/(basename $f)
end

# omf 
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install nai