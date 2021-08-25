# uses my local credential helper to generate a plain-text docker config, that can be used in containers, for instance
function raw_docker_config() {
    storetype=$(jq -r .credsStore < ~/.docker/config.json)
    # https://github.com/docker/for-mac/issues/4100#issuecomment-648491451
    local FIRST
    echo '{'
    echo '    "auths": {'
    for registry in $(docker-credential-$storetype list | jq -r 'to_entries[] | .key'); do
        if [ ! -z $FIRST ]; then
            echo '        },'
        fi
        FIRST=true
        credential=$(echo $registry | docker-credential-$storetype get | jq -jr '"\(.Username):\(.Secret)"' | base64)
        echo '        "'$registry'": {'
        echo '            "auth": "'$credential'"'
    done
    echo '        }'
    echo '    }'
    echo '}'
}
