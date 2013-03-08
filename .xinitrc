#!/bin/sh
# IMPORTANT: This file must be run from a login shell so
# that ~/.profile (which sets up the $PATH) is sourced
# before this point.  Otherwise, this script might fail
# because the programs it executes might not be found.

. ~/.profile

# execute the rest of this file under the ConsoleKit environment
sed '1,/^sed/d' "$0" | ck-launch-session sh -x; exit

# hardware
marble-mouse left
nvidia-settings --load-config-only

# appearance
xsetroot -cursor_name left_ptr
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp /usr/share/fonts/local
xset +fp ~/.fonts
xset fp rehash
xrdb ~/.Xdefaults

## encryption
#eval `gpg-agent --daemon` &&
#trap 'killall gpg-agent' EXIT

# dbus (for libnotify and other stuff)
test -z "$DBUS_SESSION_BUS_ADDRESS" &&
eval `dbus-launch --sh-syntax --exit-with-session`

# network
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#nm-applet --sm-disable &
wicd-gtk --tray &

# touchpad
# http://wiki.archlinux.org/index.php/Touchpad_Synaptics
#syndaemon -t -k -i 2 -d &
#synclient HorizTwoFingerScroll=1 TapButton2=3 TapButton3=2

# input methods
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=scim
export QT_IM_MODULE=scim
scim -d &

# automatic locking
xscreensaver -no-splash &

# break reminder
xwrits typetime=25 breaktime=1 +mouse +top &

# music
mpc || mpd &

# window manager
urxvt -fg \#ecbcbc -bg \#41363c -e tail -f ~/.wmii/wmiirc.log /var/log/*.log &
while true; do wmii
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 30 \
  -center || break
  . ~/.pathrc # pick up PATH changes
done
