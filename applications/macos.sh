#!/usr/bin/env bash
set -euo pipefail

echo "DEBUG: Starting macos.sh script"
done_file=~/.$(basename "${BASH_SOURCE[0]}").done
[ -f "$done_file" ] && echo "DEBUG: macos.sh already done, returning" && return


# Auto-update
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool true

# Hardware
## Keyboard
defaults write com.apple.HIToolbox AppleGlobalTextInputProperties -dict TextInputGlobalPropertyPerContextInput 1
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 25

## Mouse
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseTwoFingerDoubleTapGesture -int 0
defaults write -g AppleEnableMouseSwipeNavigateWithScrolls -bool true
defaults write -g CGDisableCursorLocationMagnification -bool true

## Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

## Sound
defaults write -g com.apple.sound.beep.feedback -int 1

# Finder
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Menu icons
defaults write com.apple.airplay showInMenuBarIfPresent -bool false
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/TextInput.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Misc
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write -g ApplePressAndHoldEnabled -bool false
## Disable smart dash/quote substitution
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true
defaults write -g WebAutomaticSpellingCorrectionEnabled -bool false

# iMessage and FaceTime
defaults write -app FaceTime RecentsFilterType -int 1
defaults write com.apple.imagent Setting.EnableReadReceipts -bool true

# Safari
echo "DEBUG: About to configure Safari settings"
# Close Safari and all related processes first to avoid preference file lock
killall Safari 2>/dev/null || true
killall SafariConfigurationSubscriber 2>/dev/null || true
killall SafariSafeBrowsing 2>/dev/null || true
killall SafariLaunchAgent 2>/dev/null || true
killall SafariNotificationAgent 2>/dev/null || true
killall SafariBookmarksSyncAgent 2>/dev/null || true
sleep 3
echo "DEBUG: Safari processes killed, starting Safari defaults configuration"

# Safari settings - using global domain to avoid sandbox restrictions
# Note: Some Safari-specific settings may not work due to sandbox restrictions
echo "DEBUG: Setting Safari preferences using global domain"
defaults write -g com.apple.Safari DidShowWhatsNewInSafari -bool true 2>/dev/null || echo "Warning: Could not set Safari DidShowWhatsNewInSafari"
defaults write -g com.apple.Safari HideStartPageFrecentsEmptyItemView -bool false 2>/dev/null || echo "Warning: Could not set Safari HideStartPageFrecentsEmptyItemView"
defaults write -g com.apple.Safari HideStartPageSiriSuggestionsEmptyItemView -bool false 2>/dev/null || echo "Warning: Could not set Safari HideStartPageSiriSuggestionsEmptyItemView"
defaults write -g com.apple.Safari ShowBackgroundImageInFavorites -bool false 2>/dev/null || echo "Warning: Could not set Safari ShowBackgroundImageInFavorites"
defaults write -g com.apple.Safari ShowCloudTabsInFavorites -bool false 2>/dev/null || echo "Warning: Could not set Safari ShowCloudTabsInFavorites"
defaults write -g com.apple.Safari ShowFavoritesBar -bool false 2>/dev/null || echo "Warning: Could not set Safari ShowFavoritesBar"
defaults write -g com.apple.Safari ShowPrivacyReportInFavorites -bool false 2>/dev/null || echo "Warning: Could not set Safari ShowPrivacyReportInFavorites"
defaults write -g com.apple.Safari ShowReadingListInFavorites -bool false 2>/dev/null || echo "Warning: Could not set Safari ShowReadingListInFavorites"
defaults write -g com.apple.Safari ShowSidebarInTopSites -bool false 2>/dev/null || echo "Warning: Could not set Safari ShowSidebarInTopSites"
defaults write -g com.apple.Safari ShowSiriSuggestionsPreference -bool false 2>/dev/null || echo "Warning: Could not set Safari ShowSiriSuggestionsPreference"

## Disable Google country redirection, opt out Google and Baidu targeted ads, install extensions
color_print "We will now open several websites in Safari. After configuring them, please quit Safari completely by pressing Cmd+Q." "${green}"
acknowledge
open -W -a Safari 'https://www.google.com/ncr' 'https://www.google.com/settings/ads' 'http://www.baidu.com/duty/safe_control.html'

## Developer
echo "DEBUG: Setting Safari developer preferences"
defaults write -g com.apple.Safari IncludeDevelopMenu -bool true 2>/dev/null || echo "Warning: Could not set Safari IncludeDevelopMenu"
defaults write -g com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true 2>/dev/null || echo "Warning: Could not set Safari WebKitDeveloperExtrasEnabledPreferenceKey"
defaults write -g com.apple.Safari "WebKitPreferences.developerExtrasEnabled" -bool true 2>/dev/null || echo "Warning: Could not set Safari WebKitPreferences.developerExtrasEnabled"

# Other OSX apps
defaults write -app "App Store" ASAcknowledgedOnboardingVersion -int 4
defaults write -app Calculator SeparatorsDefaultsKey -bool true
defaults write -app Calendar privacyPaneHasBeenAcknowledgedVersion -int 4
defaults write -app "Disk Utility" SidebarShowAllDevices -bool true
defaults write -app Notes hasShownWelcomeScreen -bool true
defaults write -app TextEdit RichText -int 0

touch "$done_file"
