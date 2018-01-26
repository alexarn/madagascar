#!/bin/sh

cd ~/www/php/
git pull --rebase
# source to stop execution if install.sh exits with error
source ./install.sh

#echo "archiving stable"
#tar -czf ~/www/htdocs-mutu/bokeh-library-portal.org/userfiles/bokeh-stable.tgz --exclude-vcs --exclude=*/local.php --exclude=*/config.{php,ini} --totals bokeh-stable
#echo "archiving development"
#tar -czf ~/www/htdocs-mutu/bokeh-library-portal.org/userfiles/bokeh-development.tgz --exclude-vcs --exclude=*/local.php --exclude=*/config.{php,ini} --totals bokeh-development

### Màj des Bokeh dédiés ###
#
directories=$(find  -P ~/www/htdocs-dedi/  -maxdepth 2 -type d -path "*/cosmogramme")
for dir in $directories
do
        echo "patch: $dir"
        cd $dir
        php php/upgrade_db.php
done

directories=$(find  -P ~/www/htdocs-dedi/ -maxdepth 3 -type d -path "*/skins/*")
for dir in $directories
do
        echo "update skin for: $dir"
        cd $dir;
        git  pull --rebase;
done

### Màj des Bokeh mutus ###
#
directories=$(find  -P ~/www/htdocs-mutu/  -maxdepth 2 -type d -path "*/cosmogramme")
for dir in $directories
do
        echo "patch: $dir"
        cd $dir
        php php/upgrade_db.php
done

directories=$(find  -P ~/www/htdocs-mutu/ -maxdepth 3 -type d -path "*/skins/*")
for dir in $directories
do
        echo "update skin for: $dir"
        cd $dir;
        git  pull --rebase;
done

sudo ansible-playbook /etc/ansible/playbooks/restart_bokeh_services.yml
