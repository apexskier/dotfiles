# this is just some mucking around with sharing macos preferences
# use it as inspiration, not directly
#
# ideas
# - defaults often contain timestamps or recents stuff. I like having full plist
#   files but don't want everything produced in an export. Can I "merge" plists
#   for use in import?
# - I'd like to split everything in ../config.sh into domain specific plists since
#   it's so huge. Can I use plutil to read and defaults to write to get a
#   "merge" like feature?


DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

for file in $(ls "$DIR"/*.plist)
do
    FILENAME=$(basename "$file")
    DOMAIN=${FILENAME%.*}

    diff <(defaults export $DOMAIN -) $file

    # cat $file | defaults import $DOMAIN -
done
