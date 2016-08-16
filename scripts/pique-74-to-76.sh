#!/bin/env bash

if [ -z $1 ]; then
    echo "\nNo path given !\n"
    exit 1
fi
    

exec_path="$( cd "$( dirname "$0" )" && pwd )"
client_dir="$( cd $1 && pwd )"
deploy_dir="/var/www/html/vhosts/opac2/www/htdocs/opac-deploy/"
pique_dir="/var/www/html/vhosts/opac2/www/htdocs/pique/"
client_basename="$( basename "$client_dir" )"
bokeh_url="http://wip.pergame.net/$client_basename"

dbname=`sed -n "s/sgbd.config.dbname *= *\([^[:space:]]\)/\1/p" $client_dir/config.ini|tr -d '\r'`

function piqueOnStable() {
    echo "Remove pique screenshots"
    rm -rf $pique_dir/temp/*$client_basename*

    echo "Go to stable"
    rm $client_dir/development

    bash $deploy_dir/restore-blessed.sh $client_dir
    echo "Dump database: ${dbname} et."
    bash $exec_path/dump_db ${dbname}


    echo "Prepare for pique"
    cd $client_dir
    php $exec_path/pique-prepare.php


    echo "Pique for stable: $bokeh_url"
    cd $pique_dir
    php checkByUrls.php $bokeh_url
}


function piqueOnDevelopment() {
    echo "Go to development"
    touch $client_dir/development
    bash $deploy_dir/restore-blessed.sh $client_dir
    cd $client_dir
    php $deploy_dir/php/set_patch_level.php
    php $deploy_dir/bokeh-development/scripts/upgrade_db.php
    php $exec_path/pique-prepare.php

    echo "Pique for development: $bokeh_url"
    cd $pique_dir
    php checkByUrls.php $bokeh_url
}


piqueOnStable
piqueOnDevelopment

echo "Install Pique navigation"
cp $pique_dir/index.php $pique_dir/temp/
cd $pique_dir/temp/
bash ../thumbnailize.sh

echo "Finished. Visit: http://sandbox.pergame.net/pique/temp"
