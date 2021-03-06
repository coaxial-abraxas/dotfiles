#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# Inspired from https://github.com/herrbischoff/awesome-osx-command-line/blob/master/launchagents.md (in parts)

# Do not run script if not root
if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as an administrator\n" 1>&2
   exit 1
fi

printf "Will now configure OS X and apps.\n"

##############################################
#                   UI/UX                    #
##############################################

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Expand print panel
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true && \
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable local Time Machine snapshots
sudo tmutil disable


##############################################
#        Trackpad, mouse and friends         #
##############################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Use scroll gesture with the Cmd modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -int 1048576
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "fr"
defaults write NSGlobalDomain AppleLocale -string "en_CA"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# 24 hours clock
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Flash time separator
defaults write com.apple.menuextra.clock FlashDateSeparators -bool true

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Faster KeyRepeat
defaults write NSGlobalDomain KeyRepeat -int 0
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable long press for accentuated chars
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

##############################################
#                   Screen                   #
##############################################

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"


##############################################
#                   Finder                   #
##############################################

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# And on USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Enable AirDrop over Ethernet and for unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Dark Finder menu bar
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Disable opening the Photo app on plugging a camera (this is not Windows...)
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


##############################################
#           Dock, hot corners etc            #
##############################################

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Hot corners
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
#
# Top left screen corner → Desktop
defaults write com.apple.dock wvous-tl-corner -int 4
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom left screen corner → Put display to sleep
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0


##############################################
#                   iTerm2                   #
##############################################

# Use a custom prefs file
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/dotfiles"


##############################################
#             Security & Privacy             #
##############################################

# Enable FileVault
if fdesetup status | grep Off > /dev/null
then
	sudo fdesetup enable
fi

# Allow Mac App Store and signed apps
spctl --enable --label "Developer ID"

# Destroy FileVault keys on standby
# Disabled because it borks things
pmset destroyfvkeyonstandby 0

# Enable firewall, let signed apps through
/usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
defaults write /Library/Preferences/com.apple.alf globalstate -int 1

# Ask for password after 5 seconds of screen saver
defaults -currentHost write com.apple.screensaver askForPasswordDelay -int 5


##############################################
#                Time Machine                #
##############################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


##############################################
#              Activity Monitor              #
##############################################

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 6

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Higher update frequency
defaults write com.apple.ActivityMonitor UpdatePeriod -int 0


##############################################
#                   Mail                     #
##############################################

# Show attachments as icons
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true


##############################################
#                 Post setup                 #
##############################################

printf "Setup script done running. Changes will take effect after restart.\n"
printf "See ./checklist.md for the next steps.\n"
