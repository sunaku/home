#!/bin/sh
# IMPORTANT: This file must be run from a login shell so
# that ~/.profile (which sets up the $PATH) is sourced
# before this point.  Otherwise, this script might fail
# because the programs it executes might not be found.

. ~/.profile

# hardware
laptop-display
laptop-reactor &

# appearance
xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/TTF
xset +fp ~/.fonts/tamzen-font/bdf
xset fp rehash
xrdb -merge ~/.Xdefaults
export FONT=$(xrdb -query | awk '$1 == "*font:" { print $2; exit }')

# desktop
test -z "$DBUS_SESSION_BUS_ADDRESS" &&
eval $(dbus-launch --sh-syntax --exit-with-session)

# encryption
eval $(gpg-agent --daemon) &&
trap 'killall gpg-agent' EXIT

# input method
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=scim
export QT_IM_MODULE=scim
scim -d &

# system logs
xterm -fg '#ecbcbc' -bg '#41363c' -sl 4096 -e '
  tail -f /var/log/*.log \
      ~/.xsession-errors \
      ~/.wmii/wmiirc.log &
  dmesg -wHP
' &

# window manager
while xterm & do wmii
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 10 \
  -center || break
  . ~/.pathrc # pick up $PATH changes
done
