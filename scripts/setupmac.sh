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

# Finder things
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
	defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# Key repeat rates
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# Don't save .DS_Store files to Network Shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# Home/End button remapped to begin/end of lines
mkdir -p ~/Library/KeyBindings/
if [[ ! -e /Scripts/file.txt ]]; then
	touch ~/Library/KeyBindings/DefaultKeyBinding.dict
	cat <<EOT >> ~/Library/KeyBindings/DefaultKeyBinding.dict
{
    "\UF729"  = moveToBeginningOfLine:; // home
    "\UF72B"  = moveToEndOfLine:; // end
    "$\UF729" = moveToBeginningOfLineAndModifySelection:; // shift-home
    "$\UF72B" = moveToEndOfLineAndModifySelection:; // shift-end
}
EOT
else
		echo "Error KeyBindings file already exists. Please check"
fi

./scripts/nix.sh # Runs my *nix things
./scripts/link.sh # Link all my config files into this home folder
