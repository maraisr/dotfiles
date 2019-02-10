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

if ! $(sudo xcodebuild -license status); then
  sudo xcodebuild -license accept
fi

# -- Homebrew --
if [[ ! -x /usr/local/bin/brew ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Setup brew

brew tap caskroom/cask
brew tap Homebrew/bundle
brew update
brew upgrade

# Install CLI tooling

brew install vim
brew install \
	git \
	openssl \
	jq \
	yq \
	watch \
	iproute2mac \
	telnet \
	bat

# Change shell to fish
brew install fish
chsh -s $(which fish)

# Install runtimes
brew install \
	node \
	yarn

brew cask install \
	java

# Install Desktop Applications
brew cask install \
		google-chrome \
		whatsapp \
		spotify \
		spotmenu \
		iterm2 \
		visual-studio-code \
		1password

# -- Mac AppStore --
brew install mas

mas install 1384080005		## Tweetbot 3
mas install 1333542190		##1Password 7
mas install 585829637		## Todoist

# Finally; we cleanup
brew cleanup; brew prune

# -----------------------------------
# [Mac] General UI/UX
# -----------------------------------

# Use DarkMode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Set apperance
defaults write NSGlobalDomain AppleAquaColorVariant -int 1

# Set highlight color to blue
defaults write NSGlobalDomain AppleHighlightColor -string '0.709800 0.835300 1.000000'

# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Enable transparency in the menu bar and elsewhere
defaults write com.apple.universalaccess reduceTransparency -bool false

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Set clock format
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d H:mm:ss"

# Play iOS charging sound when power is connected
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true && \
  open /System/Library/CoreServices/PowerChime.app &

# -----------------------------------
# [Mac] Finder
# -----------------------------------

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Finder: show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Don't save .DS_Store files to Network Shares + USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Default search scope
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Arrange by
# Kind, Name, Application, Date Last Opened,
# Date Added, Date Modified, Date Created, Size, Tags, None
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"

# -----------------------------------
# [Mac] Keyboard
# -----------------------------------

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

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

# -----------------------------------
# [Mac] Screen
# -----------------------------------

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# -----------------------------------
# [Mac] Dock
# -----------------------------------

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool true

# Remove app bounce
defaults write com.apple.dock no-bouncing -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Turn off dock magnification
defaults write com.apple.dock magnification -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Hot corners
# Bottom left screen corner → Show Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0

# -----------------------------------
# [Mac] Time Machine
# -----------------------------------

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal

# -----------------------------------
# [Mac] Activity Monitor
# -----------------------------------

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# -----------------------------------
# [Mac] App Store
# -----------------------------------

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# -----------------------------------
# [Mac] OpenGPG 2
# -----------------------------------

# Disable signing emails by default
defaults write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false

# -----------------------------------
# [Mac] Tweetbot
# -----------------------------------

# Bypass the annoyingly slow t.co URL shortener
defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

# Reboot everything
for app in "Dock" \
	"Terminal" \
	"SystemUIServer" \
	"Finder" \
	"cfprefsd"; do
	killall "${app}" &> /dev/null
done

./scripts/nix.sh # Runs my *nix things
./scripts/link.sh # Link all my config files into this home folder
