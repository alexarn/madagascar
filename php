#!/bin/bash
me=$(whoami)
command="docker exec -w /home/webmaster/${me}/php/bokeh/ -it ${me}-bokeh-php-71-dev su webmaster -c \"php $*\""

echo -e "\n${command}\n"

eval $command


