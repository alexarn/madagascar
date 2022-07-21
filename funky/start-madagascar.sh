#!/bin/sh
/usr/bin/tmux -f /opt/madagascar/funky/madagascar.conf -S /var/tmux/madagascar new-session -d
chmod g+rw /var/tmux/madagascar
