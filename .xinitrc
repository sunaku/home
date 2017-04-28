#!/bin/sh

daemons=

# hardware
laptop-display
laptop-reactor &

# appearance
. ~/.xprofile

# desktop
test -z "$DBUS_SESSION_BUS_ADDRESS" &&
eval $(dbus-launch --sh-syntax --exit-with-session) &&
daemons="dbus-daemon $daemons"

# encryption
eval $(gpg-agent --daemon) &&
daemons="gpg-agent $daemons"

# input method
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=scim
export QT_IM_MODULE=scim
scim -d &

# desktop apps
redshift-gtk &                  # f.lux
workrave &                      # health
pasystray &                     # sound
daemons="pulseaudio $daemons"
# mpc || mpd &                  # music
system-config-printer-applet &  # printer
blueman-applet &                # bluetooth
wpa_gui -t &                    # wifi
claws-mail &                    # email
st -e sh -c '
  tmux has-session &&
  tmux attach -d ||
  tmux
' &                             # shell

# system logs
xterm -fg '#ecbcbc' -bg '#41363c' -sl 4096 +sb \
-e 'tail -F /var/log/*.log ~/.xsession-errors' &

# window manager
export BSPWM_STATE=/tmp/bspwm-state.json
while :; do bspwm
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 10 \
  -center || break
done
rm -f "$BSPWM_STATE"

# kill daemons
test -n "$daemons" && killall $daemons
