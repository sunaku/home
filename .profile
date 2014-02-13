#!/bin/sh

# start X when logging into the first Virtual Terminal
# https://wiki.archlinux.org/index.php/Start_X_at_Login
test -z "$DISPLAY" -a "$(tty)" = /dev/tty1 && exec startx

. ~/.pathrc
export LANG=en_US.utf8
export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR=$HOME/get
export XAUTHORITY=$HOME/.Xauthority
