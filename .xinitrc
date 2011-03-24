# IMPORTANT: This file must be run from a login shell so
# that ~/.profile (which sets up the $PATH) is sourced
# before this point.  Otherwise, this script might fail
# because the programs it executes might not be found.

# appearance
xrdb ~/.Xresources

# dbus (needed by networkmanager and other stuff)
test -z "$DBUS_SESSION_BUS_ADDRESS" &&
eval `dbus-launch --sh-syntax --exit-with-session`

# network
nm-applet --sm-disable &

# touchpad
# http://wiki.archlinux.org/index.php/Touchpad_Synaptics
syndaemon -t -k -i 2 -d &
synclient HorizTwoFingerScroll=1 TapButton2=3 TapButton3=2

# input methods
export XMODIFIERS='@im=SCIM'
export GTK_IM_MODULE=scim
export QT_IM_MODULE=scim
scim -d &

# break reminder
xwrits breaktime=1:30 typetime=30 +mouse +multiply=5:1.4 +top &

# music
mpc || mpd &
sonata &

# notes
zim &

# window manager
xterm -e tail -F ~/.wmii/wmiirc.log &

while true; do
  ck-launch-session wmii
  xmessage 'Do you really want to quit wmii?' \
           -buttons 'Yes:0,No:1' -center \
           -default 'No' -timeout 30 \
  && break
done
