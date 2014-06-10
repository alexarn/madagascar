#!/bin/sh
cd ~/www/php/
git pull --rebase
source ./install.sh


directories=`find  -P ~/www/htdocs/  -maxdepth 4 -type d -path "*/skins/*/.git" | sed "s/.git//g"`
for dir in $directories
do
	echo "update skin for: $dir"
	cd $dir;
	git  pull --rebase;
done

directories=`find  -P ~/www/htdocs/  -maxdepth 2 -type d -path "*/cosmogramme" `
for dir in $directories
do
	echo "patch: $dir"
	cd $dir 
	php php/upgrade_db.php
done

             
sudo /etc/init.d/httpd restart

