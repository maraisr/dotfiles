#!/usr/bin/env bash

# Ask for the sudo password up front
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# -- X Code --

if ! $(xcode-select -p &>/dev/null); then
  xcode-select --install &>/dev/null

  # Wait until the Xcode Command Line Tools are installed
  until $(xcode-select -p &>/dev/null); do
    sleep 5
  done
fi

# -- Homebrew --
if [[ ! -x /opt/homebrew/bin/brew ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Setup brew

brew update
brew upgrade

# Install CLI tooling

brew install vim
brew install \
	curl \
	wget \
	git \
	openssl \
	fzf \
	jq \
	yq \
	watch \
	iproute2mac \
	telnet \
	bat \
	watchman

# Change shell to fish
brew install fish
# echo $(which fish) >> /etc/shells
chsh -s $(which fish)

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

# -- Mac AppStore --
brew install mas

mas install 1384080005		## Tweetbot 3
mas install 1333542190		## 1Password 7

# -- Setup GPG --

brew install \
	gnupg \
	pinentry-mac

echo "pinentry-program $(which pinentry-program)" > ~/.gnupg/gpg-agent.conf

# Finally; we cleanup
brew cleanup

./mac/entry.sh
./vim/entry.sh

./setup/generic.sh
