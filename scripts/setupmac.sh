#!/bin/bash

# Start with brew things
brew update
brew upgrade

brew install vim --override-system-vi
brew install git openssl jq yq fish watch

sudo pip install boto boto3 jinja2

# Mac specific things
defaults write com.apple.universalaccess reduceTransparency -bool true
defaults write com.apple.dock mru-spaces -bool true && \
	killall Dock
defaults write com.apple.dock no-bouncing -bool true && \
	killall Dock
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
	defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

./nix.sh # Runs my *nix things
./link.sh # Link all my config files into this home folder
