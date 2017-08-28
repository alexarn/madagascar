#!/bin/env bash

function createAndPique() {
    local bokeh=$1

    if [ ! -f "$bokeh/development" ]
    then
        bash /home/webmaster/www/php/create-wip.sh $bokeh /home/webmaster/www/htdocs-local/
        bash /home/madagascar/madagascar/scripts/pique-76-to-78.sh "/home/webmaster/www/htdocs-local/"`basename $bokeh`
    fi
}

directories=`find -P /home/webmaster/www/htdocs-*-remote/ -maxdepth 1 -mindepth 1|sort`

for dir in $directories
do
    echo $dir
    createAndPique $dir
done
