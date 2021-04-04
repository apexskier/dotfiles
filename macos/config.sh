# test if we're on a Mac
if ! [ "$(uname -s)" == "Darwin" ]
then
    exit 0
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

if [ "$SHELL" != "/usr/local/bin/bash" ] && [ -f "/usr/local/bin/bash" ]
then
    if ! grep /usr/local/bin/bash /etc/shells
    then
        sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
    fi
    chsh -s /usr/local/bin/bash
fi

mkdir -p ~/Developer
touch ~/Developer/.metadata_never_index

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Remove Dropbox's green checkmark icons in Finder
file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# TODO: look into these

# Enable lid wakeup
# sudo pmset -a lidwake 1

# Restart automatically if the computer freezes
# sudo systemsetup -setrestartfreeze on

# enable vnc and remote desktop
# sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -off -restart -agent -privs -all -allowAccessFor -allUsers

# reload keyboard configuration
"$DIR/keyboard_config.sh"

# write defaults
"$DIR/defaults/write.sh"

# refresh things
killall -KILL SystemUIServer
