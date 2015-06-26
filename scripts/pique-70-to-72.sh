#!/bin/env bash

if [ -z $1 ]; then
    printf "\nNo path given !\n"
    exit 1
fi
    

exec_path="$( cd "$( dirname "$0" )" && pwd )"
client_dir=$1
deploy_dir="/var/www/html/vhosts/opac2/www/htdocs/opac-deploy/"
pique_dir="/var/www/html/vhosts/opac2/www/htdocs/pique/"
client_basename="$( basename "$client_dir" )"
bokeh_url="http://wip.pergame.net/$client_basename"

dbname=`sed -n "s/sgbd.config.dbname *= *\([^ ]\)/\1/p" $client_dir/config.ini`

printf "\nRemove pique screenshots\n"
rm -rf $pique_dir/temp/*$client_basename*

printf "\nGo to stable\n"
rm $client_dir/development

bash $deploy_dir/restore-blessed.sh $client_dir

printf "\nDump database: $dbname \n"
bash $exec_path/dump_db $dbname


printf "\nPrepare for pique\n"
cd $client_dir
php $exec_path/pique-prepare.php


printf "\nPique for stable: $bokeh_url\n"
cd $pique_dir
php checkByUrls.php $bokeh_url


printf "\nGo to development\n"
touch $client_dir/development
bash $deploy_dir/restore-blessed.sh $client_dir


printf "\nPique for development: $bokeh_url\n"
cd $pique_dir
php checkByUrls.php $bokeh_url


printf "\nInstall Pique navigation\n"
cp $pique_dir/index.php $pique_dir/temp/
cd $pique_dir/temp/
bash ../thumbnailize.sh

printf "\nFinished. Visit: http://sandbox.pergame.net/pique/temp\n"
