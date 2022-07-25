#!/usr/bin/env fish

if test (uname) != Darwin
	exit
end

set -Ua fish_user_paths /usr/local/sbin /opt/homebrew/bin

if command -qs brew
	# Install Desktop Applications
	brew install --cask \
			google-chrome \
			firefox \
			whatsapp \
			discord \
			spotify \
			spotmenu \
			iterm2 \
			visual-studio-code \
			1password \
			notion

	brew cleanup
end

./mac/defaults.sh