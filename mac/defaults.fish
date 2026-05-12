#!/usr/bin/env fish
source ./script/utils.fish

assume_sudo

# -----------------------------------
# Security & Auth
# -----------------------------------

echo " ~› Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo " ~› Disable the \"Are you sure you want to open this application?\" dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# -----------------------------------
# Performance
# -----------------------------------

echo " ~› Disable hibernation (speeds up entering sleep mode)"
sudo pmset -a hibernatemode 0

echo " ~› Remove the sleep image file to save disk space"
sudo rm -f /private/var/vm/sleepimage
echo " ~› Create a zero-byte file instead..."
sudo touch /private/var/vm/sleepimage
echo " ~› ...and make sure it can't be rewritten"
sudo chflags uchg /private/var/vm/sleepimage

echo " ~› Disable the sudden motion sensor as it's not useful for SSDs"
sudo pmset -a sms 0

echo " ~› Speed up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

echo " ~› Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

echo " ~› Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo " ~› Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.dock "expose-group-by-app" -bool true

echo " ~› Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo " ~› Enable subpixel font rendering on non-Apple LCDs"
# https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# -----------------------------------
# UI & Appearance
# -----------------------------------

echo " ~› Appearance: Auto (light/dark follows time of day)"
defaults delete NSGlobalDomain AppleInterfaceStyle >/dev/null 2>&1
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

#  Accent colour
#  this setting defines two properties:
#    - AppleAccentColor
#    - AppleAquaColorVariant
#  it also presets AppleHighlightColor, but this can be overriden
#
#  note that AppleAquaColorVariant is alway "1" except for "Graphite", where it is "6".
#  note that the AccentColor "Blue" is default (when there is no entry) and has no AppleHighlightColor definition.
#
#  Color    AppleAquaColorVariant    AccentColor    AppleHighlightColor
#    Red            1                   0           "1.000000 0.733333 0.721569 Red"
#    Orange         1                   1           "1.000000 0.874510 0.701961 Orange"
#    Yellow         1                   2           "1.000000 0.937255 0.690196 Yellow"
#    Green          1                   3           "0.752941 0.964706 0.678431 Green"
#    Purple         1                   5           "0.968627 0.831373 1.000000 Purple"
#    Pink           1                   6           "1.000000 0.749020 0.823529 Pink"
#    Blue           1                   deleted     deleted
#    Graphite       6                   -1          "0.847059 0.847059 0.862745 Graphite"
echo " ~› Appearance: UI colours"
# Colour accent (uncomment, and remove the delete lines below it)
# defaults write -globalDomain AppleAccentColor -int 6
defaults delete -globalDomain AppleAccentColor >/dev/null 2>&1

defaults write -globalDomain AppleAquaColorVariant -int 1
defaults write -globalDomain AppleHighlightColor -string "1.000000 0.749020 0.823529 Pink"

echo " ~› Always show scrollbars"
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

echo " ~› Small sidebar icons"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

echo " ~› Show battery percentage"
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

echo " ~› Set clock format EEE MMM d H:mm:ss"
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d H:mm:ss"

echo " ~› Set the icon size of Dock items for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 40

echo " ~› Disable dock magnification"
defaults write com.apple.dock magnification -bool false

echo " ~› Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

# -----------------------------------
# Input (mouse, trackpad, keyboard)
# -----------------------------------

echo " ~› Set up trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo " ~› Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo " ~› Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo " ~› Enable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

echo " ~› Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

# Home/End button remapped to begin/end of lines
mkdir -p ~/Library/KeyBindings/
if not test -e ~/Library/KeyBindings/DefaultKeyBinding.dict
	echo '{
    "\UF729"  = moveToBeginningOfLine:; // home
    "\UF72B"  = moveToEndOfLine:; // end
    "$\UF729" = moveToBeginningOfLineAndModifySelection:; // shift-home
    "$\UF72B" = moveToEndOfLineAndModifySelection:; // shift-end
}' > ~/Library/KeyBindings/DefaultKeyBinding.dict
else
	echo "KeyBindings file already exists, skipping"
end

# -----------------------------------
# Finder
# -----------------------------------

echo " ~› Show the ~/Library folder"
chflags nohidden ~/Library

echo " ~› Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo " ~› Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo " ~› Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo " ~› Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo " ~› Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo " ~› Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo " ~› Save to disk by default, instead of iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo " ~› Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo " ~› Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo " ~› Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo " ~› Don't save .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo " ~› Don't save .DS_Store files on USB volumes"
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo " ~› Use list view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Nlsv = List, icnv = Icon, clmv = Column, Flwv = Gallery

echo " ~› Set the Finder settings for showing a few different volumes on the Desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo " ~› Search scope to current folder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Possible values; This Mac (SCev), Current Folder (SCcf), Previous Scope (SCsp)

echo " ~› Array by Kind"
defaults write com.apple.finder FXPreferredGroupBy -string "Kind"
# Kind, Name, Application, Date Last Opened,
# Date Added, Date Modified, Date Created, Size, Tags, None

echo " ~› Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
	-kill -r -domain local -domain system -domain user

# -----------------------------------
# Dock & Mission Control
# -----------------------------------

echo " ~› Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo " ~› Disable app bounce"
defaults write com.apple.dock no-bouncing -bool true

echo " ~› Keep the Dock always visible"
defaults write com.apple.dock autohide -bool false

echo " ~› Show only open applications in the Dock"
defaults write com.apple.dock static-only -bool true

echo " ~› Set hot corners, bottom left -> show desktop"
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0

# -----------------------------------
# Networking & System Services
# -----------------------------------

echo " ~› Use AirDrop over every interface"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

echo " ~› Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo " ~› Enable the automatic update check"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

echo " ~› Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo " ~› Download newly available updates in background"
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

echo " ~› Turn on app auto-update"
defaults write com.apple.commerce AutoUpdate -bool true

echo " ~› Play iOS charging sound when power is connected"
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true
  and open /System/Library/CoreServices/PowerChime.app &

# -----------------------------------
# Printing
# -----------------------------------

echo " ~› Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo " ~› Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# -----------------------------------
# Apps
# -----------------------------------

echo " ~› Hide Safari's bookmark bar"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo " ~› Set up Safari for development"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo " ~› Add the keyboard shortcut CMD + Enter to send an email"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

echo " ~› Add the keyboard shortcut CMD + Shift + E to archive an email"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Archive" '@$e'

echo " ~› Disable smart quotes as it's annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo " ~› Set email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>'"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo " ~› Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

echo " ~› Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

echo " ~› Disable send and reply animations in Mail.app"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

echo " ~› Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo " ~› Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

echo " ~› Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo " ~› Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

echo " ~› Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# -----------------------------------
# GPG
# -----------------------------------

echo " ~› Disable signing emails by default"
defaults write ~/Library/Preferences/org.gpgtools.gpgmail SignNewEmailsByDefault -bool false

# -----------------------------------
# Reboot everything
# -----------------------------------

for app in "Activity Monitor" Safari Mail Dock Terminal SystemUIServer Finder cfprefsd
	killall $app >/dev/null 2>&1
end
