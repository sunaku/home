#!/bin/sh -x

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
# desktop
#-----------------------------------------------------------------------------

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
