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
			spotify \
			spotmenu \
			iterm2 \
			visual-studio-code \
			1password \
			notion

	# AppStore
	brew install mas

	mas install 1384080005		## Tweetbot 3
	mas install 1333542190		## 1Password 7

	brew cleanup
end

./mac/defaults.sh