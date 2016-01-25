#!/bin/sh
cd ~/www/php/
git pull --rebase
source ./install.sh

sudo /etc/init.d/httpd restart
