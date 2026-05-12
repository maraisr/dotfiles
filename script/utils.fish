#!/usr/bin/env fish

function success
	echo (set_color --bold green)'[ ✔ ]'(set_color normal) $argv
end

function warn
	echo (set_color --bold yellow)'[ ! ]'(set_color normal) $argv
end

function abort
	echo (set_color --bold red)'[ 𐄂 ]'(set_color normal) $argv
	exit 1
end

function assume_sudo
	if sudo -n true 2>/dev/null
		return 0
	end
	warn 'caching sudo credentials — you may be prompted for your password'
	sudo -v
		or abort 'failed to cache sudo credentials'
end
