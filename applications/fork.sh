#!/usr/bin/env bash
set -euo pipefail

done_file="$HOME/.$(basename ${BASH_SOURCE[0]}).done"

if [ -f "$done_file" ]; then
    return
fi

color_print "[ Installing Fork ]" $yellow   

brew_cask_install fork

get_user_info

defaults write com.DanPristupov.Fork createInteractiveRabaseBackup -bool false
defaults write com.DanPristupov.Fork defaultSourceFolder -string "$HOME/Projects"
defaults write com.DanPristupov.Fork disableAnonymousUsageReports -bool true
defaults write com.DanPristupov.Fork diffFontName -string "Menlo-Regular"
defaults write com.DanPristupov.Fork diffFontSize -int 10
defaults write com.DanPristupov.Fork diffIgnoreWhitespaces -bool true
defaults write com.DanPristupov.Fork fetchSheetFetchAllTags -bool true
defaults write com.DanPristupov.Fork fetchSheetPrune -bool true
defaults write com.DanPristupov.Fork fileListMode -int 1
defaults write com.DanPristupov.Fork globalUserEmail -string "${user_email}"
defaults write com.DanPristupov.Fork globalUserFullName -string "${user_name}"
defaults write com.DanPristupov.Fork pushSheetPushAllTags -bool false
defaults write com.DanPristupov.Fork terminalClient -int 1
defaults write com.DanPristupov.Fork SUAutomaticallyUpdate -bool true
defaults write com.DanPristupov.Fork SUEnableAutomaticChecks -bool true

touch "$done_file"
