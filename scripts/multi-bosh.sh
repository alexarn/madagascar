#!/bin/bash
# use : bash ./multi-bosh PATH_BOSH PATH_HTDOCS PATH_SCRIPT
# opac mutu :  bash ./multi-bosh.sh "/var/www/html/vhosts/opac2/www/php/bosh/bosh.php" "/var/www/html/vhosts/opac2/www/htdocs" "/var/www/html/vhosts/opac2/www/php/test.php"
# wip: bash ./multi-bosh.sh "/var/www/html/vhosts/opac2/www/htdocs/stl/bosh/bosh.php" "/var/www/html/vhosts/opac2/www/htdocs/wip" test.php
run () {
    echo "$@"
    $@
}

boshpath=$1
defaultpath=$2

sites=$(find $defaultpath  -maxdepth 1 -type d)
for site in $sites; do
    cd $site
    if [[ -r config.ini ]]
    then
       $boshpath exec $3 
    fi
done

