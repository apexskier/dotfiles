# test if we're on a Mac
if [ "$(uname -s)" == "Darwin" ]
then
    # configuration stuff
    # Sets reasonable OS X defaults.
    #
    # Or, in other words, set shit how I like in OS X.
    #
    # The original idea (and a couple settings) were grabbed from:
    #   https://github.com/mathiasbynens/dotfiles/blob/master/.osx
    #
    # Run ./set-defaults.sh and you'll be good to go.

    mkdir -p ~/Dev
    touch ~/Dev/.metadata_never_index

    # Enable press-and-hold for keys - used to be disabled in favor of key repeat.
    defaults write -g ApplePressAndHoldEnabled -bool true

    # Use AirDrop over every interface. srsly this should be a default.
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

    # Show the ~/Library folder.
    chflags nohidden ~/Library

    # Set a really fast key repeat.
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 20

    # Set the Finder prefs for showing a few different volumes on the Desktop.
    defaults write com.apple.Finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.Finder ShowRemovableMediaOnDesktop -bool true

    # Set up Safari for development.
    defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

    # Expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

    # Expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    # Automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

    # Trackpad: enable tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Increase sound quality for Bluetooth headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Set a blazingly fast keyboard repeat rate
    defaults write NSGlobalDomain KeyRepeat -int 0

    # Save screenshots to downloads
    defaults write com.apple.screencapture location -string "${HOME}/Downloads"

    # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
    defaults write com.apple.screencapture type -string "png"

    # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
    defaults write com.apple.Finder QuitMenuItem -bool true

    # Set the default location for new Finder windows
    # For other paths, use `PfLo` and `file:///full/path/here/`
    defaults write com.apple.Finder NewWindowTarget -string "PfLo"
    # defaults write com.apple.Finder NewWindowTargetPath -string "file://${HOME}/Dev/"

    # Finder: show path bar
    defaults write com.apple.Finder ShowPathbar -bool true

    # Finder: show status bar
    defaults write com.apple.Finder ShowStatusBar -bool true

    # Finder: allow text selection in Quick Look
    defaults write com.apple.Finder QLEnableTextSelection -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.Finder FXDefaultSearchScope -string "SCcf"

    # Disable the warning when changing a file extension
    defaults write com.apple.Finder FXEnableExtensionChangeWarning -bool false

    # Avoid creating .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.Finder OpenWindowForNewRemovableDisk -bool true

    # Use column view in all Finder windows by default
    # Four-letter codes for the other view modes: `Nlsv`, `icnv`, `clmv`, `Flwv`
    defaults write com.apple.Finder FXPreferredViewStyle "clmv"

    # Enable AirDrop over Ethernet and on unsupported Macs running Lion
    defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

    # Show the ~/Library folder
    chflags nohidden ~/Library

    # Remove Dropbox's green checkmark icons in Finder
    file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
    [ -e "${file}" ] && mv -f "${file}" "${file}.bak"

    # Expand the following File Info panes:
    # “General”, “Open with”, and “Sharing & Permissions”
    defaults write com.apple.Finder FXInfoPanesExpanded -dict \
        General -bool true \
        OpenWith -bool true \
        Privileges -bool true

    # Speed up Mission Control animations
    defaults write com.apple.dock expose-animation-duration -float 0.1

    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

    # Don't show Dashboard as a Space
    defaults write com.apple.dock dashboard-in-overlay -bool true

    # Make Dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true

    # hide dock
    defaults write com.apple.dock autohide -bool true

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
    # Top left screen corner: sleep display
    defaults write com.apple.dock wvous-tl-corner -int 10
    defaults write com.apple.dock wvous-tl-modifier -int 0
    # Top right screen corner: Notification center
    defaults write com.apple.dock wvous-tr-corner -int 12
    defaults write com.apple.dock wvous-tr-modifier -int 0
    # Bottom left screen corner: Launchpad
    defaults write com.apple.dock wvous-bl-corner -int 11
    defaults write com.apple.dock wvous-bl-modifier -int 0
    # Bottom right screen corner: Desktop
    defaults write com.apple.dock wvous-br-corner -int 4
    defaults write com.apple.dock wvous-br-modifier -int 0

    # Hide Safari's bookmarks bar by default
    defaults write com.apple.Safari ShowFavoritesBar -bool false

    # Enable Safari's debug menu
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    # Make Safari's search banners default to Contains instead of Starts With
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

    # Enable the Develop menu and the Web Inspector in Safari
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

    # Add a context menu item for showing the Web Inspector in web views
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

    # Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
    defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

    # Display emails in threaded mode, sorted by date (oldest at the top)
    defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
    defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedAscending" -string "yes"
    defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

    # Only use UTF-8 in Terminal.app
    defaults write com.apple.terminal StringEncodings -array 4

    # Prevent Time Machine from prompting to use new hard drives as backup volume
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Visualize CPU usage in the Activity Monitor Dock icon
    defaults write com.apple.ActivityMonitor IconType -int 5

    # Use plain text mode for new TextEdit documents
    defaults write com.apple.TextEdit RichText -int 0
    # Open and save files as UTF-8 in TextEdit
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

    # Enable the debug menu in Disk Utility
    defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
    defaults write com.apple.DiskUtility advanced-image-options -bool true

    # Allow installing user scripts via GitHub Gist or Userscripts.org
    defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
    defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"

    # Trash original torrent files
    defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

    # Hide the donate message
    defaults write org.m0k.transmission WarningDonate -bool false
    # Hide the legal disclaimer
    defaults write org.m0k.transmission WarningLegal -bool false
    # Don't prompt for confirmation before downloading
    defaults write org.m0k.transmission DownloadAsk -bool false
    # Use `~/Documents/Torrents` to store incomplete downloads
    defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
    defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Torrents"

    # enable vnc and remote desktop
    sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -off -restart -agent -privs -all -allowAccessFor -allUsers

    # Apple Calendar
    defaults write com.apple.iCal "number of hours displayed" -int 7
    defaults write com.apple.iCal "first day of week" -int 1

    # touch bar
    defaults write com.apple.controlstrip MiniCustomized "( \
        com.apple.system.brightness, \
        com.apple.system.volume, \
        com.apple.system.mute, \
        com.apple.system.screen-lock \
    )"
    killall ControlStrip

    # menu bar date and time
    defaults write com.apple.menuextra.clock "DateFormat" 'E, MMM d, hh:mm a'
    killall -KILL SystemUIServer
fi
