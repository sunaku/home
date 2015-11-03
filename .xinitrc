#!/bin/sh
# IMPORTANT: This file must be run from a login shell so
# that ~/.profile (which sets up the $PATH) is sourced
# before this point.  Otherwise, this script might fail
# because the programs it executes might not be found.

. ~/.profile

# hardware
acer-c720-dock
acer-c720-reactor &

# appearance
xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/TTF
xset +fp /usr/share/fonts/OTF
xset +fp ~/.fonts/tamzen-font/bdf
# xset +fp ~/.fonts
xset fp rehash
xrdb -merge ~/.Xdefaults

# # encryption
# eval `gpg-agent --daemon` &&
# trap 'killall gpg-agent' EXIT

# dbus (for libnotify and other stuff)
test -n "$DBUS_SESSION_BUS_ADDRESS" ||
eval `dbus-launch --sh-syntax --exit-with-session`

# # input methods
# export XMODIFIERS='@im=SCIM'
# export GTK_IM_MODULE=scim
# export QT_IM_MODULE=scim
# scim -d &

# screen locking
xautolock -time 10 -locker admit1 acer-c720-lock &

# break reminder
# xwrits typetime=25 breaktime=1 +mouse +top &
# workrave &

# system status
xterm -fg '#ecbcbc' -bg '#41363c' -sl 4096 -e \
  'tail -f /var/log/*.log & dmesg -wHP' &

# window manager
while xterm & do bspwm
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 30 \
  -center || break
  . ~/.pathrc # pick up $PATH changes
done
