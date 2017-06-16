#!/bin/sh
cd ~/www/php/
git pull --rebase
source ./install.sh


directories=`find  -P ~/www/htdocs/  -maxdepth 2 -type d -path "*/cosmogramme" `
for dir in $directories
do
	echo "patch: $dir"
	cd $dir 
	php php/upgrade_db.php
done


directories=`find  -P ~/www/htdocs/  -maxdepth 3 -type d -path "*/skins/*"`
for dir in $directories
do
	echo "update skin for: $dir"
	cd $dir;
	git  pull --rebase;
done

             
sudo /etc/init.d/httpd restart

