#!/bin/env bash

if [ -z $1 ]; then
    echo -e "\nNo path given !\n"
    exit 1
fi

if [ -z $2 ]; then
    echo -e "\nNo branch given !\n"
    exit 1
fi

branch=$2
exec_path="$( cd "$( dirname "$0" )" && pwd )"
client_dir="$( cd $1 && pwd )"
client_basename="$( basename $client_dir )"
deploy_dir="/home/webmaster/www/php/"
pique_dir="/home/webmaster/www/htdocs-local/pique/"
client_basename="$( basename "$client_dir" )"
bokeh_url="http://sandbox.afi-sa.fr/$client_basename"

dbname=`sed -n "s/sgbd.config.dbname *= *\([^[:space:]]\)/\1/p" $client_dir/config.ini|tr -d '\r'`


function prepare() {
    echo -e "\n\nRemove pique screenshots"
    rm -rf $pique_dir/temp/*$client_basename* > /dev/null

    echo -e "\nDump database: ${dbname}"
    bash $exec_path/dump_db ${dbname}
}


function piqueOnBranch() {
    branch_to_go=$1
    echo -e "\n\nGo to branch $branch_to_go"

    bash $deploy_dir/install-branch.sh $branch_to_go $client_dir 
    
    echo -e "\nPrepare $client_dir for pique"
    cd $client_dir
    ln -s /home/webmaster/www/php/branches/WIP/scripts/inject_bokeh_url.php scripts/
    php $deploy_dir/php/set_patch_level.php
    php $deploy_dir/bokeh-development/scripts/upgrade_db.php
    php scripts/inject_bokeh_url.php $client_basename
    php $exec_path/pique-prepare.php

    echo -e "\nPique for $branch_to_go : $bokeh_url"
    cd $pique_dir
    php checkByUrls.php $bokeh_url
    rm -f "$client_dir/scripts/inject_bokeh_url.php" > /dev/null
}


prepare
piqueOnBranch "master"
piqueOnBranch "$branch"

echo -e "\nInstall Pique navigation"
cp $pique_dir/index.php $pique_dir/temp/
cd $pique_dir/temp/
bash ../thumbnailize.sh

echo -e "\n\nFinished. Visit: http://sandbox.afi-sa.net/pique/temp/"
