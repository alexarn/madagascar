#!/bin/bash

rsync -avz webmaster@172.16.77.43:www/htdocs/astrolabe-melun.fr/userfiles/ /var/www/html/vhosts/opac2/www/htdocs/wip/astrolabe-melun.fr/userfiles;
rsync -avz webmaster@172.16.77.53:www/htdocs/calice68.fr/userfiles/ /var/www/html/vhosts/opac2/www/htdocs/wip/calice68.fr/userfiles;
rsync -avz webmaster@172.16.77.44:www/htdocs/institutfrancais-roumanie.com/userfiles/ /var/www/html/vhosts/opac2/www/htdocs/wip/institutfrancais-roumanie.com/userfiles;
