#!/usr/bin/env bash

set +e

# Ask for the sudo password up front
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# XCode things

if ! $(xcode-select -p &>/dev/null); then
  xcode-select --install &>/dev/null

  # Wait until the Xcode Command Line Tools are installed
  until $(xcode-select -p &>/dev/null); do
    sleep 5
  done
fi

# Install Homebrew
if [[ ! -x /opt/homebrew/bin/brew ]]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Setup brew

brew update
brew upgrade

# Install deps

brew install vim
brew install \
	curl \
	wget \
	gh \
	git-delta \
	git \
	openssl \
	fzf \
	jq \
	yq \
	watch \
	iproute2mac \
	telnet \
	bat \
	watchman \
	fish \
	gnupg \
	pinentry-mac \
	zoxide
