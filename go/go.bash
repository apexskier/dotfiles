function chgo() {
    local gotoolchain
    local gomodfile

    if [ "$1" == "local" ]
    then
        gotoolchain="local"
    elif [ -n "$1" ]
    then
        gotoolchain="go$1"
    elif gomodfile=$(file_in_tree go.mod)
    then
        gotoolchain="$(grep '^go ' "$gomodfile")"
        gotoolchain="go${gotoolchain:3}"
    fi

    export GOTOOLCHAIN="$gotoolchain"
}

chgo "local" # on shell start, set to go.mod version if available
