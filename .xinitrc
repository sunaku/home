#!/bin/sh
# IMPORTANT: This file must be run from a login shell so
# that ~/.profile (which sets up the $PATH) is sourced
# before this point.  Otherwise, this script might fail
# because the programs it executes might not be found.

. ~/.profile

# hardware
marble-mouse left

# appearance
xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp /usr/share/fonts/local
xset +fp ~/.fonts
xset fp rehash
xrdb ~/.Xdefaults

# encryption
eval `gpg-agent --daemon` &&
trap 'killall gpg-agent' EXIT

# dbus (for libnotify and other stuff)
test -z "$DBUS_SESSION_BUS_ADDRESS" &&
eval `dbus-launch --sh-syntax --exit-with-session`

# input methods
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=scim
export QT_IM_MODULE=scim
scim -d &

# automatic locking
xscreensaver -no-splash &

# break reminder
xwrits typetime=25 breaktime=1 +mouse +top &

# window manager
xterm -fg '#ecbcbc' -bg '#41363c' -e tail -f /var/log/*.log &
while xterm & do wm2
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 30 \
  -center || break
  . ~/.pathrc # pick up PATH changes
done
