#!/bin/sh -x

# appearance
. ~/.xprofile
devilspie2 &

# terminal
kitty sh -c 'if tmux has-session; then tmux attach -d; else tmux; fi' &

# system logs
xterm -fg '#ecbcbc' -bg '#41363c' -sl 4096 +sb \
-e 'tail -F /var/log/*.log ~/.xsession-errors' &

# window manager
while :; do startxfce4
  xmessage 'INSERT COIN TO CONTINUE' \
  -buttons 'Insert Coin:0,Game Over' \
  -default 'Insert Coin' -timeout 10 \
  -center || break
done
