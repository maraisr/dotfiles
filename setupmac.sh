#!/bin/bash

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

