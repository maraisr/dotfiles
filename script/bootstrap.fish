#!/usr/bin/env fish

set -Ux DOTFILES (pwd -P)

function success
	echo (set_color --bold green)'[ ✔ ]'(set_color normal) $argv
end

function abort
	echo (set_color --bold yellow)'[ 𐄂 ]'(set_color normal) $argv
	exit 1
end

for src in $DOTFILES/*/*.symlink
	ln -sf $src ~/.(basename $src .symlink)
		or abort 'failed to link config file'
end

for installer in */install.fish
	$installer
		and success $installer
		or abort $installer
end

if ! grep (command -v fish) /etc/shells
	command -v fish | sudo tee -a /etc/shells
		and success 'added fish to /etc/shells'
		or abort 'setup /etc/shells'
	echo
end

test (which fish) = $SHELL
	and success 'dotfiles installed/updated!'
	and exit 0

sudo chsh -s (which fish)
    and success set (fish --version) as the default shell
    or abort 'set fish as default shell'

success '🎉 dotfiles installed/updated!'
