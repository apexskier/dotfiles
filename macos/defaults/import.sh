DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

for file in $(ls "$DIR"/*.plist)
do
    FILENAME=$(basename "$file")
    DOMAIN=${FILENAME%.*}

    diff <(defaults export $DOMAIN -) $file

    # cat $file | defaults import $DOMAIN -
done
