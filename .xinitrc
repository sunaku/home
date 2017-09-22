#!/bin/sh -x

daemons=
trap 'killall $daemons' EXIT TERM INT

#-----------------------------------------------------------------------------
# appearance
#-----------------------------------------------------------------------------

# fonts
xset +fp ~/.fonts/tamzen-font/bdf
xset fp rehash

# resources
xrdb -merge ~/.Xdefaults
export FONT=$(xrdb -query | awk '$1 == "*font:" { print $2; exit }')

# pointer
xsetroot -cursor_name left_ptr

# subpixel hinting
# https://github.com/voidlinux/void-packages/issues/4444
export FREETYPE_PROPERTIES='truetype:interpreter-version=35'

#-----------------------------------------------------------------------------
# services
#-----------------------------------------------------------------------------

# hardware
laptop-display
laptop-reactor &

# encryption
eval $(gpg-agent --daemon) &&
daemons="gpg-agent $daemons"

# notification
test -z "$DBUS_SESSION_BUS_ADDRESS" &&
eval $(dbus-launch --sh-syntax --exit-with-session) &&
daemons="dbus-daemon $daemons"

# input method
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=scim
export QT_IM_MODULE=scim
scim -d &

#-----------------------------------------------------------------------------
# desktop
#-----------------------------------------------------------------------------

redshift-gtk &                  # f.lux
workrave &                      # health
pasystray &                     # sound
daemons="pulseaudio $daemons"
mpc || mpd &                    # music
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
rm -f $BSPWM_STATE
