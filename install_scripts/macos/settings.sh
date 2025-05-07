#!/usr/bin/env bash

set -eu

if [[ "$(uname)" != "Darwin" ]] ; then
    log "ERROR" "This script is intended to be run on macOS only."
    exit 1
fi

### macOS settings

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

### General settings

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Expand save panel by default
# i.e. when saving files, the folder selection panel will be expanded by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Avoid creating `.DS_Store` files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Add dns servers to the network configuration
# To check `networksetup` dns settings, run: `networksetup -getdnsservers "Wi-Fi"`
networksetup -setdnsservers Wi-Fi 2001:4860:4860::8844 2001:4860:4860::8888 8.8.4.4 8.8.8.8

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

### Menu bar settings

# Show bluetooth in the menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

# Display battery level in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Display date, day, and time in the menu bar
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'

# Hide the Time Machine and Volume icons from the menu bar
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
        "/System/Library/CoreServices/Menu Extras/Volume.menu"
done

### Dock settings

# Automatically hide or show the Dock
defaults write com.apple.dock autohide -bool true

# Wipe all app icons from the Dock except for the Finder and Trash
defaults write com.apple.dock persistent-apps -array

# Set the icon size
defaults write com.apple.dock tilesize -int 20

# Magnificate the Dock
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 100

### Mission Control settings
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Bottom left screen corner → Launchpad
defaults write com.apple.dock wvous-bl-corner -int 11
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner → Show application windows 
defaults write com.apple.dock wvous-br-corner -int 3
defaults write com.apple.dock wvous-br-modifier -int 0

### Finder settings

# Show the full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Show Tab bar in Finder
defaults write com.apple.finder ShowTabView -bool true

# Show files with all extensions
defaults write -g AppleShowAllExtensions -bool true

# Put directories at the top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Show the ~/Library directory
chflags nohidden ~/Library

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

### Input settings

# Disable live conversion
defaults write com.apple.inputmethod.Kotoeri JIMPrefLiveConversionKey -bool false

# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable three finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true && \
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Trackpad speed
defaults write -g com.apple.trackpad.scaling 3

# Mouse speed
defaults write -g com.apple.mouse.scaling 0.5

# TODO:
# Decrease keyboard initial delay
# defaults write -g InitialKeyRepeat -int 15

# TODO:
# Decrease keyboard repeat rate
# defaults write -g KeyRepeat -int 6

# Use the Fn key as a standard function key
defaults write -g com.apple.keyboard.fnState -bool true

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Show language menu in the top right corner of the boot screen
sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

### Energy saving

# Enable lid wakeup
sudo pmset -a lidwake 1

# Restart automatically on power loss
sudo pmset -a autorestart 1

# Sleep the display after 5 minutes
sudo pmset -a displaysleep 5

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 5

### Screen settings

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

### Safari settings

# # Enable the `Develop` menu and the `Web Inspector`
# sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# sudo defaults write com.apple.Safari IncludeDevelopMenu -bool true
# sudo defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# # Enable `Debug` menu
# sudo defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# # Show the full URL in the address bar (note: this will still hide the scheme)
# sudo defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# # Add a context menu item for showing the `Web Inspector` in web views
# sudo defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# # Show Safari's Status Bar 
# sudo defaults write com.apple.Safari ShowStatusBar -bool true

### Photos

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

### Sound settings

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo "TODO: Set display resolution to maximum available resolution."
echo "TODO: Set keyboard repeat rate to fastest."
echo "TODO: Set keyboard initial delay to shortest."
echo "TODO: Set some security settings."
echo "And finally, to ensure that all changes take effect, restart your Mac."

for app in "Dock" \
	"Finder" \
    "SystemUIServer" \
	"Photos" \
	"Safari"; do
	killall "${app}" &> /dev/null
done
