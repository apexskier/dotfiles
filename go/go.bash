function chgo() {
    local version
    local gomodfile

    if [ -n "$1" ]
    then
        version="$1"
    elif gomodfile=$(file_in_tree go.mod)
    then
        version="$(grep '^go ' "$gomodfile")"
        version="${version:3}"
    fi

    export GOTOOLCHAIN="go$version"
}

chgo "" # on shell start, set to go.mod version if available