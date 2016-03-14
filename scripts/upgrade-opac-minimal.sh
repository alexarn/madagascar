#!/bin/sh
cd ~/www/php/
git pull --rebase
source ./install.sh

if [ -f "/etc/init.d/httpd" ]
then
  sudo /etc/init.d/httpd restart
fi
