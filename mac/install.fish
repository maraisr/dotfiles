#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

if command -qs brew
    set -Ua fish_user_paths /usr/local/sbin /opt/homebrew/bin

	# Install Desktop Applications
	brew install --cask google-chrome
	brew install --cask firefox
	brew install --cask discord
	brew install --cask spotify
	brew install --cask visual-studio-code
	brew install --cask 1password
	brew install --cask notion
	brew install --cask stats
end

./mac/defaults.sh
