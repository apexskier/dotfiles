# Remap some keyboard keys

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# https://apple.stackexchange.com/questions/13598/updating-modifier-key-mappings-through-defaults-command-tool

# this doesn't work for me, possibly due to being on Catalina
#
# PRODUCT_ID=$(ioreg -r -a \
#     -n 'Apple Internal Keyboard / Trackpad' \
#     -c IOUSBDevice \
#     -p IOUSB \
#     | \
#     plutil -extract 0.idProduct xml1 -o - - \
#     | \
#     xmllint --xpath 'string(/plist/integer)' -)
#
# VENDOR_ID=$(ioreg -r -a \
#     -n 'Apple Internal Keyboard / Trackpad' \
#     -c IOUSBDevice \
#     -p IOUSB \
#     | \
#     plutil -extract 0.idVendor xml1 -o - - \
#     | \
#     xmllint --xpath 'string(/plist/integer)' -)
#
# DOMAIN="com.apple.keyboard.modifiermapping.$VENDOR_ID-$PRODUCT_ID-0"
#
# defaults -currentHost write -g $DOMAIN -array-add "$(cat "$DIR/keyboard_modifiers.xml" | XMLLINT_INDENT='' xmllint --format - | tr -d '\n')"

# This isn't reflected in system preferences for modifier keys, we'll see how it works
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html

# 1. Caps lock to escape
US_MAPPINGS=$(cat << EOM
{
    "UserKeyMapping":[
        {
            "HIDKeyboardModifierMappingSrc":0x700000039,
            "HIDKeyboardModifierMappingDst":0x700000029
        }
    ]
}
EOM
)

# 1. Caps lock to escape
# 2. §£ to `~
# 3. `~ to Left Shift
EU_MAPPINGS=$(cat << EOM
{
    "UserKeyMapping":[
        {
            "HIDKeyboardModifierMappingSrc":0x700000039,
            "HIDKeyboardModifierMappingDst":0x700000029
        },
        {
            "HIDKeyboardModifierMappingSrc":0x700000064,
            "HIDKeyboardModifierMappingDst":0x700000035
        },
        {
            "HIDKeyboardModifierMappingSrc":0x700000035,
            "HIDKeyboardModifierMappingDst":0x7000000E1
        }
    ]
}
EOM
)

# not using yet
# 4. \| to Enter
# 5. Enter to \|
<<EOM
        {
            "HIDKeyboardModifierMappingSrc":0x700000031,
            "HIDKeyboardModifierMappingDst":0x700000028
        },
        {
            "HIDKeyboardModifierMappingSrc":0x700000028,
            "HIDKeyboardModifierMappingDst":0x700000031
        }
EOM

# https://stackoverflow.com/a/57296366/2178159
PHYSICAL_KEYBOARD=$(ioreg -a -r -k KeyboardLanguage | plutil -extract 0.KeyboardLanguage xml1 -o - - | xmllint --xpath 'string(/plist/string)' -)

case "$PHYSICAL_KEYBOARD" in
    "US International Keyboard")
        MAPPINGS="$EU_MAPPINGS"
        ;;
    "U.S.")
        MAPPINGS="$US_MAPPINGS"
        ;;
    *)
        echo "Unknown keyboard language $PHYSICAL_KEYBOARD"
        exit 1
        ;;
esac

hidutil property -s "$MAPPINGS" > /dev/null
