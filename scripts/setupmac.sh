#!/bin/bash

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

brew update
brew upgrade

brew install vim --override-system-vi
brew install openssl jq yq fish watch

sudo pip install boto boto3 jinja2

# Get Plug (Vim Plugin Manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Download fonts Fira Code for Powerline
curl -fLo ~/Library/Fonts/FuraMono-Regular-Powerline.otf \
	https://github.com/powerline/fonts/raw/master/FiraMono/FuraMono-Regular%20Powerline.otf

# Download Fira Code
curl -fLo ~/Library/Fonts/FiraCode-Retina.otf \
	https://github.com/tonsky/FiraCode/raw/master/distr/otf/FiraCode-Retina.otf