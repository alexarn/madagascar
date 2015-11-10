#!/bin/bash
# ./multi-bosh PATH_BOSH PATH_HTDOCS PATH_SCRIPT
run () {
    echo "$@"
    $@
}


defaultpath=$2
boshpath="$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
scriptpath="$(cd "$(dirname "$3")" && pwd)/$(basename "$3")"


sites=$(find $defaultpath  -maxdepth 1 -type d)
for site in $sites; do
    (
        cd $site
        if [[ -r config.ini ]]
        then
            echo "$site:"
            $boshpath exec $scriptpath
            echo ""
        fi
    )
done
