#!/bin/sh

# Paramètre les cosmogrammes sur sandbox

run () {
        echo "$@" 
        $@
}

sites=$(find . -maxdepth 1 -type d)
for site in $sites; do
        echo "Setup cosmogramme for $site" 
        cosmodir="$site/cosmogramme" 
        if [ -L "$cosmodir" ]; then
                run rm "$cosmodir" 
                run mkdir "$cosmodir" 
                dest=$(dirname $(readlink -nf "$site/index.php"))
                run ln -sfv "$dest"/cosmogramme/* "$dest"/cosmogramme/.* "$cosmodir/" 
                run cp -f "$cosmodir/config.ref.php" "$cosmodir/config.php" 
                dbname=$(echo $(grep dbname "$site/config.ini" | cut -d= -f2))
                run sed -i "s/integration_base=.*/integration_base=$dbname/" "$cosmodir/config.php" 
                run sed -i "s/integration_pwd=.*/integration_pwd=root/" "$cosmodir/config.php" 
        else
                echo "Nothing to do" 
        fi
        echo "" 
done
