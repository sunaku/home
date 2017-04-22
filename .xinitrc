#!/bin/sh
# IMPORTANT: This file must be run from a login shell so
# that ~/.profile (which sets up the $PATH) is sourced
# before this point.  Otherwise, this script might fail
# because the programs it executes might not be found.

killall=
. ~/.profile

# hardware
laptop-display
laptop-reactor &

# appearance
. ~/.xprofile

# desktop
test -z "$DBUS_SESSION_BUS_ADDRESS" &&
eval $(dbus-launch --sh-syntax --exit-with-session)
killall="dbus-daemon $killall"

# encryption
eval $(gpg-agent --daemon) &&
killall="gpg-agent $killall"

# input method
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=scim
export QT_IM_MODULE=scim
scim -d &

# desktop apps
workrave &                      # health
redshift-gtk &                  # f.lux
pasystray &                     # sound
killall="pulseaudio $killall"
# mpc || mpd &                  # music
system-config-printer-applet &  # printer
blueman-applet &                # bluetooth
wpa_gui -t &                    # network
claws-mail &                    # email
st -e sh -c '
  tmux has-session &&
  tmux attach -d ||
  tmux
' &                             # shell

# system logs
xterm -fg '#ecbcbc' -bg '#41363c' -sl 4096 -e '
  tail -f /var/log/*.log ~/.xsession-errors &
  dmesg --follow --human --nopager
' &

# window manager
export BSPWM_STATE=/tmp/bspwm-state.json
while :; do bspwm
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 10 \
  -center || break
  . ~/.pathrc # pick up $PATH changes
done
rm -f "$BSPWM_STATE"
killall="bspwm-panel panel $killall"

# kill daemons
test -n "$killall" && killall $killall
