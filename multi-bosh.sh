#!/bin/sh


sites=$(find /var/www/html/vhosts/opac2/www/htdocs  -maxdepth 1 -type d)
for site in $sites; do
    echo bosh $1
done

