#!/bin/sh
set -x

cd # start in home directory

# appearance
xrdb -merge ~/.Xdefaults

# hardware
left-mouse # left-handed mouse
thunar --daemon &

# encryption
eval $(gpg-agent --daemon)

# input methods
#export XMODIFIERS='@im=SCIM'
#export GTK_IM_MODULE=scim
#export QT_IM_MODULE=scim
#scim -d &

# GNOME stuff
#test -z $DBUS_SESSION_BUS_ADDRESS &&
#eval $(dbus-launch --sh-syntax --exit-with-session)

# break reminder
workrave &
#xwrits breaktime=1:30 typetime=30:00 +mouse +lock +beep &

# music
xterm -geometry 14x23+8+0 -e alsamixer &
mpc || mpd &
sonata &

# window manager
xterm -e tail -f ~/.wmii/wmiirc.log &

while true; do
  # the ck-launch-session is for proper automounting of USB drives
  # see http://bbs.archlinux.org/viewtopic.php?id=84635&p=3
  ck-launch-session wmii
  xmessage 'Restart the Window Manager?' \
           -buttons 'Yes:1,No:0' -center \
           -default 'Yes' -timeout 30    \
  && break
done

# clean up
test $GPG_AGENT_INFO && killall gpg-agent
