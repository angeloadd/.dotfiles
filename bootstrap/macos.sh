# Here will go options for `defaults` custom settings on macOS

# Dark theme configurations
defaults write -g NSRequiresAquaSystemAppearance -bool No
defaults write -g NSRequiresAquaSystemAppearance -bool Yes

### HotCorners ###
# Hot corner bottom left to Desktop
defaults write com.apple.dock wvous-bl-corner -int "4"
defaults write com.apple.dock wvous-bl-modifier -int "0"
### HotCorners ###

### Dock ###
# Remove latency for animation of Dock
sudo defaults write com.apple.dock "autohide-time-modifier" -float "0" && killall Dock
# Set autohide to small value for quick disappearance but not instantly
sudo defaults write com.apple.dock "autohide-delay" -float "0.2" && killall Dock
# Hide recents app
sudo defaults write com.apple.dock "show-recents" -bool "false" && killall Dock
### Dock ###

### Trackpad ###
# Enable single click for selection
defaults write com.apple.AppleMultitouchTrackpad "Clicking" -int "1"
### Trackpad ###

### Keyboard ###
# Enable F keys default behaviour
defaults write com.apple.keyboard.fnState -bool Yes

# Remap backtick and tilde to topleft key ###
# Put RemapBackTic.app in login app or run this command in console
# hidutil property --set '{"UserKeyMapping":
#       [{"HIDKeyboardModifierMappingSrc":0x700000035,
#         "HIDKeyboardModifierMappingDst":0x700000064},
#        {"HIDKeyboardModifierMappingSrc":0x700000064,
#         "HIDKeyboardModifierMappingDst":0x700000035}]
#   }'
### Keyboard ###

### Enable press and hold for special chars popup ###
#defaults write -g ApplePressAndHoldEnabled -bool true

### Show hidden files ###
defaults write com.apple.Finder AppleShowAllFiles true