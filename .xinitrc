#!/bin/sh

cd # start in home directory

# X server
xrdb -merge ~/.Xdefaults

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
xterm -e tail -f ~/.wmii-hg/wmiirc.log &

while true
do
  wmii
  xmessage 'Restart the Window Manager?' \
           -buttons 'Yes:1,No:0' -center \
           -default 'Yes' -timeout 30    \
  && break
done

# clean up
test $GPG_AGENT_INFO && killall gpg-agent
