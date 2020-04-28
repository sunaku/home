#!/bin/sh -x

# appearance
. ~/.xprofile
devilspie2 &

# touchpad
# https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Using_syndaemon
# synclient TapButton1=1 TapButton2=3 TapButton3=2 HorizTwoFingerScroll=1 PalmDetect=1
pgrep -x syndaemon || syndaemon -i 1 -t -K -R -d

# terminal
kitty sh -c 'if tmux has-session; then tmux attach -d; else tmux; fi' &

# window manager
exec startlxqt
