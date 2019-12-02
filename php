#!/bin/bash
me=$(whoami)
pwd=$(pwd)
dockerpath=${pwd/\/opt\/workplace/\/home\/webmaster}
#command="docker exec -w /home/webmaster/${me}/php/bokeh/ -it ${me}-bokeh-php-71-dev su webmaster -c \"php $*\""
command="docker exec -w ${dockerpath} -it ${me}-bokeh-php-71-dev su webmaster -c \"php $*\""

echo -e "\n${command}\n"

eval $command


