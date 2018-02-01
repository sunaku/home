#!/bin/sh -x

# appearance
. ~/.xprofile

# terminal
st -e sh -c 'tmux has-session && tmux attach -d || tmux' &

# system logs
xterm -fg '#ecbcbc' -bg '#41363c' -sl 4096 +sb \
-e 'tail -F /var/log/*.log ~/.xsession-errors' &

# window manager
while :; do i3
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 10 \
  -center || break
done
