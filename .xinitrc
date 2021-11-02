#!/bin/sh -x

# style
unset QT_STYLE_OVERRIDE

# fonts
xset +fp ~/.fonts/tamzen-font/bdf
xset fp rehash

# resources
xrdb -merge ~/.Xdefaults
export FONT=$(xrdb -query | awk '$1 == "*font:" { print $2; exit }')

# pointer
xsetroot -cursor_name left_ptr

# touchpad
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Using_syndaemon
# synclient TapButton1=1 TapButton2=3 TapButton3=2 HorizTwoFingerScroll=1 PalmDetect=1
pgrep -x syndaemon || syndaemon -i 1 -t -K -R -d

# terminal
kitty sh -c 'if tmux has-session; then tmux attach -d; else tmux; fi' &

# window manager
devilspie -a -d &
exec startxfce4
