<?php

$user="webmaster";
$server_ip="172.16.77.43";
exec('rsync -avz webmaster@172.16.77.43:www/htdocs/astrolabe-melun.fr/userfiles/ /home/stl/htdocs/wip/astrolabe-melun.fr/userfiles');
exec('rsync -avz webmaster@172.16.77.53:www/htdocs/calice68.fr/userfiles/ /home/stl/htdocs/wip/calice68.fr/userfiles');
/*#alias sshifr="ssh webmaster@172.16.77.44"
#alias sshsvc="ssh webmaster@172.16.77.19"
alias sshcg68="ssh webmaster@172.16.77.53"
alias sshsrv2="ssh webmaster@172.16.77.32"
*/



?>