<?php

exec('rsync -avz webmaster@172.16.77.43:www/htdocs/astrolabe-melun.fr/userfiles/ /home/stl/htdocs/wip/astrolabe-melun.fr/userfiles');
exec('rsync -avz webmaster@172.16.77.53:www/htdocs/calice68.fr/userfiles/ /var/www/html/vhosts/opac2/www/htdocs/wip/calice68.fr/userfiles');
exec('rsync -avz webmaster@172.16.77.44:www/htdocs/institutfrancais-roumanie.com/userfiles/ /var/www/html/vhosts/opac2/www/htdocs/wip/institutfrancais-roumanie.com/userfiles');
/*
alias sshsvc="ssh webmaster@172.16.77.19"
alias sshsrv2="ssh webmaster@172.16.77.32"
*/



?>